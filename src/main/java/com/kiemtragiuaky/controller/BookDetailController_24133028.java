package com.kiemtragiuaky.controller;

import com.kiemtragiuaky.service.impl.BookServiceImpl_24133028;
import com.kiemtragiuaky.service.impl.RatingServiceImpl_24133028;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/book/detail")
public class BookDetailController_24133028 extends HttpServlet {
    private final BookServiceImpl_24133028 bookService = new BookServiceImpl_24133028();
    private final RatingServiceImpl_24133028 ratingService = new RatingServiceImpl_24133028();

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = parseId(request.getParameter("id"));
        if (id == null) { response.sendError(400, "Book id không hợp lệ"); return; }
        var book = bookService.findById(id);
        if (book.isEmpty()) { response.sendError(404, "Không tìm thấy sách"); return; }
        request.setAttribute("book", book.get());
        request.setAttribute("reviews", ratingService.getBookRatings(id));
        request.setAttribute("reviewSuccess", "success".equals(request.getParameter("review")));
        request.getRequestDispatcher("/WEB-INF/views/user/book-detail.jsp").include(request, response);
    }
    private Integer parseId(String value) { try { return value == null ? null : Integer.valueOf(value); } catch (NumberFormatException e) { return null; } }
}
