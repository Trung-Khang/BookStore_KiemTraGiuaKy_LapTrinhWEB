package com.kiemtragiuaky.service;

import com.kiemtragiuaky.entity.User_24133028;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

public class SmtpEmailService_24133028 {
    public void sendVerificationOtp(User_24133028 user, String otp, int expiryMinutes)
            throws MailDeliveryException_24133028 {
        String host = required("SMTP_HOST");
        String port = value("SMTP_PORT", "587");
        String username = value("SMTP_USER", value("SMTP_USERNAME", ""));
        String password = required("SMTP_PASSWORD");
        String from = value("SMTP_FROM", username);
        boolean auth = booleanValue("SMTP_AUTH", true);
        boolean startTls = booleanValue("SMTP_STARTTLS", true);
        if (host == null || username == null || password == null || from == null) {
            throw new MailDeliveryException_24133028();
        }

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", Boolean.toString(auth));
        properties.put("mail.smtp.starttls.enable", Boolean.toString(startTls));
        properties.put("mail.smtp.connectiontimeout", "10000");
        properties.put("mail.smtp.timeout", "10000");
        properties.put("mail.smtp.writetimeout", "10000");
        Session session = Session.getInstance(properties);
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from, "KHANGGEAR", StandardCharsets.UTF_8.name()));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail(), true));
            message.setSubject("[KHANGGEAR] Mã xác nhận kích hoạt tài khoản", StandardCharsets.UTF_8.name());
            String recipient = escape(user.getFullname() == null || user.getFullname().isBlank()
                    ? user.getEmail() : user.getFullname());
            String body = "<div style='font-family:Arial,sans-serif;max-width:560px;margin:auto;color:#172033'>"
                    + "<h1 style='color:#1685f5'>KHANGGEAR</h1>"
                    + "<h2>Xác minh tài khoản</h2><p>Xin chào " + recipient + ",</p>"
                    + "<p>Mã xác nhận của bạn là:</p><p style='font-size:32px;font-weight:bold;letter-spacing:8px;color:#1685f5'>"
                    + otp + "</p><p>Mã có hiệu lực trong " + expiryMinutes + " phút.</p>"
                    + "<p><strong>Không chia sẻ mã này cho bất kỳ ai.</strong></p>"
                    + "<p>Nếu bạn không yêu cầu tạo tài khoản, hãy bỏ qua email này.</p></div>";
            message.setContent(body, "text/html; charset=UTF-8");
            Transport.send(message, username, password);
        } catch (MessagingException | java.io.IOException exception) {
            System.err.println("[mail] delivery failed: " + exception.getClass().getSimpleName());
            throw new MailDeliveryException_24133028();
        }
    }

    private static String required(String name) {
        String value = System.getenv(name);
        return value == null || value.isBlank() ? null : value;
    }
    private static String value(String name, String fallback) {
        String value = System.getenv(name);
        return value == null || value.isBlank() ? fallback : value;
    }
    private static boolean booleanValue(String name, boolean fallback) {
        return Boolean.parseBoolean(value(name, Boolean.toString(fallback)));
    }
    private static String escape(String value) {
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                .replace("\"", "&quot;").replace("'", "&#39;");
    }
}
