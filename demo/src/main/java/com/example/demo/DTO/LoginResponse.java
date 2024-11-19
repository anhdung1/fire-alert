package com.example.demo.DTO;

import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class LoginResponse {
    private String apiKey;
    private String role;
    private Long userId;
   public LoginResponse(String apiKey, String role, Long userId) {
       this.apiKey = apiKey;
       this.role = role;
       this.userId = userId;
   }

    public String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }


    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
