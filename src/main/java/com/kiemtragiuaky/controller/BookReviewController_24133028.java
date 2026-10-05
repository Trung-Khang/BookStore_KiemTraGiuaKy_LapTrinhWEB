package com.kiemtragiuaky.controller;

import com.kiemtragiuaky.service.impl.RatingServiceImpl_24133028;
import com.kiemtragiuaky.util.SessionUser_24133028;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/book/review")
public class BookReviewController_24133028 extends HttpServlet {
    private final RatingServiceImpl_24133028 ratingService = new RatingServiceImpl_24133028();

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Object account = request.getSession(false) == null ? null : request.getSession(false).getAttribute("currentUser");
        if (!(account instanceof SessionUser_24133028 user)) { response.sendRedirect(request.getContextPath() + "/login"); return; }
        Integer bookId = parse(request.getParameter("bookId"));
        Integer rating = parse(request.getParameter("rating"));
        String text = request.getParameter("reviewText") == null ? "" : request.getParameter("reviewText").trim();
        if (bookId == null || rating == null || rating < 1 || rating > 5 || text.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/book/detail?id=" + (bookId == null ? "" : bookId) + "&review=error"); return;
        }
        try { ratingService.saveOrUpdate(user.getId(), bookId, rating.byteValue(), text); }
        catch (RuntimeException exception) { response.sendRedirect(request.getContextPath() + "/book/detail?id=" + bookId + "&review=error"); return; }
        response.sendRedirect(request.getContextPath() + "/book/detail?id=" + bookId + "&review=success");
    }
    private Integer parse(String value) { try { return value == null ? null : Integer.valueOf(value); } catch (NumberFormatException e) { return null; } }
}
