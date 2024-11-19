package com.example.demo.service;

import com.example.demo.DTO.AlertsResponse;
import com.example.demo.model.Alerts;
import com.example.demo.model.Sensors;
import com.example.demo.repository.AlertsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class AlertsService {
    @Autowired
    private SensorsService sensorsService;
    @Autowired
    private AlertsRepository alertsRepository;
    public AlertsRepository getAlertsRepository() {
        return alertsRepository;
    }
    public void save(Boolean fire,Float ppm,String topic,Float temperature) {
        Sensors sensors=sensorsService.getSensorsRepository().findByTopic(topic);
        LocalDateTime now = LocalDateTime.now();
        Alerts alerts = new Alerts();
        alerts.setAlertTime(Timestamp.valueOf(now));
        alerts.setSensor(sensors);
        alerts.setFire(fire);
        alerts.setPpm(ppm);
        alerts.setTemperature(temperature);
        alertsRepository.save(alerts);
    }
    public List<AlertsResponse> getAlertsResponse() {
        List<AlertsResponse> alertsResponseList=new ArrayList<>();
        List<Alerts> alerts=alertsRepository.findAll();
        for (Alerts alert:alerts) {
            AlertsResponse alertsResponse=new AlertsResponse(

            );
            alertsResponse.setAlertTime(alert.getAlertTime());
            alertsResponse.setPpm(alert.getPpm());
            alertsResponse.setLocation(alert.getSensor().getLocation());
            alertsResponse.setTemperature(alert.getTemperature());
            alertsResponseList.add(alertsResponse);
        }
        return alertsResponseList;
    }
}
