package com.example.demo.service;

import com.example.demo.model.Sensors;
import com.example.demo.repository.SensorsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SensorsService {
    @Autowired
    private SensorsRepository sensorsRepository;

    public SensorsRepository getSensorsRepository() {
        return sensorsRepository;
    }
}
