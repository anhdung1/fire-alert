package com.example.demo.repository;

import com.example.demo.model.UserInfo;
import com.example.demo.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserInfoRepository extends JpaRepository<UserInfo, Long> {
    UserInfo findByUsers(Users users);
}
