//package com.example.demo.controller;
//import com.example.demo.service.MqttService;
//import org.eclipse.paho.client.mqttv3.MqttException;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//
//@RestController
//public class MqttController {
//
//    @Autowired
//    private MqttService mqttService;
//
//    @GetMapping("/publish")
//    public String publishMessage(@RequestParam String topic, @RequestParam String message) {
//        try {
//            mqttService.publish(topic, message, 1, false);
//            return "Message published successfully!";
//        } catch (MqttException e) {
//            e.printStackTrace();
//            return "Failed to publish message";
//        }
//    }
//
//    @GetMapping("/subscribe")
//    public String subscribeTopic(@RequestParam String topic) {
//        try {
//            mqttService.subscribe(topic);
//            return "Subscribed to topic: " + topic;
//        } catch (MqttException e) {
//            e.printStackTrace();
//            return "Failed to subscribe to topic";
//        }
//    }
//}
