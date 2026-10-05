package com.kiemtragiuaky.service;

import com.kiemtragiuaky.entity.Order_24133028;
import java.util.Map;
import java.util.List;
import java.util.Optional;
import com.kiemtragiuaky.entity.OrderStatus_24133028;

public interface IOrderService_24133028 {
    Order_24133028 checkoutCod(int userId, String name, String phone, String email, String address, Map<Integer, Integer> cart);
    List<Order_24133028> history(int userId, OrderStatus_24133028 status);
    Optional<Order_24133028> findOwnedOrder(int orderId, int userId);
    List<Order_24133028> adminPage(int page, int pageSize, OrderStatus_24133028 status);
    long countAdminOrders(OrderStatus_24133028 status);
    void updateAdminStatus(int orderId, OrderStatus_24133028 status);
    void deleteCancelledOrder(int orderId);
}
