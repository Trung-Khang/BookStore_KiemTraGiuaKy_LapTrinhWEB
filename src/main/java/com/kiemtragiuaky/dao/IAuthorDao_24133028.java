package com.kiemtragiuaky.dao;

import com.kiemtragiuaky.entity.Author_24133028;
import java.util.List;
import java.util.Optional;

public interface IAuthorDao_24133028 {
    List<Author_24133028> findAll();
    List<Author_24133028> findPage(int page, int size);
    long count();
    Optional<Author_24133028> findById(int id);
    Author_24133028 save(Author_24133028 author);
    void update(Author_24133028 author);
    void delete(int id);
}
