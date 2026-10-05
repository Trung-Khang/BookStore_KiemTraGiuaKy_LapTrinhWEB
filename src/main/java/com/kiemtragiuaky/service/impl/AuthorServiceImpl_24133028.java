package com.kiemtragiuaky.service.impl;

import com.kiemtragiuaky.dao.IAuthorDao_24133028;
import com.kiemtragiuaky.dao.impl.AuthorDaoImpl_24133028;
import com.kiemtragiuaky.entity.Author_24133028;
import com.kiemtragiuaky.service.IAuthorService_24133028;
import java.util.List;
import java.util.Optional;

public class AuthorServiceImpl_24133028 implements IAuthorService_24133028 {
    private final IAuthorDao_24133028 authorDao = new AuthorDaoImpl_24133028();

    @Override
    public List<Author_24133028> getAllAuthors() {
        return authorDao.findAll();
    }
    @Override public List<Author_24133028> getPage(int page,int size){return authorDao.findPage(page,size);}
    @Override public long count(){return authorDao.count();}
    @Override public Optional<Author_24133028> findById(int id){return authorDao.findById(id);}
    @Override public Author_24133028 save(Author_24133028 a){return authorDao.save(a);}
    @Override public void update(Author_24133028 a){authorDao.update(a);}
    @Override public void delete(int id){authorDao.delete(id);}
}
