package com.example.demo.service;

import com.example.demo.model.DeviceTokens;
import com.example.demo.model.Users;
import com.example.demo.repository.DeviceTokensRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DeviceTokensService {
    @Autowired
    private DeviceTokensRepository deviceTokensRepository;

    public DeviceTokensRepository getDeviceTokensRepository() {
        return deviceTokensRepository;
    }
    public void save(Users user,String token,String deviceId,String deviceName){
       DeviceTokens deviceTokens=deviceTokensRepository.findByDeviceId(deviceId);
        if(deviceTokens==null){
            DeviceTokens newDeviceTokens=new DeviceTokens();
            newDeviceTokens.setDeviceId(deviceId);
            newDeviceTokens.setDeviceName(deviceName);
            newDeviceTokens.setDeviceToken(token);
            newDeviceTokens.setUser(user);
            deviceTokensRepository.save(newDeviceTokens);
        }
        else {
            deviceTokens.setDeviceToken(token);
            deviceTokensRepository.save(deviceTokens);
        }
    }

}
