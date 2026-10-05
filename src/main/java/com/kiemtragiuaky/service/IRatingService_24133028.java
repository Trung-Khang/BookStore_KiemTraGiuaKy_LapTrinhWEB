package com.kiemtragiuaky.service;

import com.kiemtragiuaky.entity.Rating_24133028;
import java.util.List;

public interface IRatingService_24133028 {
    List<Rating_24133028> getBookRatings(int bookId);
    void saveOrUpdate(int userId, int bookId, byte score, String reviewText);
}
