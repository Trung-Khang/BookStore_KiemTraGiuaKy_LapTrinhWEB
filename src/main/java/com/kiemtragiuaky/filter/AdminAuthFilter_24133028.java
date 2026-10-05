package com.kiemtragiuaky.filter;

import com.kiemtragiuaky.util.SessionUser_24133028;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminAuthFilter_24133028 implements Filter {
    @Override
    public void doFilter(jakarta.servlet.ServletRequest request, jakarta.servlet.ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        Object account = session == null ? null : session.getAttribute("currentUser");
        if (account instanceof SessionUser_24133028 user && user.isAdmin()) {
            chain.doFilter(request, response);
            return;
        }
        httpResponse.sendRedirect(httpRequest.getContextPath() + (account == null ? "/login" : "/home"));
    }
}
