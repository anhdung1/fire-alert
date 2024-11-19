package com.example.demo.filter;

import com.example.demo.model.Users;

import com.example.demo.service.UsersService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;

@Component
public class ApiKeyFilter extends OncePerRequestFilter {

    private final UsersService usersService;

    public ApiKeyFilter(UsersService usersService) {
        this.usersService = usersService;
    }


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String apiKey = request.getHeader("x-api-key");
        System.out.println(apiKey);
       if(apiKey != null) {
           System.out.println(apiKey);
           Users user= usersService.getUsersRepository().findByApiKey(apiKey);
           System.out.println(user);
           if(user != null) {
               UsernamePasswordAuthenticationToken authenticationToken=new UsernamePasswordAuthenticationToken(user,null, user.getAuthorities());
               SecurityContextHolder.getContext().setAuthentication(authenticationToken);
           }
       }
       filterChain.doFilter(request, response);
    }
    
}
