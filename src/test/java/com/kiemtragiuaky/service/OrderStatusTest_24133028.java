package com.kiemtragiuaky.service;

import com.kiemtragiuaky.entity.OrderStatus_24133028;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class OrderStatusTest_24133028 {
    @Test void definesAllRequestedStableCodesAndVietnameseLabels() {
        assertEquals(8, OrderStatus_24133028.values().length);
        assertEquals("Đơn hàng mới", OrderStatus_24133028.NEW.getLabel());
        assertEquals("Đã xác nhận", OrderStatus_24133028.CONFIRMED.getLabel());
        assertEquals("Chuẩn bị hàng", OrderStatus_24133028.PREPARING.getLabel());
        assertEquals("Vận chuyển", OrderStatus_24133028.SHIPPING.getLabel());
        assertEquals("Đang giao hàng", OrderStatus_24133028.DELIVERING.getLabel());
        assertEquals("Đã giao", OrderStatus_24133028.DELIVERED.getLabel());
        assertEquals("Đơn hàng hủy", OrderStatus_24133028.CANCELLED.getLabel());
        assertEquals("Đơn hàng hoàn", OrderStatus_24133028.RETURNED.getLabel());
    }
}
