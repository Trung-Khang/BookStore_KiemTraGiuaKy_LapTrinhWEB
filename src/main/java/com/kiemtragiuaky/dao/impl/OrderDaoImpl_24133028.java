package com.kiemtragiuaky.dao.impl;

import com.kiemtragiuaky.config.JpaConfig_24133028;
import com.kiemtragiuaky.dao.IOrderDao_24133028;
import com.kiemtragiuaky.entity.Book_24133028;
import com.kiemtragiuaky.entity.OrderItem_24133028;
import com.kiemtragiuaky.entity.Order_24133028;
import com.kiemtragiuaky.entity.User_24133028;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.LockModeType;
import com.kiemtragiuaky.entity.OrderStatus_24133028;
import java.util.List;
import java.util.Optional;
import java.util.Comparator;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Map;

public class OrderDaoImpl_24133028 implements IOrderDao_24133028 {
    @Override
    public List<Order_24133028> findByUser(int userId, OrderStatus_24133028 status) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            String jpql = "select distinct o from Order_24133028 o left join fetch o.items where o.user.id = :userId";
            if (status != null) jpql += " and o.status = :status";
            jpql += " order by o.createdAt desc, o.id desc";
            var query = em.createQuery(jpql, Order_24133028.class).setParameter("userId", userId);
            if (status != null) query.setParameter("status", status);
            return query.getResultList();
        } finally { em.close(); }
    }

    @Override
    public Optional<Order_24133028> findByIdAndUser(int orderId, int userId) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("select distinct o from Order_24133028 o left join fetch o.items where o.id = :id and o.user.id = :userId", Order_24133028.class)
                    .setParameter("id", orderId).setParameter("userId", userId).getResultStream().findFirst();
        } finally { em.close(); }
    }

    @Override
    public List<Order_24133028> findAdminPage(int page, int pageSize, OrderStatus_24133028 status) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            String idsJpql = "select o.id from Order_24133028 o";
            if (status != null) idsJpql += " where o.status = :status";
            idsJpql += " order by o.createdAt desc, o.id desc";
            var idsQuery = em.createQuery(idsJpql, Integer.class)
                    .setFirstResult((page - 1) * pageSize)
                    .setMaxResults(pageSize);
            if (status != null) idsQuery.setParameter("status", status);
            List<Integer> ids = idsQuery.getResultList();
            if (ids.isEmpty()) return List.of();

            List<Order_24133028> result = em.createQuery(
                            "select distinct o from Order_24133028 o join fetch o.user left join fetch o.items where o.id in :ids",
                            Order_24133028.class)
                    .setParameter("ids", ids)
                    .getResultList();
            result.sort(Comparator.comparing(Order_24133028::getCreatedAt).reversed()
                    .thenComparing(Order_24133028::getId, Comparator.reverseOrder()));
            return result;
        } finally {
            em.close();
        }
    }

    @Override
    public long countAdminOrders(OrderStatus_24133028 status) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            String jpql = "select count(o) from Order_24133028 o";
            if (status != null) jpql += " where o.status = :status";
            var query = em.createQuery(jpql, Long.class);
            if (status != null) query.setParameter("status", status);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public void updateAdminStatus(int orderId, OrderStatus_24133028 status) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Order_24133028 order = em.find(Order_24133028.class, orderId, LockModeType.PESSIMISTIC_WRITE);
            if (order == null) throw new IllegalArgumentException("Không tìm thấy đơn hàng.");
            OrderStatus_24133028 previous = order.getStatus();
            if (previous == status) {
                tx.commit();
                return;
            }
            if (previous == OrderStatus_24133028.CANCELLED || previous == OrderStatus_24133028.RETURNED) {
                throw new IllegalStateException("Đơn đã hủy/hoàn là trạng thái cuối, không thể đổi tiếp.");
            }
            if (status == OrderStatus_24133028.CANCELLED) {
                if (previous == OrderStatus_24133028.SHIPPING
                        || previous == OrderStatus_24133028.DELIVERING
                        || previous == OrderStatus_24133028.DELIVERED) {
                    throw new IllegalStateException("Đơn đã bàn giao vận chuyển không thể hủy tại đây.");
                }
                for (OrderItem_24133028 item : order.getItems()) {
                    Book_24133028 book = item.getBook();
                    if (book != null && book.getQuantity() != null) {
                        book.setQuantity(book.getQuantity() + item.getQuantity());
                    }
                }
            }
            order.setStatus(status);
            tx.commit();
        } catch (RuntimeException exception) {
            if (tx.isActive()) tx.rollback();
            throw exception;
        } finally {
            em.close();
        }
    }

    @Override
    public void deleteCancelledOrder(int orderId) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Order_24133028 order = em.find(Order_24133028.class, orderId, LockModeType.PESSIMISTIC_WRITE);
            if (order == null) throw new IllegalArgumentException("Không tìm thấy đơn hàng.");
            if (order.getStatus() != OrderStatus_24133028.CANCELLED) {
                throw new IllegalStateException("Chỉ có thể xóa đơn hàng đã hủy.");
            }
            em.createQuery("delete from OrderItem_24133028 i where i.order.id = :orderId")
                    .setParameter("orderId", orderId)
                    .executeUpdate();
            em.remove(order);
            tx.commit();
        } catch (RuntimeException exception) {
            if (tx.isActive()) tx.rollback();
            throw exception;
        } finally {
            em.close();
        }
    }

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
