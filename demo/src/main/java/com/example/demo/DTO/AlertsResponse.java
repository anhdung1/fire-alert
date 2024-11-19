package com.example.demo.DTO;

import java.sql.Timestamp;

public class AlertsResponse {
    private Float ppm;
    private Float temperature;
    private String location;
    private Timestamp alertTime;

    public Float getPpm() {
        return ppm;
    }

    public void setPpm(Float ppm) {
        this.ppm = ppm;
    }

    public Float getTemperature() {
        return temperature;
    }

    public void setTemperature(Float temperature) {
        this.temperature = temperature;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Timestamp getAlertTime() {
        return alertTime;
    }

    public void setAlertTime(Timestamp alertTime) {
        this.alertTime = alertTime;
    }
}
