package com.example.demo.model;

import jakarta.persistence.*;

import java.sql.Timestamp;

@Entity
public class Alerts {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Boolean fire;
    private Float ppm;
    private Timestamp alertTime;
    @ManyToOne
    @JoinColumn(name = "sensor_id")
    private Sensors sensor;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Boolean getFire() {
        return fire;
    }

    public void setFire(Boolean fire) {
        this.fire = fire;
    }

    public Float getPpm() {
        return ppm;
    }

    public void setPpm(Float ppm) {
        this.ppm = ppm;
    }

    public Timestamp getAlertTime() {
        return alertTime;
    }

    public void setAlertTime(Timestamp alertTime) {
        this.alertTime = alertTime;
    }

    public Sensors getSensor() {
        return sensor;
    }

    public void setSensor(Sensors sensor) {
        this.sensor = sensor;
    }
}
