package com.example.demo.service;

import com.example.demo.model.Roles;
import com.example.demo.repository.RolesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RolesService {
    @Autowired
    private RolesRepository rolesRepository;
    public Roles findByRole(){
        return  rolesRepository.findByRole("USER");
    }
}
