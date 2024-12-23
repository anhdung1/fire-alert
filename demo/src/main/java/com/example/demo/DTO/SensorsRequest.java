package com.example.demo.DTO;

public class SensorsRequest {
    private Boolean fire;
    private Float ppm;
    private Float temperature;
    public SensorsRequest(Boolean fire,Float ppm,Float temperature){
        this.fire=fire;
        this.ppm=ppm;
        this.temperature=temperature;
    }
    public SensorsRequest(){};
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

    public Float getTemperature() {
        return temperature;
    }

    public void setTemperature(Float temperature) {
        this.temperature = temperature;
    }
}
