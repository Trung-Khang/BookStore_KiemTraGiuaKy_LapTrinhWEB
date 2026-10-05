package com.kiemtragiuaky.dao.impl;

import com.kiemtragiuaky.config.JpaConfig_24133028;
import com.kiemtragiuaky.dao.IAccountOtpDao_24133028;
import com.kiemtragiuaky.entity.AccountOtp_24133028;
import com.kiemtragiuaky.entity.User_24133028;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.time.LocalDateTime;
import java.util.Optional;

public class AccountOtpDaoImpl_24133028 implements IAccountOtpDao_24133028 {
    @Override
    public Optional<AccountOtp_24133028> findLatest(Integer userId, String purpose) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("select o from AccountOtp_24133028 o where o.user.id = :userId and o.purpose = :purpose order by o.createdAt desc", AccountOtp_24133028.class)
                    .setParameter("userId", userId).setParameter("purpose", purpose).setMaxResults(1)
                    .getResultStream().findFirst();
        } finally { em.close(); }
    }

    @Override
    public void invalidateActive(Integer userId, String purpose, LocalDateTime now) {
        inTransaction(em -> em.createQuery("update AccountOtp_24133028 o set o.usedAt = :now where o.user.id = :userId and o.purpose = :purpose and o.usedAt is null")
                .setParameter("now", now).setParameter("userId", userId).setParameter("purpose", purpose).executeUpdate());
    }

    @Override
    public AccountOtp_24133028 save(AccountOtp_24133028 otp) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try { tx.begin(); em.persist(otp); tx.commit(); return otp; }
        catch (RuntimeException e) { if (tx.isActive()) tx.rollback(); throw e; }
        finally { em.close(); }
    }

    @Override
    public void incrementAttempt(Integer otpId) {
        inTransaction(em -> em.createQuery("update AccountOtp_24133028 o set o.attemptCount = o.attemptCount + 1 where o.id = :id")
                .setParameter("id", otpId).executeUpdate());
    }

    @Override
    public boolean consumeAndVerify(Integer otpId, Integer userId, LocalDateTime now) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            AccountOtp_24133028 otp = em.find(AccountOtp_24133028.class, otpId);
            User_24133028 user = em.find(User_24133028.class, userId);
            if (otp == null || user == null || otp.getUsedAt() != null || !otp.getUser().getId().equals(userId)) {
                tx.rollback(); return false;
            }
            otp.setUsedAt(now);
            user.setEmailVerified(Boolean.TRUE);
            tx.commit(); return true;
        } catch (RuntimeException e) { if (tx.isActive()) tx.rollback(); throw e; }
        finally { em.close(); }
    }

    @FunctionalInterface
    private interface Work_24133028 { void run(EntityManager em); }

    private void inTransaction(Work_24133028 work) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try { tx.begin(); work.run(em); tx.commit(); }
        catch (RuntimeException e) { if (tx.isActive()) tx.rollback(); throw e; }
        finally { em.close(); }
    }
}
