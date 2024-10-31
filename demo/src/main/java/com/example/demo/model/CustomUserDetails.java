//package com.example.demo.model;
//
//import org.springframework.security.core.GrantedAuthority;
//import org.springframework.security.core.userdetails.UserDetails;
//
//import java.util.Collection;
//
//public class CustomUserDetails implements UserDetails {
//    private final Users user;
//
//    public CustomUserDetails(Users user) {
//        this.user = user;
//    }
//
//    @Override
//    public String getUsername() {
//        return user.getUsername();
//    }
//
//    @Override
//    public String getPassword() {
//        return user.getPassword();
//    }
//
//    @Override
//    public Collection<? extends GrantedAuthority> getAuthorities() {
//        return user.getAuthorities(); // Giả sử bạn đã định nghĩa phương thức này trong lớp Users
//    }
//
//    // Cần implement các phương thức khác của UserDetails
//    @Override
//    public boolean isAccountNonExpired() {
//        return true;
//    }
//
//    @Override
//    public boolean isAccountNonLocked() {
//        return true;
//    }
//
//    @Override
//    public boolean isCredentialsNonExpired() {
//        return true;
//    }
//
//    @Override
//    public boolean isEnabled() {
//        return true;
//    }
//
//    public Users getUser() {
//        return user; // Phương thức này cho phép bạn lấy đối tượng Users
//    }
//}
