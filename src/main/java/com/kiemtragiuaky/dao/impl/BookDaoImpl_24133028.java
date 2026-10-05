package com.kiemtragiuaky.dao.impl;

import com.kiemtragiuaky.config.JpaConfig_24133028;
import com.kiemtragiuaky.dao.IBookDao_24133028;
import com.kiemtragiuaky.entity.Book_24133028;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.stream.Collectors;
import java.util.Optional;
import jakarta.persistence.EntityTransaction;
import com.kiemtragiuaky.entity.Author_24133028;
import com.kiemtragiuaky.entity.Rating_24133028;
import java.util.Set;
import java.util.LinkedHashSet;

public class BookDaoImpl_24133028 implements IBookDao_24133028 {
    @Override
    public List<Book_24133028> findPage(int page, int pageSize) {
        EntityManager entityManager = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            List<Book_24133028> fetchedBooks = entityManager.createQuery("select b from Book_24133028 b left join fetch b.authors order by b.id", Book_24133028.class)
                    .setFirstResult(Math.max(0, page - 1) * pageSize)
                    .setMaxResults(pageSize)
                    .getResultList();
            List<Book_24133028> books = new java.util.ArrayList<>(new LinkedHashMap<Integer, Book_24133028>() {{
                fetchedBooks.forEach(book -> put(book.getId(), book));
            }}.values());
            if (!books.isEmpty()) {
                Map<Integer, Long> reviewCounts = entityManager.createQuery("select r.book.id, count(r) from Rating_24133028 r where r.book.id in :ids group by r.book.id", Object[].class)
                        .setParameter("ids", books.stream().map(Book_24133028::getId).toList())
                        .getResultList().stream().collect(Collectors.toMap(row -> (Integer) row[0], row -> (Long) row[1]));
                books.forEach(book -> book.setReviewCount(reviewCounts.getOrDefault(book.getId(), 0L)));
            }
            return books;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public long count() {
        EntityManager entityManager = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try { return entityManager.createQuery("select count(b) from Book_24133028 b", Long.class).getSingleResult(); }
        finally { entityManager.close(); }
    }

    @Override
    public Optional<Book_24133028> findById(int id) {
        EntityManager entityManager = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            return entityManager.createQuery("select b from Book_24133028 b left join fetch b.authors where b.id = :id", Book_24133028.class)
                    .setParameter("id", id).setMaxResults(1).getResultStream().findFirst();
        } finally { entityManager.close(); }
    }

    @Override public Book_24133028 save(Book_24133028 book, Set<Integer> authorIds) { EntityManager em=JpaConfig_24133028.getEntityManagerFactory().createEntityManager(); EntityTransaction tx=em.getTransaction(); try{tx.begin(); attachAuthors(em,book,authorIds);em.persist(book);tx.commit();return book;}catch(RuntimeException e){if(tx.isActive())tx.rollback();throw e;}finally{em.close();} }
    @Override public void update(Book_24133028 book, Set<Integer> authorIds) { EntityManager em=JpaConfig_24133028.getEntityManagerFactory().createEntityManager(); EntityTransaction tx=em.getTransaction(); try{tx.begin();Book_24133028 managed=em.find(Book_24133028.class,book.getId()); if(managed==null)throw new IllegalArgumentException("Không tìm thấy sách."); managed.setIsbn(book.getIsbn());managed.setTitle(book.getTitle());managed.setPublisher(book.getPublisher());managed.setPrice(book.getPrice());managed.setDescription(book.getDescription());managed.setPublishDate(book.getPublishDate());managed.setCoverImage(book.getCoverImage());managed.setQuantity(book.getQuantity());managed.getAuthors().clear();attachAuthors(em,managed,authorIds);tx.commit();}catch(RuntimeException e){if(tx.isActive())tx.rollback();throw e;}finally{em.close();} }
    @Override public void delete(int id) { EntityManager em=JpaConfig_24133028.getEntityManagerFactory().createEntityManager(); EntityTransaction tx=em.getTransaction(); try{tx.begin();Book_24133028 book=em.find(Book_24133028.class,id);if(book!=null){em.createQuery("delete from Rating_24133028 r where r.book.id=:id").setParameter("id",id).executeUpdate();book.getAuthors().clear();em.remove(book);}tx.commit();}catch(RuntimeException e){if(tx.isActive())tx.rollback();throw e;}finally{em.close();} }
    private void attachAuthors(EntityManager em, Book_24133028 book, Set<Integer> ids){Set<Author_24133028> authors=new LinkedHashSet<>();if(ids!=null)for(Integer id:ids){Author_24133028 a=em.find(Author_24133028.class,id);if(a!=null)authors.add(a);}book.setAuthors(authors);}
}
