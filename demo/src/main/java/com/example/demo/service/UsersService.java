package com.example.demo.service;

import com.example.demo.model.Users;
import com.example.demo.repository.UsersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class UsersService  {
    @Autowired
    private UsersRepository usersRepository;
    @Autowired
    private UserInfoService userInfoService;
    @Autowired
    private RolesService rolesService;
    public UsersRepository getUsersRepository() {
        return usersRepository;
    }
    public void createUser(String username, String password,String phoneNumber) {
       boolean exists =  usersRepository.existsByUsername(username);
       if(exists) {
           throw new UsernameNotFoundException("Username " + username + " already exists");
       }
       else {

           Users user = new Users();
           user.setUsername(username);
           user.setPassword(password);
           user.setApiKey(generateUniqueApiKey());
           user.setRoles(rolesService.findByRole());
           usersRepository.save(user);
           userInfoService.createUserInfo(user,phoneNumber);
       }


    }
    public void updatePassword(String password,Users user){
        user.setPassword(password);
        usersRepository.save(user);
    }
    public String generateUniqueApiKey() {
        String apiKey;
        do {
            apiKey = UUID.randomUUID().toString();
        } while (usersRepository.existsByApiKey(apiKey));
        return apiKey;
    }
    @Cacheable(value = "users",key = "#username")
    public Users findByUsername(String username){
        return usersRepository.findByUsername(username);
    }
    @Cacheable(value = "users",key = "#apiKey")
    public Users findByApiKey(String apiKey){
        return usersRepository.findByApiKey(apiKey);
    }
}
