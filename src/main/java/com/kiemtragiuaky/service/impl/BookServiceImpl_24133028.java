package com.kiemtragiuaky.service.impl;

import com.kiemtragiuaky.dao.IBookDao_24133028;
import com.kiemtragiuaky.dao.impl.BookDaoImpl_24133028;
import com.kiemtragiuaky.entity.Book_24133028;
import com.kiemtragiuaky.service.IBookService_24133028;
import java.util.List;
import java.util.Optional;

public class BookServiceImpl_24133028 implements IBookService_24133028 {
    private final IBookDao_24133028 bookDao = new BookDaoImpl_24133028();

    @Override
    public List<Book_24133028> getHomeBooks() {
        return bookDao.findPage(1, 6);
    }

    @Override public List<Book_24133028> getHomeBooks(int page, int pageSize) { return bookDao.findPage(page, pageSize); }
    @Override public long countBooks() { return bookDao.count(); }
    @Override public Optional<Book_24133028> findById(int id) { return bookDao.findById(id); }
    @Override public Book_24133028 save(Book_24133028 b, java.util.Set<Integer> ids){return bookDao.save(b,ids);}
    @Override public void update(Book_24133028 b, java.util.Set<Integer> ids){bookDao.update(b,ids);}
    @Override public void delete(int id){bookDao.delete(id);}
}
