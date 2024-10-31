package com.example.demo.DTO;

import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class LoginResponse {
    private String apiKey;
    private Collection<? extends GrantedAuthority> role;
   public LoginResponse(String apiKey, Collection<? extends GrantedAuthority> role) {
       this.apiKey = apiKey;
       this.role = role;
   }

    public String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }


    public Collection<? extends GrantedAuthority> getRole() {
        return role;
    }

    public void setRole(Collection<? extends GrantedAuthority> role) {
        this.role = role;
    }
}
