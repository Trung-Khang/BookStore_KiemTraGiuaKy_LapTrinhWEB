package com.kiemtragiuaky.service;

import com.kiemtragiuaky.entity.Book_24133028;
import com.kiemtragiuaky.service.impl.BookServiceImpl_24133028;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class CartService_24133028 {
    private final IBookService_24133028 books = new BookServiceImpl_24133028();

    public List<CartLine_24133028> lines(Map<Integer, Integer> cart) {
        List<CartLine_24133028> result = new ArrayList<>();
        if (cart == null) return result;
        for (var entry : cart.entrySet()) {
            books.findById(entry.getKey()).ifPresent(book -> result.add(new CartLine_24133028(book, entry.getValue())));
        }
        return result;
    }

    public void add(Map<Integer, Integer> cart, int bookId, int quantity) {
        Book_24133028 book = books.findById(bookId).orElseThrow(() -> new IllegalArgumentException("Không tìm thấy sách."));
        int next = Math.addExact(cart.getOrDefault(bookId, 0), quantity);
        validateQuantity(quantity, next, book.getQuantity());
        cart.put(bookId, next);
    }

    public void update(Map<Integer, Integer> cart, int bookId, int quantity) {
        Book_24133028 book = books.findById(bookId).orElseThrow(() -> new IllegalArgumentException("Sách không còn tồn tại."));
        validateQuantity(quantity, quantity, book.getQuantity());
        cart.put(bookId, quantity);
    }

    public static void validateQuantity(int requested, int resulting, Integer stock) {
        if (requested < 1) throw new IllegalArgumentException("Số lượng phải là số nguyên dương.");
        if (stock == null || stock < 1) throw new IllegalArgumentException("Sách hiện đã hết hàng.");
        if (resulting > stock) throw new IllegalArgumentException("Số lượng vượt quá tồn kho hiện tại.");
    }

    public static BigDecimal total(List<CartLine_24133028> lines) {
        return lines.stream().map(CartLine_24133028::getSubtotal).reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public static final class CartLine_24133028 {
        private final Book_24133028 book;
        private final int quantity;

        public CartLine_24133028(Book_24133028 book, int quantity) { this.book = book; this.quantity = quantity; }
        public Book_24133028 getBook() { return book; }
        public int getQuantity() { return quantity; }
        public BigDecimal getSubtotal() { return (book.getPrice() == null ? BigDecimal.ZERO : book.getPrice()).multiply(BigDecimal.valueOf(quantity)); }
    }

    public static Map<Integer, Integer> newCart() { return new LinkedHashMap<>(); }
}
