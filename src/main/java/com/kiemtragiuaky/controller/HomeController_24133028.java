package com.kiemtragiuaky.controller;

import com.kiemtragiuaky.config.JpaConfig_24133028;
import com.kiemtragiuaky.service.IBookService_24133028;
import com.kiemtragiuaky.service.impl.BookServiceImpl_24133028;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/home")
public class HomeController_24133028 extends HttpServlet {
    private final IBookService_24133028 bookService = new BookServiceImpl_24133028();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = parsePage(request.getParameter("page"));
        int pageSize = 6;
        long totalBooks = JpaConfig_24133028.isAvailable() ? bookService.countBooks() : 0;
        int totalPages = Math.max(1, (int) Math.ceil((double) totalBooks / pageSize));
        if (page > totalPages) { response.sendRedirect(request.getContextPath() + "/home?page=" + totalPages); return; }
        request.setAttribute("books", JpaConfig_24133028.isAvailable() ? bookService.getHomeBooks(page, pageSize) : java.util.List.of());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/WEB-INF/views/user/home.jsp").include(request, response);
    }

    private int parsePage(String value) {
        try { return Math.max(1, Integer.parseInt(value)); }
        catch (Exception exception) { return 1; }
    }
}
