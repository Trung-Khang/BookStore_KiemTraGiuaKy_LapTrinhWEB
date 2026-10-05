package com.kiemtragiuaky.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
public class Order_24133028 {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User_24133028 user;

    @Column(name = "recipient_name", nullable = false, length = 100)
    private String recipientName;
    @Column(name = "recipient_phone", nullable = false, length = 30)
    private String recipientPhone;
    @Column(name = "recipient_email", nullable = false, length = 254)
    private String recipientEmail;
    @Column(name = "shipping_address", nullable = false, length = 500)
    private String shippingAddress;
    @Column(name = "payment_method", nullable = false, length = 20)
    private String paymentMethod;
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private OrderStatus_24133028 status;
    @Column(name = "total_amount", nullable = false, precision = 12, scale = 2)
    private BigDecimal totalAmount;
    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "order", cascade = CascadeType.PERSIST, orphanRemoval = true)
    private List<OrderItem_24133028> items = new ArrayList<>();

    public void addItem(OrderItem_24133028 item) { items.add(item); item.setOrder(this); }
    public Integer getId() { return id; }
    public User_24133028 getUser() { return user; }
    public void setUser(User_24133028 user) { this.user = user; }
    public String getRecipientName() { return recipientName; }
    public void setRecipientName(String value) { recipientName = value; }
    public String getRecipientPhone() { return recipientPhone; }
    public void setRecipientPhone(String value) { recipientPhone = value; }
    public String getRecipientEmail() { return recipientEmail; }
    public void setRecipientEmail(String value) { recipientEmail = value; }
    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String value) { shippingAddress = value; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String value) { paymentMethod = value; }
    public OrderStatus_24133028 getStatus() { return status; }
    public void setStatus(OrderStatus_24133028 value) { status = value; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal value) { totalAmount = value; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime value) { createdAt = value; }
    public List<OrderItem_24133028> getItems() { return items; }
}
