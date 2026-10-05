package com.kiemtragiuaky.dao;

import com.kiemtragiuaky.entity.Rating_24133028;
import java.util.List;

public interface IRatingDao_24133028 {
    List<Rating_24133028> findByBookId(int bookId);
    void saveOrUpdate(int userId, int bookId, byte score, String reviewText);
}
