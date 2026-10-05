package com.kiemtragiuaky.service;

import com.kiemtragiuaky.entity.Book_24133028;
import java.util.List;
import java.util.Optional;

public interface IBookService_24133028 {
    List<Book_24133028> getHomeBooks();
    List<Book_24133028> getHomeBooks(int page, int pageSize);
    long countBooks();
    Optional<Book_24133028> findById(int id);
    Book_24133028 save(Book_24133028 book, java.util.Set<Integer> authorIds);
    void update(Book_24133028 book, java.util.Set<Integer> authorIds);
    void delete(int id);
}
