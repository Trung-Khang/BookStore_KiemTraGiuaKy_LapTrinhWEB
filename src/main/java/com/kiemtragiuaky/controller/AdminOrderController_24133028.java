package com.kiemtragiuaky.controller;

import com.kiemtragiuaky.entity.OrderStatus_24133028;
import com.kiemtragiuaky.service.IOrderService_24133028;
import com.kiemtragiuaky.service.impl.OrderServiceImpl_24133028;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/admin/orders/*")
public class AdminOrderController_24133028 extends HttpServlet {
    private static final int PAGE_SIZE = 6;
    private final IOrderService_24133028 service = new OrderServiceImpl_24133028();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderStatus_24133028 status = parseFilter(request.getParameter("status"));
        int page = parsePage(request.getParameter("page"));
        int totalPages = Math.max(1, (int) Math.ceil(service.countAdminOrders(status) / (double) PAGE_SIZE));
        if (page > totalPages) {
            response.sendRedirect(listUrl(request, status, totalPages));
            return;
        }

        request.setAttribute("orders", service.adminPage(page, PAGE_SIZE, status));
        request.setAttribute("statuses", OrderStatus_24133028.values());
        request.setAttribute("selectedStatus", status == null ? "ALL" : status.name());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/WEB-INF/views/admin/orders/list.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = request.getPathInfo();
        OrderStatus_24133028 filter = parseFilter(request.getParameter("statusFilter"));
        try {
            int id = parsePositive(request.getParameter("orderId"));
            if ("/status".equals(path)) {
                OrderStatus_24133028 next = OrderStatus_24133028.valueOf(request.getParameter("status"));
                service.updateAdminStatus(id, next);
                response.sendRedirect(listUrl(request, filter, 1) + "&success=status");
            } else if ("/delete".equals(path)) {
                service.deleteCancelledOrder(id);
                response.sendRedirect(listUrl(request, filter, 1) + "&success=deleted");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (IllegalArgumentException | IllegalStateException exception) {
            String base = listUrl(request, filter, 1);
            response.sendRedirect(base + "&error=" + URLEncoder.encode(exception.getMessage(), StandardCharsets.UTF_8));
        }
    }

    private OrderStatus_24133028 parseFilter(String value) {
        if (value == null || value.isBlank() || "ALL".equals(value)) return null;
        try { return OrderStatus_24133028.valueOf(value); }
        catch (IllegalArgumentException exception) { return null; }
    }

    private int parsePage(String value) {
        try { return Math.max(1, Integer.parseInt(value)); }
        catch (RuntimeException exception) { return 1; }
    }

    private int parsePositive(String value) {
        try {
            int id = Integer.parseInt(value);
            if (id > 0) return id;
        } catch (RuntimeException ignored) { }
        throw new IllegalArgumentException("Mã đơn hàng không hợp lệ.");
    }

    private String listUrl(HttpServletRequest request, OrderStatus_24133028 status, int page) {
        String value = request.getContextPath() + "/admin/orders?page=" + page;
        if (status != null) value += "&status=" + status.name();
        else value += "&status=ALL";
        return value;
    }
}
