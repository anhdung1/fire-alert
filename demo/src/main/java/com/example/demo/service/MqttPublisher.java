package com.example.demo.service;

import com.example.demo.DTO.SensorsRequest;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.eclipse.paho.client.mqttv3.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Service
public class MqttPublisher {
    private final String BROKER_URL = "tcp://localhost:1883";
    private final String CLIENT_ID = "spring-boot-client";
    private final AlertsService alertsService;
    private MqttClient mqttClient;
    private final SensorsService sensorsService;
    private final Map<String, Long> lastMessageTimeByTopic = new HashMap<>();
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    public MqttPublisher(SensorsService sensorsService, AlertsService alertsService) {
        this.sensorsService = sensorsService;
        this.alertsService = alertsService;
        startConnectionChecker();
    }

    private void connectToMqttBroker() {
        try {
            mqttClient = new MqttClient(BROKER_URL, CLIENT_ID);
            MqttConnectOptions options = new MqttConnectOptions();
            options.setCleanSession(true);
            mqttClient.connect(options);
            System.out.println("Connected to MQTT broker successfully.");

            mqttClient.setCallback(new MqttCallback() {
                @Override
                public void connectionLost(Throwable cause) {
                    System.out.println("Connection lost: " + cause.getMessage());
                }

                @Override
                public void messageArrived(String topic, MqttMessage message) {
                    String json = new String(message.getPayload());
                    System.out.println("Received message from topic " + topic + ": " + json);
                    lastMessageTimeByTopic.put(topic, System.currentTimeMillis());
                    try {
                        SensorsRequest sensorsRequest = objectMapper.readValue(json, SensorsRequest.class);
                        if (sensorsRequest.getFire()) {
                            alertsService.save(sensorsRequest.getFire(), sensorsRequest.getPpm(), topic);
                        }
                    } catch (JsonProcessingException e) {
                        System.out.println("Invalid JSON format");
                    }
                }

                @Override
                public void deliveryComplete(IMqttDeliveryToken token) {
                }
            });

            startConnectionCheckerToTopic();
            subscribeToTopics();
        } catch (Exception e) {
            System.out.println("Error: " + e.toString());

        }
    }

    private void subscribeToTopics() {
        try {
            List<String> topics = sensorsService.getSensorsRepository().findAllTopics();
            for (String topic : topics) {
                mqttClient.subscribe(topic, 0);
                System.out.println("Subscribed to topic: " + topic);
            }
        } catch (MqttException e) {
            System.out.println("Error subscribing to topics: " + e.getMessage());
        }
    }

    private void startConnectionCheckerToTopic() {
        scheduler.scheduleAtFixedRate(() -> {
            long currentTime = System.currentTimeMillis();
            lastMessageTimeByTopic.entrySet().removeIf(entry -> {
                String topic = entry.getKey();
                long messageTime = entry.getValue();
                if (currentTime - messageTime > 30000) {
                    System.out.println("Lost connection to topic: " + topic);
                    try {
                        mqttClient.subscribe(topic, 0);
                    } catch (MqttException e) {
                        System.out.println("Failed to reconnect to topic: " + topic);
                    }
                    return true;
                }
                return false;
            });
        }, 0, 30, TimeUnit.SECONDS);
    }

    private void startConnectionChecker() {
        scheduler.scheduleAtFixedRate(() -> {
            if (mqttClient == null || !mqttClient.isConnected()) {
                System.out.println("Đang kết nối tới Broker");
                connectToMqttBroker();
            }
        }, 0, 30, TimeUnit.MINUTES);
    }
}
