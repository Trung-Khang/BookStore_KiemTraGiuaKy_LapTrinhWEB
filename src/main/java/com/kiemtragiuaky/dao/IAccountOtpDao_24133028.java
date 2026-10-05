package com.kiemtragiuaky.dao;

import com.kiemtragiuaky.entity.AccountOtp_24133028;
import java.time.LocalDateTime;
import java.util.Optional;

public interface IAccountOtpDao_24133028 {
    Optional<AccountOtp_24133028> findLatest(Integer userId, String purpose);
    void invalidateActive(Integer userId, String purpose, LocalDateTime now);
    AccountOtp_24133028 save(AccountOtp_24133028 otp);
    void incrementAttempt(Integer otpId);
    boolean consumeAndVerify(Integer otpId, Integer userId, LocalDateTime now);
}
