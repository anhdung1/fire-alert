package com.example.demo.DTO;

public class SensorsRequest {
    private Boolean fire;
    private Float ppm;

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
}
