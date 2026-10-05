package com.kiemtragiuaky.entity;

public enum OrderStatus_24133028 {
    NEW("Đơn hàng mới"),
    CONFIRMED("Đã xác nhận"),
    PREPARING("Chuẩn bị hàng"),
    SHIPPING("Vận chuyển"),
    DELIVERING("Đang giao hàng"),
    DELIVERED("Đã giao"),
    CANCELLED("Đơn hàng hủy"),
    RETURNED("Đơn hàng hoàn");

    private final String label;
    OrderStatus_24133028(String label) { this.label = label; }
    public String getLabel() { return label; }
}
