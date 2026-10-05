package com.kiemtragiuaky.dao.impl;

import com.kiemtragiuaky.config.JpaConfig_24133028;
import com.kiemtragiuaky.dao.IAuthorDao_24133028;
import com.kiemtragiuaky.entity.Author_24133028;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;
import jakarta.persistence.EntityTransaction;

public class AuthorDaoImpl_24133028 implements IAuthorDao_24133028 {
    @Override
    public List<Author_24133028> findAll() {
        EntityManager entityManager = JpaConfig_24133028.getEntityManagerFactory().createEntityManager();
        try {
            return entityManager.createQuery("select a from Author_24133028 a order by a.name", Author_24133028.class)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override public List<Author_24133028> findPage(int page, int size) {
        EntityManager em=JpaConfig_24133028.getEntityManagerFactory().createEntityManager(); try { return em.createQuery("select a from Author_24133028 a order by a.id", Author_24133028.class).setFirstResult((page-1)*size).setMaxResults(size).getResultList(); } finally { em.close(); }
    }
    @Override public long count() { EntityManager em=JpaConfig_24133028.getEntityManagerFactory().createEntityManager(); try { return em.createQuery("select count(a) from Author_24133028 a",Long.class).getSingleResult(); } finally { em.close(); } }
    @Override public Optional<Author_24133028> findById(int id) { EntityManager em=JpaConfig_24133028.getEntityManagerFactory().createEntityManager(); try { return Optional.ofNullable(em.find(Author_24133028.class,id)); } finally { em.close(); } }
    @Override public Author_24133028 save(Author_24133028 author) { EntityManager em=JpaConfig_24133028.getEntityManagerFactory().createEntityManager(); EntityTransaction tx=em.getTransaction(); try { tx.begin(); em.persist(author); tx.commit(); return author; } catch(RuntimeException e){if(tx.isActive())tx.rollback();throw e;} finally{em.close();} }
    @Override public void update(Author_24133028 author) { EntityManager em=JpaConfig_24133028.getEntityManagerFactory().createEntityManager(); EntityTransaction tx=em.getTransaction(); try {tx.begin();em.merge(author);tx.commit();}catch(RuntimeException e){if(tx.isActive())tx.rollback();throw e;}finally{em.close();} }
    @Override public void delete(int id) { EntityManager em=JpaConfig_24133028.getEntityManagerFactory().createEntityManager(); EntityTransaction tx=em.getTransaction(); try {tx.begin(); Author_24133028 a=em.find(Author_24133028.class,id); if(a!=null){a.getBooks().size(); if(!a.getBooks().isEmpty()) throw new IllegalStateException("Tác giả đang được sử dụng."); em.remove(a);} tx.commit();}catch(RuntimeException e){if(tx.isActive())tx.rollback();throw e;}finally{em.close();} }
}
