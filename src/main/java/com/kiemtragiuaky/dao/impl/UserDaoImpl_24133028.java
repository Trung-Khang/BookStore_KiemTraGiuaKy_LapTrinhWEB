    package com.kiemtragiuaky.dao.impl;

import com.kiemtragiuaky.config.JpaConfig_24133028;
import com.kiemtragiuaky.dao.IUserDao_24133028;
import com.kiemtragiuaky.entity.User_24133028;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.Optional;
import java.time.LocalDateTime;

public class UserDaoImpl_24133028 implements IUserDao_24133028 {
    @Override
    public Optional<User_24133028> findByEmail(String email) {
        EntityManager entityManager = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            return entityManager.createQuery("select u from User_24133028 u where u.email = :email", User_24133028.class)
                    .setParameter("email", email)
                    .getResultStream()
                    .findFirst();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public User_24133028 save(User_24133028 user) {
        EntityManager entityManager = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            User_24133028 saved = user.getId() == null ? user : entityManager.merge(user);
            if (user.getId() == null) entityManager.persist(user);
            transaction.commit();
            return saved;
        } catch (RuntimeException exception) {
            if (transaction.isActive()) transaction.rollback();
            throw exception;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Optional<User_24133028> findById(Integer id) {
        EntityManager entityManager = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            return Optional.ofNullable(entityManager.find(User_24133028.class, id));
        } finally {
            entityManager.close();
        }
    }

    @Override
    public boolean existsByEmail(String email) {
        EntityManager entityManager = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            return entityManager.createQuery("select count(u) from User_24133028 u where lower(u.email) = :email", Long.class)
                    .setParameter("email", email.toLowerCase())
                    .getSingleResult() > 0;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void updateLastLogin(Integer id, LocalDateTime lastLogin) {
        updateField(id, "lastLogin", lastLogin);
    }

    @Override
    public void markEmailVerified(Integer id) {
        updateField(id, "emailVerified", Boolean.TRUE);
    }

    private void updateField(Integer id, String field, Object value) {
        EntityManager entityManager = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            User_24133028 user = entityManager.find(User_24133028.class, id);
            if (user == null) throw new IllegalArgumentException("Không tìm thấy tài khoản.");
            if ("lastLogin".equals(field)) user.setLastLogin((LocalDateTime) value);
            else user.setEmailVerified((Boolean) value);
            transaction.commit();
        } catch (RuntimeException exception) {
            if (transaction.isActive()) transaction.rollback();
            throw exception;
        } finally {
            entityManager.close();
        }
    }
}
