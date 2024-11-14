package com.example.demo.repository;

import com.example.demo.model.Alerts;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface AlertsRepository extends JpaRepository<Alerts, Long> {
    @Query("SELECT s.topic from  Sensors s")
    List<String> findAllByTopic(String topic);
}
