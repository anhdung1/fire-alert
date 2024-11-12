package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

@Entity
public class Sensors {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String location;
    private Timestamp updateAt;
    private boolean status;
    private String topic;
    @ManyToMany(mappedBy = "sensors")
    @JsonIgnore
    private Set<Users> topicSubscribed;
    @OneToMany(mappedBy = "sensor")
    @JsonIgnore
    private List<Alerts> alerts;



    //getter and setter
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public Set<Users> getTopicSubscribed() {
        return topicSubscribed;
    }

    public void setTopicSubscribed(Set<Users> topicSubscribed) {
        this.topicSubscribed = topicSubscribed;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public List<Alerts> getAlerts() {
        return alerts;
    }

    public void setAlerts(List<Alerts> alerts) {
        this.alerts = alerts;
    }
}
