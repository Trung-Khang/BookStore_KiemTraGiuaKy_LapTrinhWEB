package com.kiemtragiuaky.service;

import com.kiemtragiuaky.dao.IAccountOtpDao_24133028;
import com.kiemtragiuaky.dao.impl.AccountOtpDaoImpl_24133028;
import com.kiemtragiuaky.entity.AccountOtp_24133028;
import com.kiemtragiuaky.entity.OtpPurpose_24133028;
import com.kiemtragiuaky.entity.User_24133028;
import com.kiemtragiuaky.util.PasswordUtil_24133028;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Optional;

public class OtpService_24133028 {
    private static final int MAX_ATTEMPTS = 5;
    private static final int COOLDOWN_SECONDS = 60;
    private final IAccountOtpDao_24133028 otpDao = new AccountOtpDaoImpl_24133028();
    private final SmtpEmailService_24133028 emailService = new SmtpEmailService_24133028();
    private final SecureRandom secureRandom = new SecureRandom();

    public void issueAndSend(User_24133028 user, OtpPurpose_24133028 purpose)
            throws MailDeliveryException_24133028, OtpCooldownException_24133028 {
        LocalDateTime now = LocalDateTime.now();
        Optional<AccountOtp_24133028> latest = otpDao.findLatest(user.getId(), purpose.name());
        if (latest.isPresent() && latest.get().getCreatedAt() != null
                && latest.get().getCreatedAt().plusSeconds(COOLDOWN_SECONDS).isAfter(now)) {
            throw new OtpCooldownException_24133028();
        }
        otpDao.invalidateActive(user.getId(), purpose.name(), now);
        String otp = String.format("%06d", secureRandom.nextInt(1_000_000));
        int expiryMinutes = expiryMinutes();
        AccountOtp_24133028 record = new AccountOtp_24133028();
        record.setUser(user);
        record.setPurpose(purpose.name());
        record.setOtpHash(hash(otp));
        record.setCreatedAt(now);
        record.setExpiresAt(now.plusMinutes(expiryMinutes));
        record.setAttemptCount(0);
        otpDao.save(record);
        emailService.sendVerificationOtp(user, otp, expiryMinutes);
    }

    public VerificationStatus_24133028 verify(Integer userId, OtpPurpose_24133028 purpose, String input) {
        if (input == null || !input.matches("\\d{6}")) return VerificationStatus_24133028.INVALID;
        Optional<AccountOtp_24133028> latest = otpDao.findLatest(userId, purpose.name());
        if (latest.isEmpty()) return VerificationStatus_24133028.EXPIRED_OR_MISSING;
        AccountOtp_24133028 otp = latest.get();
        LocalDateTime now = LocalDateTime.now();
        if (otp.getUsedAt() != null || otp.getExpiresAt().isBefore(now)) return VerificationStatus_24133028.EXPIRED_OR_MISSING;
        if (otp.getAttemptCount() >= MAX_ATTEMPTS) return VerificationStatus_24133028.EXHAUSTED;
        if (!MessageDigest.isEqual(hash(input).getBytes(StandardCharsets.UTF_8), otp.getOtpHash().getBytes(StandardCharsets.UTF_8))) {
            otpDao.incrementAttempt(otp.getId());
            return VerificationStatus_24133028.INVALID;
        }
        return otpDao.consumeAndVerify(otp.getId(), userId, now)
                ? VerificationStatus_24133028.SUCCESS : VerificationStatus_24133028.EXPIRED_OR_MISSING;
    }

    private int expiryMinutes() {
        try { return Math.max(1, Integer.parseInt(System.getenv().getOrDefault("OTP_EXPIRY_MINUTES", "5"))); }
        catch (NumberFormatException exception) { return 5; }
    }
    private String hash(String value) {
        try {
            byte[] digest = MessageDigest.getInstance("SHA-256").digest(value.getBytes(StandardCharsets.UTF_8));
            StringBuilder result = new StringBuilder(64);
            for (byte item : digest) result.append(String.format("%02x", item));
            return result.toString();
        } catch (NoSuchAlgorithmException exception) { throw new IllegalStateException("SHA-256 unavailable", exception); }
    }
}
