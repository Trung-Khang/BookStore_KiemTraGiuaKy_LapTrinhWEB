package com.kiemtragiuaky.dao;

import com.kiemtragiuaky.entity.Book_24133028;
import java.util.List;
import java.util.Optional;

public interface IBookDao_24133028 {
    List<Book_24133028> findPage(int page, int pageSize);
    long count();
    Optional<Book_24133028> findById(int id);
    Book_24133028 save(Book_24133028 book, java.util.Set<Integer> authorIds);
    void update(Book_24133028 book, java.util.Set<Integer> authorIds);
    void delete(int id);
}
