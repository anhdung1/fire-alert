package com.example.demo.DTO;

public class SensorsResponse {
    private Long id;
    private String location;
    private String topic;
    public SensorsResponse(Long id, String location, String topic) {
        this.id = id;
        this.location = location;
        this.topic = topic;
    }
    public SensorsResponse() {}
    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
