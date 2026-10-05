package com.kiemtragiuaky.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;

@Entity
@Table(name = "rating")
public class Rating_24133028 {
    @EmbeddedId
    private RatingId_24133028 id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("userId")
    @JoinColumn(name = "userid", nullable = false)
    private User_24133028 user;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("bookId")
    @JoinColumn(name = "bookid", nullable = false)
    private Book_24133028 book;

    @Column(name = "rating")
    private Byte score;

    @Column(name = "review_text", columnDefinition = "text")
    private String reviewText;

    public RatingId_24133028 getId() { return id; }
    public void setId(RatingId_24133028 id) { this.id = id; }
    public User_24133028 getUser() { return user; }
    public void setUser(User_24133028 user) { this.user = user; }
    public Book_24133028 getBook() { return book; }
    public void setBook(Book_24133028 book) { this.book = book; }
    public Byte getScore() { return score; }
    public void setScore(Byte score) { this.score = score; }
    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }
}

