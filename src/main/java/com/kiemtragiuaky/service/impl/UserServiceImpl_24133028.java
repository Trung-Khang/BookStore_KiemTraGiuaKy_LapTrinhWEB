package com.kiemtragiuaky.service.impl;

import com.kiemtragiuaky.dao.IUserDao_24133028;
import com.kiemtragiuaky.dao.impl.UserDaoImpl_24133028;
import com.kiemtragiuaky.entity.User_24133028;
import com.kiemtragiuaky.service.IUserService_24133028;
import java.util.Optional;
import java.time.LocalDateTime;

public class UserServiceImpl_24133028 implements IUserService_24133028 {
    private final IUserDao_24133028 userDao = new UserDaoImpl_24133028();

    @Override
    public Optional<User_24133028> findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override public Optional<User_24133028> findById(Integer id) { return userDao.findById(id); }
    @Override public boolean existsByEmail(String email) { return userDao.existsByEmail(email); }
    @Override public void updateLastLogin(Integer id, LocalDateTime lastLogin) { userDao.updateLastLogin(id, lastLogin); }
    @Override public void markEmailVerified(Integer id) { userDao.markEmailVerified(id); }
    @Override public User_24133028 save(User_24133028 user) { return userDao.save(user); }
}
