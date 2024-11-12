package com.example.demo.repository;

import com.example.demo.model.Alerts;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


public interface AlertsRepository extends JpaRepository<Alerts, Long> {

}
