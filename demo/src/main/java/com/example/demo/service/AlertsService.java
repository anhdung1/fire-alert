package com.example.demo.service;

import com.example.demo.model.Alerts;
import com.example.demo.model.Sensors;
import com.example.demo.repository.AlertsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Service
public class AlertsService {
    @Autowired
    private SensorsService sensorsService;
    @Autowired
    private AlertsRepository alertsRepository;
    public void save(Boolean fire,Float ppm,String topic) {
        Sensors sensors=sensorsService.getSensorsRepository().findByTopic(topic);
        Alerts alerts = new Alerts();
        alerts.setSensor(sensors);
        alerts.setFire(fire);
        alerts.setPpm(ppm);
        alertsRepository.save(alerts);
    }
}
