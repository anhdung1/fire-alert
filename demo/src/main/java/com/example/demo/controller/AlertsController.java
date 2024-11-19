package com.example.demo.controller;

import com.example.demo.service.AlertsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/alerts")
public class AlertsController {
    @Autowired
    AlertsService alertsService;
    @GetMapping("/history")
    public ResponseEntity<?> getHistoryAlerts(){
        return ResponseEntity.ok(alertsService.getAlertsResponse());
    }
}
