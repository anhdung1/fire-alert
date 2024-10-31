//package com.example.demo.service;
//
//import org.eclipse.paho.client.mqttv3.IMqttClient;
//import org.eclipse.paho.client.mqttv3.MqttException;
//import org.eclipse.paho.client.mqttv3.MqttMessage;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//@Service
//public class MqttService {
//
//    @Autowired
//    private IMqttClient mqttClient;
//
//    public void publish(String topic, String payload, int qos, boolean retained) throws MqttException {
//        MqttMessage message = new MqttMessage();
//        message.setPayload(payload.getBytes());
//        message.setQos(qos);
//        message.setRetained(retained);
//        mqttClient.publish(topic, message);
//    }
//
//    public void subscribe(String topic) throws MqttException {
//        mqttClient.subscribe(topic, (topicReceived, msg) -> {
//            String message = new String(msg.getPayload());
//            System.out.println("Received message: " + message + " from topic: " + topicReceived);
//        });
//    }
//}
