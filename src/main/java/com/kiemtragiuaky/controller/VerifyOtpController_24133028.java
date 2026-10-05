package com.kiemtragiuaky.controller;

import com.kiemtragiuaky.entity.OtpPurpose_24133028;
import com.kiemtragiuaky.service.MailDeliveryException_24133028;
import com.kiemtragiuaky.service.OtpCooldownException_24133028;
import com.kiemtragiuaky.service.OtpService_24133028;
import com.kiemtragiuaky.service.VerificationStatus_24133028;
import com.kiemtragiuaky.service.AuthService_24133028;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet({"/verify-otp", "/verify-otp/resend"})
public class VerifyOtpController_24133028 extends HttpServlet {
    private final OtpService_24133028 otpService = new OtpService_24133028();
    private final AuthService_24133028 authService = new AuthService_24133028();

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (pendingId(request.getSession(false)) == null) { response.sendRedirect(request.getContextPath() + "/register"); return; }
        if ("1".equals(request.getParameter("sent"))) request.setAttribute("success", "Mã xác nhận đã được gửi đến email của bạn.");
        if ("1".equals(request.getParameter("mailError"))) request.setAttribute("error", "Tài khoản đã được tạo nhưng chưa thể gửi email xác nhận. Vui lòng thử gửi lại OTP sau.");
        if ("1".equals(request.getParameter("blocked"))) request.setAttribute("error", "Tài khoản chưa được xác minh. Vui lòng nhập OTP để kích hoạt.");
        include(request, response);
    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = pendingId(session);
        if (userId == null) { response.sendRedirect(request.getContextPath() + "/register"); return; }
        if (request.getRequestURI().endsWith("/resend")) { resend(request, response, userId); return; }
        VerificationStatus_24133028 status = otpService.verify(userId, OtpPurpose_24133028.VERIFY_EMAIL, request.getParameter("otp"));
        if (status == VerificationStatus_24133028.SUCCESS) {
            session.removeAttribute("pendingVerificationUserId");
            response.sendRedirect(request.getContextPath() + "/login?verified=1");
            return;
        }
        request.setAttribute("error", switch (status) {
            case INVALID -> "Mã OTP không đúng.";
            case EXHAUSTED -> "Bạn đã nhập sai quá số lần cho phép. Vui lòng gửi lại OTP.";
            default -> "Mã OTP đã hết hạn hoặc không tồn tại.";
        });
        include(request, response);
    }

    private void resend(HttpServletRequest request, HttpServletResponse response, Integer userId) throws ServletException, IOException {
        try {
            var user = authService.findById(userId).orElseThrow();
            otpService.issueAndSend(user, OtpPurpose_24133028.VERIFY_EMAIL);
            response.sendRedirect(request.getContextPath() + "/verify-otp?sent=1");
        } catch (OtpCooldownException_24133028 exception) { request.setAttribute("error", exception.getMessage()); include(request, response); }
        catch (MailDeliveryException_24133028 exception) { request.setAttribute("error", "Chưa gửi được email. Bạn có thể thử lại sau."); include(request, response); }
    }
    private Integer pendingId(HttpSession session) { return session == null ? null : (Integer) session.getAttribute("pendingVerificationUserId"); }
    private void include(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { request.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").include(request, response); }
}
