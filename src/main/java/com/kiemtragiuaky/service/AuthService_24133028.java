package com.kiemtragiuaky.service;

import com.kiemtragiuaky.entity.User_24133028;
import com.kiemtragiuaky.service.impl.UserServiceImpl_24133028;
import com.kiemtragiuaky.util.PasswordUtil_24133028;
import com.kiemtragiuaky.util.SessionUser_24133028;
import java.time.LocalDateTime;
import java.util.Optional;

public class AuthService_24133028 {
    private final UserServiceImpl_24133028 userService = new UserServiceImpl_24133028();

    public boolean emailExists(String email) { return userService.existsByEmail(email); }

    public User_24133028 register(String email, String fullname, Integer phone, String password) {
        User_24133028 user = new User_24133028();
        user.setEmail(email);
        user.setFullname(fullname);
        user.setPhone(phone);
        user.setPassword(PasswordUtil_24133028.hash(password));
        user.setSignupDate(LocalDateTime.now());
        user.setAdmin(Boolean.FALSE);
        user.setEmailVerified(Boolean.FALSE);
        return userService.save(user);
    }

    public Optional<SessionUser_24133028> authenticate(String email, String password) {
        return userService.findByEmail(email)
                .filter(User_24133028::isEmailVerified)
                .filter(user -> user.getAdmin() != null)
                .filter(user -> PasswordUtil_24133028.matches(password, user.getPassword()))
                .map(user -> {
                    userService.updateLastLogin(user.getId(), LocalDateTime.now());
                    return new SessionUser_24133028(user.getId(), user.getEmail(), user.getFullname(), user.isAdmin());
                });
    }

    public Optional<User_24133028> findById(Integer id) { return userService.findById(id); }
}
