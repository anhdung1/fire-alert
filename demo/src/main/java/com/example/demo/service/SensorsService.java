package com.example.demo.service;

import com.example.demo.DTO.SensorsResponse;

import com.example.demo.model.Sensors;
import com.example.demo.repository.SensorsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class SensorsService {
    @Autowired
    private SensorsRepository sensorsRepository;
    public SensorsRepository getSensorsRepository() {
        return sensorsRepository;
    }
    public List<SensorsResponse> getAllSensors() {
        List<Sensors> sensors = sensorsRepository.findAll();
        List<SensorsResponse> sensorsResponses = new ArrayList<>();
        for(Sensors sensor : sensors) {
            sensorsResponses.add(mapper(sensor));
        }
        return sensorsResponses;
    }
    public SensorsResponse mapper(Sensors sensors) {
        SensorsResponse sensorsResponse=new SensorsResponse();
        sensorsResponse.setId(sensors.getId());
        sensorsResponse.setLocation(sensors.getLocation());
        sensorsResponse.setTopic(sensors.getTopic());
        return sensorsResponse;
    }
}
