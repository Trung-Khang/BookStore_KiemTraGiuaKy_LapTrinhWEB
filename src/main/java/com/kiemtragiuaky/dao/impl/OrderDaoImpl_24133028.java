package com.kiemtragiuaky.dao.impl;

import com.kiemtragiuaky.config.JpaConfig_24133028;
import com.kiemtragiuaky.dao.IOrderDao_24133028;
import com.kiemtragiuaky.entity.Book_24133028;
import com.kiemtragiuaky.entity.OrderItem_24133028;
import com.kiemtragiuaky.entity.OrderStatus_24133028;
import com.kiemtragiuaky.entity.Order_24133028;
import com.kiemtragiuaky.entity.User_24133028;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.LockModeType;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Map;

public class OrderDaoImpl_24133028 implements IOrderDao_24133028 {
    @Override
    public Order_24133028 createCodOrder(int userId, String name, String phone, String email, String address, Map<Integer, Integer> quantities) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            User_24133028 user = em.find(User_24133028.class, userId);
            if (user == null || !user.isEmailVerified()) throw new IllegalArgumentException("Tài khoản không hợp lệ.");
            if (quantities == null || quantities.isEmpty()) throw new IllegalArgumentException("Giỏ hàng đang trống.");

            Order_24133028 order = new Order_24133028();
            order.setUser(user);
            order.setRecipientName(name);
            order.setRecipientPhone(phone);
            order.setRecipientEmail(email);
            order.setShippingAddress(address);
            order.setPaymentMethod("COD");
            order.setStatus(OrderStatus_24133028.NEW);
            order.setCreatedAt(LocalDateTime.now());
            BigDecimal total = BigDecimal.ZERO;

            for (var entry : quantities.entrySet()) {
                Integer id = entry.getKey();
                Integer quantity = entry.getValue();
                if (id == null || quantity == null || quantity <= 0) throw new IllegalArgumentException("Số lượng sản phẩm không hợp lệ.");
                Book_24133028 book = em.find(Book_24133028.class, id, LockModeType.PESSIMISTIC_WRITE);
                if (book == null) throw new IllegalArgumentException("Có sách trong giỏ không còn tồn tại.");
                if (book.getPrice() == null || book.getPrice().signum() < 0) throw new IllegalArgumentException("Giá sách không hợp lệ.");
                if (book.getQuantity() == null || quantity > book.getQuantity()) throw new IllegalArgumentException("Tồn kho không đủ cho sách: " + book.getTitle());

                BigDecimal lineTotal = book.getPrice().multiply(BigDecimal.valueOf(quantity));
                OrderItem_24133028 item = new OrderItem_24133028();
                item.setBook(book);
                item.setBookTitle(book.getTitle());
                item.setUnitPrice(book.getPrice());
                item.setQuantity(quantity);
                item.setLineTotal(lineTotal);
                order.addItem(item);
                book.setQuantity(book.getQuantity() - quantity);
                total = total.add(lineTotal);
            }
            order.setTotalAmount(total);
            em.persist(order);
            tx.commit();
            return order;
        } catch (RuntimeException exception) {
            if (tx.isActive()) tx.rollback();
            throw exception;
        } finally { em.close(); }
    }
}
