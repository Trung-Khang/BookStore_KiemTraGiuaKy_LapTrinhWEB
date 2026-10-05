package com.kiemtragiuaky.service.impl;

import com.kiemtragiuaky.dao.IOrderDao_24133028;
import com.kiemtragiuaky.dao.impl.OrderDaoImpl_24133028;
import com.kiemtragiuaky.entity.Order_24133028;
import com.kiemtragiuaky.service.IOrderService_24133028;
import java.util.Map;
import java.util.List;
import java.util.Optional;
import java.util.regex.Pattern;
import com.kiemtragiuaky.entity.OrderStatus_24133028;

public class OrderServiceImpl_24133028 implements IOrderService_24133028 {
    private final IOrderDao_24133028 orders = new OrderDaoImpl_24133028();
    private static final Pattern EMAIL = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    private static final Pattern PHONE = Pattern.compile("^[0-9+(). -]{8,20}$");

    @Override
    public Order_24133028 checkoutCod(int userId, String name, String phone, String email, String address, Map<Integer, Integer> cart) {
        CheckoutContact_24133028 contact = validateContact(name, phone, email, address);
        return orders.createCodOrder(userId, contact.name(), contact.phone(), contact.email(), contact.address(), cart);
    }

    @Override public List<Order_24133028> history(int userId, OrderStatus_24133028 status) { return orders.findByUser(userId, status); }
    @Override public Optional<Order_24133028> findOwnedOrder(int orderId, int userId) { return orders.findByIdAndUser(orderId, userId); }

    public static CheckoutContact_24133028 validateContact(String name, String phone, String email, String address) {
        String cleanName = name == null ? "" : name.trim();
        String cleanPhone = phone == null ? "" : phone.trim();
        String cleanEmail = email == null ? "" : email.trim();
        String cleanAddress = address == null ? "" : address.trim();
        if (cleanName.isEmpty() || cleanName.length() > 100) throw new IllegalArgumentException("Họ tên người nhận là bắt buộc.");
        if (!PHONE.matcher(cleanPhone).matches()) throw new IllegalArgumentException("Số điện thoại không hợp lệ.");
        if (cleanEmail.length() > 254 || !EMAIL.matcher(cleanEmail).matches()) throw new IllegalArgumentException("Email không hợp lệ.");
        if (cleanAddress.isEmpty() || cleanAddress.length() > 500) throw new IllegalArgumentException("Địa chỉ giao hàng là bắt buộc.");
        return new CheckoutContact_24133028(cleanName, cleanPhone, cleanEmail, cleanAddress);
    }

    public record CheckoutContact_24133028(String name, String phone, String email, String address) { }
}
