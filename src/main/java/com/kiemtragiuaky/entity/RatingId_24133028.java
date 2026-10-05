package com.kiemtragiuaky.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class RatingId_24133028 implements Serializable {
    @Column(name = "userid")
    private Integer userId;

    @Column(name = "bookid")
    private Integer bookId;

    public RatingId_24133028() {
    }

    public RatingId_24133028(Integer userId, Integer bookId) {
        this.userId = userId;
        this.bookId = bookId;
    }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getBookId() { return bookId; }
    public void setBookId(Integer bookId) { this.bookId = bookId; }

    @Override
    public boolean equals(Object other) {
        if (this == other) return true;
        if (!(other instanceof RatingId_24133028 that)) return false;
        return Objects.equals(userId, that.userId) && Objects.equals(bookId, that.bookId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, bookId);
    }
}

