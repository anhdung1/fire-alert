package com.example.demo.controller;
import com.example.demo.service.MqttPublisher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class MqttController {

    @Autowired
    private MqttPublisher mqttPublisher;

}

