package com.example.demo.controller;


import com.example.demo.model.Sensors;
import com.example.demo.model.Users;
import com.example.demo.repository.UsersRepository;
import com.example.demo.service.AuthService;
import com.example.demo.service.UsersService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/users")
public class UsersController {
    @Autowired
    private UsersRepository usersRepository;
    @Autowired
    private UsersService usersService;
    @Autowired
    private AuthService authService;
    @PatchMapping("/update-password")
    public ResponseEntity<String> updatePassword(@RequestParam String newPassword) {
        Authentication authentication= SecurityContextHolder.getContext().getAuthentication();
        Users user=(Users) authentication.getPrincipal();
        try{

            usersService.updatePassword(authService.passwordEncoder(newPassword),user);
            SecurityContextHolder.getContext().setAuthentication(null);
            return ResponseEntity.ok("Change password successful");}
        catch(Exception e){
         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    @GetMapping
    public ResponseEntity<?> get() {
        Authentication authentication= SecurityContextHolder.getContext().getAuthentication();
        return ResponseEntity.ok((Users) authentication.getPrincipal());
    }
    @GetMapping("topic-subscribed")
    public ResponseEntity<?> getTopicSubscribed() {
        Authentication authentication= SecurityContextHolder.getContext().getAuthentication();
        Users users=(Users)authentication.getPrincipal();

        return ResponseEntity.ok(users.getTopics());
    }
}
