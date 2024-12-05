package com.example.demo.controller;

import com.example.demo.DTO.DeviceTokensRequest;
import com.example.demo.model.Users;
import com.example.demo.service.DeviceTokensService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/device-token")
public class DeviceTokensController {
    @Autowired
    DeviceTokensService deviceTokensService;
    @PostMapping("/send")
    public ResponseEntity<?> sendDeviceTokens(@RequestBody DeviceTokensRequest device){
        Authentication authentication= SecurityContextHolder.getContext().getAuthentication();
        Users user=(Users) authentication.getPrincipal();
        deviceTokensService.save(user, device.getDeviceToken(), device.getDeviceId(), device.getDeviceName());
        return ResponseEntity.ok("Send device token success");
    }
    @Transactional
    @DeleteMapping("/delete")
    public ResponseEntity<?>deleteDeviceTokens(@RequestParam String deviceId){
        Authentication authentication= SecurityContextHolder.getContext().getAuthentication();
        Long id=((Users) authentication.getPrincipal()).getId();
        Integer isSuccess= deviceTokensService.getDeviceTokensRepository().deleteByUsernameAndDeviceId(id,deviceId);
        if(isSuccess>0)return ResponseEntity.ok("");
        return ResponseEntity.notFound().build();
    }
}
