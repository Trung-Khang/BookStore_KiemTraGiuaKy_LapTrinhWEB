package com.kiemtragiuaky.controller;

import com.kiemtragiuaky.entity.OtpPurpose_24133028;
import com.kiemtragiuaky.entity.User_24133028;
import com.kiemtragiuaky.service.AuthService_24133028;
import com.kiemtragiuaky.service.MailDeliveryException_24133028;
import com.kiemtragiuaky.service.OtpCooldownException_24133028;
import com.kiemtragiuaky.service.OtpService_24133028;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController_24133028 extends HttpServlet {
    private final AuthService_24133028 authService = new AuthService_24133028();
    private final OtpService_24133028 otpService = new OtpService_24133028();

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        include(request, response);
    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = value(request, "email");
        String fullname = value(request, "fullname");
        String phoneText = value(request, "phone");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");
        request.setAttribute("email", email); request.setAttribute("fullname", fullname); request.setAttribute("phone", phoneText);
        String error = validate(email, fullname, phoneText, password, confirm);
        Integer phone = null;
        if (error == null) {
            try { phone = Integer.valueOf(phoneText); }
            catch (NumberFormatException exception) { error = "Số điện thoại không hợp lệ."; }
        }
        if (error == null && authService.emailExists(email)) error = "Email này đã được sử dụng.";
        if (error != null) { request.setAttribute("error", error); include(request, response); return; }
        try {
            User_24133028 user = authService.register(email, fullname, phone, password);
            request.getSession(true).setAttribute("pendingVerificationUserId", user.getId());
            try { otpService.issueAndSend(user, OtpPurpose_24133028.VERIFY_EMAIL); }
            catch (OtpCooldownException_24133028 ignored) { }
            response.sendRedirect(request.getContextPath() + "/verify-otp?sent=1");
        } catch (MailDeliveryException_24133028 exception) {
            response.sendRedirect(request.getContextPath() + "/verify-otp?mailError=1");
        } catch (RuntimeException exception) {
            request.setAttribute("error", "Không thể tạo tài khoản. Vui lòng thử lại.");
            include(request, response);
        }
    }

    private String validate(String email, String fullname, String phone, String password, String confirm) {
        if (email.isBlank() || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) return "Email không hợp lệ.";
        if (fullname.isBlank() || fullname.length() > 50) return "Họ tên bắt buộc và tối đa 50 ký tự.";
        if (!phone.matches("\\d{9,10}")) return "Số điện thoại phải gồm 9 đến 10 chữ số.";
        if (password == null || password.length() < 8) return "Mật khẩu phải có ít nhất 8 ký tự.";
        if (!password.equals(confirm)) return "Mật khẩu xác nhận không khớp.";
        return null;
    }
    private String value(HttpServletRequest request, String name) { return request.getParameter(name) == null ? "" : request.getParameter(name).trim(); }
    private void include(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").include(request, response); }
}
