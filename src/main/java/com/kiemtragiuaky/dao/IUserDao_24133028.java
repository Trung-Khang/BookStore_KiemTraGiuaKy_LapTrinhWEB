package com.kiemtragiuaky.dao;

import com.kiemtragiuaky.entity.User_24133028;
import java.util.Optional;
import java.time.LocalDateTime;

public interface IUserDao_24133028 {
    Optional<User_24133028> findByEmail(String email);
    Optional<User_24133028> findById(Integer id);
    boolean existsByEmail(String email);
    void updateLastLogin(Integer id, LocalDateTime lastLogin);
    void markEmailVerified(Integer id);
    User_24133028 save(User_24133028 user);
}
