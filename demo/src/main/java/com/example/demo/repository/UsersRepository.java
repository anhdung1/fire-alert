package com.example.demo.repository;

import com.example.demo.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsersRepository extends JpaRepository<Users, Integer> {
    Users findByApiKey(String apiKey);
    Users findByUsername(String username);
    boolean existsByUsername(String username);
    boolean existsByApiKey(String apiKey);
}
