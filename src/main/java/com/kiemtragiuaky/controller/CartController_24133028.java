package com.kiemtragiuaky.controller;

import com.kiemtragiuaky.service.CartService_24133028;
import com.kiemtragiuaky.service.CartService_24133028.CartLine_24133028;
import com.kiemtragiuaky.util.SessionUser_24133028;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/cart/*")
public class CartController_24133028 extends HttpServlet {
    private static final String CART_KEY = "shoppingCart";
    private final CartService_24133028 service = new CartService_24133028();

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (requireUser(request, response) == null) return;
        Map<Integer, Integer> cart = cart(request.getSession());
        List<CartLine_24133028> lines = service.lines(cart);
        request.setAttribute("cartLines", lines);
        request.setAttribute("cartTotal", CartService_24133028.total(lines));
        request.setAttribute("cartMessage", request.getParameter("message"));
        request.getRequestDispatcher("/WEB-INF/views/user/cart.jsp").include(request, response);
    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (requireUser(request, response) == null) return;
        String action = request.getPathInfo();
        Map<Integer, Integer> cart = cart(request.getSession());
        String message;
        try {
            if ("/add".equals(action)) {
                service.add(cart, positiveInt(request.getParameter("bookId")), positiveInt(request.getParameter("quantity")));
                message = "added";
            } else if ("/update".equals(action)) {
                service.update(cart, positiveInt(request.getParameter("bookId")), positiveInt(request.getParameter("quantity")));
                message = "updated";
            } else if ("/remove".equals(action)) {
                cart.remove(positiveInt(request.getParameter("bookId")));
                message = "removed";
            } else if ("/clear".equals(action)) {
                cart.clear();
                message = "cleared";
            } else { response.sendError(404); return; }
        } catch (IllegalArgumentException | ArithmeticException exception) { message = "invalid"; }
        response.sendRedirect(request.getContextPath() + "/cart?message=" + message);
    }

    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> cart(HttpSession session) {
        Object value = session.getAttribute(CART_KEY);
        if (value instanceof Map<?, ?>) return (Map<Integer, Integer>) value;
        Map<Integer, Integer> created = CartService_24133028.newCart();
        session.setAttribute(CART_KEY, created);
        return created;
    }

    private SessionUser_24133028 requireUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Object value = request.getSession(false) == null ? null : request.getSession(false).getAttribute("currentUser");
        if (value instanceof SessionUser_24133028 user && !user.isAdmin()) return user;
        response.sendRedirect(request.getContextPath() + (value == null ? "/login" : "/home"));
        return null;
    }

    private int positiveInt(String value) {
        try { int parsed = Integer.parseInt(value); if (parsed > 0) return parsed; }
        catch (RuntimeException ignored) { }
        throw new IllegalArgumentException("Giá trị không hợp lệ.");
    }
}
