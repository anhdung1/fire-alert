package com.example.demo.repository;

import com.example.demo.model.DeviceTokens;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface DeviceTokensRepository extends JpaRepository<DeviceTokens,Long> {
    DeviceTokens findByDeviceId(String deviceId);
    @Query("select dt.deviceToken from DeviceTokens dt")
    List<String> findAllToken();
    @Modifying
    @Transactional
    @Query("delete  from DeviceTokens dt join dt.user u where u.id=:id and dt.deviceId=:deviceId")
    Integer deleteByUsernameAndDeviceId(@Param("id") Long id,@Param("deviceId") String deviceId);
}
