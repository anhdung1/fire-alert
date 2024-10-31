package com.example.demo.controller;


import com.example.demo.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UsersController {
    @Autowired
    private UsersService usersService;
    @GetMapping
    ResponseEntity<?>test(@RequestParam String apiKey){

        try{return ResponseEntity.ok(usersService.findByApiKey(apiKey));}
        catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }@GetMapping("/test")
    ResponseEntity<?>testApiKey(){


            return ResponseEntity.ok("success");

    }

}
