package com.example.demo.controller;

import com.example.demo.service.SensorsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/sensors")
public class SensorsController {
    @Autowired
    private SensorsService sensorsService;
    @GetMapping
    public ResponseEntity<?> getTopic(){
        List<String> topics= sensorsService.getSensorsRepository().findAllTopics();
        if(topics.isEmpty()){ return ResponseEntity.ok(topics);}
        return ResponseEntity.notFound().build();

    }
}
