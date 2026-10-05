package com.kiemtragiuaky.controller;

import com.kiemtragiuaky.entity.OrderStatus_24133028;
import com.kiemtragiuaky.service.IOrderService_24133028;
import com.kiemtragiuaky.service.impl.OrderServiceImpl_24133028;
import com.kiemtragiuaky.util.SessionUser_24133028;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/orders/*")
public class OrderHistoryController_24133028 extends HttpServlet {
    private final IOrderService_24133028 service = new OrderServiceImpl_24133028();

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object account = request.getSession(false) == null ? null : request.getSession(false).getAttribute("currentUser");
        if (!(account instanceof SessionUser_24133028 user) || user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + (account == null ? "/login" : "/home"));
            return;
        }

        String path = request.getPathInfo();
        if ("/detail".equals(path)) {
            int id = parsePositive(request.getParameter("id"));
            if (id < 1) { response.sendError(HttpServletResponse.SC_BAD_REQUEST); return; }
            var order = service.findOwnedOrder(id, user.getId());
            if (order.isEmpty()) { response.sendError(HttpServletResponse.SC_NOT_FOUND); return; }
            request.setAttribute("order", order.get());
            request.getRequestDispatcher("/WEB-INF/views/user/order-detail.jsp").include(request, response);
            return;
        }

        OrderStatus_24133028 selected = null;
        String rawStatus = request.getParameter("status");
        if (rawStatus != null && !rawStatus.isBlank() && !"ALL".equals(rawStatus)) {
            try { selected = OrderStatus_24133028.valueOf(rawStatus); }
            catch (IllegalArgumentException exception) { request.setAttribute("filterError", "Trạng thái lọc không hợp lệ."); }
        }
        request.setAttribute("orders", service.history(user.getId(), selected));
        request.setAttribute("statuses", OrderStatus_24133028.values());
        request.setAttribute("selectedStatus", selected == null ? "ALL" : selected.name());
        request.getRequestDispatcher("/WEB-INF/views/user/order-history.jsp").include(request, response);
    }

    private int parsePositive(String value) {
        try { int id = Integer.parseInt(value); return id > 0 ? id : -1; }
        catch (RuntimeException exception) { return -1; }
    }
}
