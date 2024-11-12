package com.example.demo.repository;

import com.example.demo.model.Sensors;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SensorsRepository extends JpaRepository<Sensors, Long> {
    @Query("SELECT  s.topic from Sensors s")
    List<String> findAllTopics();
    Sensors findByTopic(String topic);
}
