//package com.example.demo.config;
//
//import org.eclipse.paho.client.mqttv3.IMqttClient;
//import org.eclipse.paho.client.mqttv3.MqttClient;
//import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
//import org.eclipse.paho.client.mqttv3.MqttException;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//@Configuration
//public class MqttConfig {
//
//    private static final String MQTT_BROKER = "tcp://localhost:1883"; // Thay bằng địa chỉ broker của bạn
//    private static final String CLIENT_ID = "springBootClient";
//    private static final String USERNAME = "yourUsername";
//    private static final String PASSWORD = "yourPassword";
//
//    @Bean
//    public IMqttClient mqttClient() throws MqttException {
//        IMqttClient client = new MqttClient(MQTT_BROKER, CLIENT_ID);
//        MqttConnectOptions options = new MqttConnectOptions();
//        options.setCleanSession(true);
//        options.setUserName(USERNAME);
//        options.setPassword(PASSWORD.toCharArray());
//
//        client.connect(options);
//        return client;
//    }
//}