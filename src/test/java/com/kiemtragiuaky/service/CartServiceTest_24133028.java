package com.kiemtragiuaky.service;

import com.kiemtragiuaky.entity.Book_24133028;
import java.math.BigDecimal;
import java.util.List;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class CartServiceTest_24133028 {
    @Test void acceptsPositiveQuantityWithinStock() {
        assertDoesNotThrow(() -> CartService_24133028.validateQuantity(2, 4, 4));
    }

    @Test void rejectsZeroNegativeAndOverStock() {
        assertThrows(IllegalArgumentException.class, () -> CartService_24133028.validateQuantity(0, 0, 5));
        assertThrows(IllegalArgumentException.class, () -> CartService_24133028.validateQuantity(-1, -1, 5));
        assertThrows(IllegalArgumentException.class, () -> CartService_24133028.validateQuantity(3, 6, 5));
    }

    @Test void totalUsesBookPriceAndQuantity() {
        Book_24133028 book = new Book_24133028();
        book.setPrice(new BigDecimal("12.50"));
        assertEquals(new BigDecimal("25.00"), CartService_24133028.total(List.of(new CartService_24133028.CartLine_24133028(book, 2))));
    }
}
