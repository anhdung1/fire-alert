package com.example.demo.controller;

import com.example.demo.model.UserInfo;
import com.example.demo.model.Users;
import com.example.demo.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("user-info")
public class UserInfoController {
    @Autowired
    private UserInfoService userInfoService;
    @PutMapping("update")
    public ResponseEntity<?> updateUserInfo(@RequestBody UserInfo newUserInfo) {
        Authentication authentication= SecurityContextHolder.getContext().getAuthentication();
        Users user = (Users) authentication.getPrincipal();
        try{
            userInfoService.saveUserInfo(newUserInfo,user);
            return ResponseEntity.ok(user.getUserInfo());
        }
        catch(Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }

    }
    @GetMapping("/get")
    public ResponseEntity<?> getUserInfo() {
        Authentication authentication= SecurityContextHolder.getContext().getAuthentication();
        Users user = (Users) authentication.getPrincipal();
        if(user != null){
            return ResponseEntity.ok(user.getUserInfo());
        }
        return ResponseEntity.ofNullable("User not found");
    }
}
