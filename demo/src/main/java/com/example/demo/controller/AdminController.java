package com.example.demo.controller;

import com.example.demo.DTO.LoginRequest;
import com.example.demo.model.Users;
import com.example.demo.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AuthService authService;
    @GetMapping
    public ResponseEntity<?> getAdmin() {

        return ResponseEntity.ok("OK");
    }
    @GetMapping("get-topic")
    public ResponseEntity<?> getTopic() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users user = (Users) auth.getPrincipal();
        return ResponseEntity.ok(user);
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
