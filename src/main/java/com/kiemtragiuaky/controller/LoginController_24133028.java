package com.kiemtragiuaky.controller;

import com.kiemtragiuaky.service.AuthService_24133028;
import com.kiemtragiuaky.service.impl.UserServiceImpl_24133028;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginController_24133028 extends HttpServlet {
    private final AuthService_24133028 authService = new AuthService_24133028();
    private final UserServiceImpl_24133028 userService = new UserServiceImpl_24133028();

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if ("1".equals(request.getParameter("verified"))) request.setAttribute("success", "Xác minh tài khoản thành công. Bạn có thể đăng nhập.");
        if ("1".equals(request.getParameter("loggedOut"))) request.setAttribute("success", "Bạn đã đăng xuất.");
        include(request, response);
    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email") == null ? "" : request.getParameter("email").trim();
        String password = request.getParameter("password");
        request.setAttribute("email", email);
        if (email.isBlank() || password == null || password.isBlank()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ email và mật khẩu."); include(request, response); return;
        }
        var user = userService.findByEmail(email);
        if (user.isPresent() && !user.get().isEmailVerified()) {
            HttpSession session = request.getSession(true);
            session.setAttribute("pendingVerificationUserId", user.get().getId());
            response.sendRedirect(request.getContextPath() + "/verify-otp?blocked=1"); return;
        }
        var authenticated = authService.authenticate(email, password);
        if (authenticated.isEmpty()) { request.setAttribute("error", "Email hoặc mật khẩu không đúng."); include(request, response); return; }
        HttpSession old = request.getSession(false);
        if (old != null) old.invalidate();
        HttpSession session = request.getSession(true);
        session.setAttribute("currentUser", authenticated.get());
        response.sendRedirect(request.getContextPath() + (authenticated.get().isAdmin() ? "/admin/dashboard" : "/home"));
    }
    private void include(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").include(request, response); }
}
