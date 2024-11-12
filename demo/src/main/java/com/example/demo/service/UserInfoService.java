package com.example.demo.service;

import com.example.demo.model.UserInfo;
import com.example.demo.model.Users;
import com.example.demo.repository.UserInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserInfoService {
    @Autowired
    UserInfoRepository userInfoRepository;
    public void createUserInfo(Users user,String phoneNumber) {
        UserInfo userInfo = new UserInfo();
        userInfo.setUsers(user);
        userInfo.setPhoneNumber(phoneNumber);
        userInfoRepository.save(userInfo);
    }
    public UserInfo getUserInfo(Users user) {
        return userInfoRepository.findByUsers(user);
    }

    public void saveUserInfo(UserInfo newUserInfo,Users user) {
        UserInfo userInfo = user.getUserInfo();
        userInfo.setAddress(newUserInfo.getAddress());
        userInfo.setEmail(newUserInfo.getEmail());
        userInfo.setName(newUserInfo.getName());
        userInfo.setPhoneNumber(newUserInfo.getPhoneNumber());
         userInfoRepository.save(userInfo);
    }
}
