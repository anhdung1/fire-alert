package com.example.demo.controller;

import com.example.demo.DTO.NotificationsDTO;
import com.example.demo.service.FirebaseMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping
public class FirebaseNotificationController {

    @Autowired
    private FirebaseMessageService firebaseMessageService;

    @PostMapping("/send")
    public String sendNotification(@RequestBody NotificationsDTO notification) {
        return firebaseMessageService.sendNotification(notification.getTitle()  , notification.getBody(), notification.getToken());
    }
}
