package com.example.demo.controller;

import com.example.demo.DTO.LoginRequest;

import com.example.demo.service.AuthService;
import com.example.demo.service.SensorsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AuthService authService;
    @Autowired
    private SensorsService sensorsService;
    @GetMapping
    public ResponseEntity<?> getAdmin() {

        return ResponseEntity.ok("OK");
    }
    @GetMapping("all-topic")
    public ResponseEntity<?> getAllTopics() {

        return ResponseEntity.ok(sensorsService.getAllSensors());
    }
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody LoginRequest loginRequest) {
        try {
            authService.createUser(loginRequest.getUsername(), loginRequest.getPassword(),loginRequest.getPhoneNumber());
            return ResponseEntity.ok("The account has been created successfully");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }
}
