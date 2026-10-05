package com.kiemtragiuaky.service.impl;

import com.kiemtragiuaky.dao.IRatingDao_24133028;
import com.kiemtragiuaky.dao.impl.RatingDaoImpl_24133028;
import com.kiemtragiuaky.entity.Rating_24133028;
import com.kiemtragiuaky.service.IRatingService_24133028;
import java.util.List;

public class RatingServiceImpl_24133028 implements IRatingService_24133028 {
    private final IRatingDao_24133028 ratingDao = new RatingDaoImpl_24133028();

    @Override
    public List<Rating_24133028> getBookRatings(int bookId) {
        return ratingDao.findByBookId(bookId);
    }
    @Override public void saveOrUpdate(int userId, int bookId, byte score, String reviewText) { ratingDao.saveOrUpdate(userId, bookId, score, reviewText); }
}
