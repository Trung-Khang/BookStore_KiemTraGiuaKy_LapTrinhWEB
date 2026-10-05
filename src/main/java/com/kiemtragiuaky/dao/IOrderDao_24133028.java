package com.kiemtragiuaky.dao;

import com.kiemtragiuaky.entity.Order_24133028;
import java.util.Map;
import java.util.List;
import java.util.Optional;
import com.kiemtragiuaky.entity.OrderStatus_24133028;

public interface IOrderDao_24133028 {
    Order_24133028 createCodOrder(int userId, String name, String phone, String email, String address, Map<Integer, Integer> quantities);
    List<Order_24133028> findByUser(int userId, OrderStatus_24133028 status);
    Optional<Order_24133028> findByIdAndUser(int orderId, int userId);
    List<Order_24133028> findAdminPage(int page, int pageSize, OrderStatus_24133028 status);
    long countAdminOrders(OrderStatus_24133028 status);
    void updateAdminStatus(int orderId, OrderStatus_24133028 status);
    void deleteCancelledOrder(int orderId);
}
