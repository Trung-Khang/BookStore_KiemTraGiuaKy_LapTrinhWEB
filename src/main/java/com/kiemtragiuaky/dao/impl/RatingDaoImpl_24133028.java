package com.kiemtragiuaky.dao.impl;

import com.kiemtragiuaky.config.JpaConfig_24133028;
import com.kiemtragiuaky.dao.IRatingDao_24133028;
import com.kiemtragiuaky.entity.Rating_24133028;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import com.kiemtragiuaky.entity.RatingId_24133028;
import com.kiemtragiuaky.entity.Book_24133028;
import com.kiemtragiuaky.entity.User_24133028;
import java.util.List;

public class RatingDaoImpl_24133028 implements IRatingDao_24133028 {
    @Override
    public List<Rating_24133028> findByBookId(int bookId) {
        EntityManager entityManager = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            return entityManager.createQuery("select r from Rating_24133028 r join fetch r.user where r.book.id = :bookId order by r.id.userId", Rating_24133028.class)
                    .setParameter("bookId", bookId)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void saveOrUpdate(int userId, int bookId, byte score, String reviewText) {
        EntityManager em = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            User_24133028 user = em.find(User_24133028.class, userId);
            Book_24133028 book = em.find(Book_24133028.class, bookId);
            if (user == null || book == null) throw new IllegalArgumentException("Không tìm thấy dữ liệu review.");
            RatingId_24133028 id = new RatingId_24133028(userId, bookId);
            Rating_24133028 rating = em.find(Rating_24133028.class, id);
            if (rating == null) { rating = new Rating_24133028(); rating.setId(id); rating.setUser(user); rating.setBook(book); em.persist(rating); }
            rating.setScore(score); rating.setReviewText(reviewText);
            tx.commit();
        } catch (RuntimeException exception) { if (tx.isActive()) tx.rollback(); throw exception; }
        finally { em.close(); }
    }
}
