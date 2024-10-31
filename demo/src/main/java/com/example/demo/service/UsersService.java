package com.example.demo.service;

import com.example.demo.model.Users;
import com.example.demo.repository.UsersRepository;
import org.springframework.beans.factory.annotation.Autowired;
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
    private RolesService rolesService;
    public Users findByApiKey(String apiKey) {
        return usersRepository.findByApiKey(apiKey);
    }
    public Users findByUsername(String username) {
        return usersRepository.findByUsername(username);
    }
    public void createUser(String username, String password) {
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
           usersRepository.save(user);}


    }
    public String generateUniqueApiKey() {
        String apiKey;
        do {
            apiKey = UUID.randomUUID().toString();
        } while (usersRepository.existsByApiKey(apiKey));
        return apiKey;
    }

}
