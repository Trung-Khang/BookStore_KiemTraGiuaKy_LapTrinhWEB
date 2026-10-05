package com.kiemtragiuaky.controller;

import com.kiemtragiuaky.service.CartService_24133028;
import com.kiemtragiuaky.service.CartService_24133028.CartLine_24133028;
import com.kiemtragiuaky.service.IOrderService_24133028;
import com.kiemtragiuaky.service.impl.OrderServiceImpl_24133028;
import com.kiemtragiuaky.util.SessionUser_24133028;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutController_24133028 extends HttpServlet {
    private static final String CART_KEY = "shoppingCart";
    private final CartService_24133028 cartService = new CartService_24133028();
    private final IOrderService_24133028 orderService = new OrderServiceImpl_24133028();

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (requireUser(request, response) == null) return;
        Map<Integer, Integer> cart = cart(request.getSession());
        List<CartLine_24133028> lines = cartService.lines(cart);
        if (lines.isEmpty()) { response.sendRedirect(request.getContextPath() + "/cart"); return; }
        request.setAttribute("cartLines", lines);
        request.setAttribute("cartTotal", CartService_24133028.total(lines));
        request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp").include(request, response);
    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUser_24133028 user = requireUser(request, response);
        if (user == null) return;
        HttpSession session = request.getSession();
        synchronized (session) {
            Map<Integer, Integer> cart = cart(session);
            try {
                var order = orderService.checkoutCod(user.getId(), request.getParameter("recipientName"), request.getParameter("recipientPhone"), request.getParameter("recipientEmail"), request.getParameter("shippingAddress"), Map.copyOf(cart));
                cart.clear();
                session.setAttribute("checkoutOrderId", order.getId());
                response.sendRedirect(request.getContextPath() + "/cart?message=order");
            } catch (IllegalArgumentException exception) {
                request.setAttribute("error", exception.getMessage());
                renderCheckout(request, response, cart);
            } catch (RuntimeException exception) {
                getServletContext().log("COD checkout failed for user id " + user.getId(), exception);
                request.setAttribute("error", "Không thể tạo đơn hàng lúc này. Vui lòng kiểm tra giỏ hàng và thử lại.");
                renderCheckout(request, response, cart);
            }
        }
    }

    private void renderCheckout(HttpServletRequest request, HttpServletResponse response, Map<Integer, Integer> cart) throws ServletException, IOException {
        List<CartLine_24133028> lines = cartService.lines(cart);
        request.setAttribute("cartLines", lines);
        request.setAttribute("cartTotal", CartService_24133028.total(lines));
        request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp").include(request, response);
    }

    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> cart(HttpSession session) {
        Object value = session.getAttribute(CART_KEY);
        if (value instanceof Map<?, ?> map) return (Map<Integer, Integer>) map;
        Map<Integer, Integer> created = CartService_24133028.newCart();
        session.setAttribute(CART_KEY, created);
        return created;
    }

    private SessionUser_24133028 requireUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        Object value = session == null ? null : session.getAttribute("currentUser");
        if (value instanceof SessionUser_24133028 user && !user.isAdmin()) return user;
        response.sendRedirect(request.getContextPath() + (value == null ? "/login" : "/home"));
        return null;
    }
}
