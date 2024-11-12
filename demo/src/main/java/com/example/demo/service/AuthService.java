package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private PasswordEncoder passwordEncoder;

    private UsersService usersService;

    public AuthService(PasswordEncoder passwordEncoder, UsersService usersService) {
        this.passwordEncoder = passwordEncoder;
        this.usersService = usersService;
    }

    public String passwordEncoder(String password){
        return passwordEncoder.encode(password);
    }
    public void createUser(String username, String password,String phoneNumber) {

        usersService.createUser(username, passwordEncoder.encode(password),phoneNumber);
    }
}
