package com.kiemtragiuaky.service;

import com.kiemtragiuaky.service.impl.OrderServiceImpl_24133028;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class CheckoutValidationTest_24133028 {
    @Test void trimsAndAcceptsValidContact() {
        var contact = OrderServiceImpl_24133028.validateContact(" Khang ", "0900000000", "khang@example.com", "  1 Test Street  ");
        assertEquals("Khang", contact.name());
        assertEquals("1 Test Street", contact.address());
    }

    @Test void rejectsMissingOrMalformedCheckoutContact() {
        assertThrows(IllegalArgumentException.class, () -> OrderServiceImpl_24133028.validateContact(" ", "0900000000", "a@b.com", "Address"));
        assertThrows(IllegalArgumentException.class, () -> OrderServiceImpl_24133028.validateContact("Khang", "123", "a@b.com", "Address"));
        assertThrows(IllegalArgumentException.class, () -> OrderServiceImpl_24133028.validateContact("Khang", "0900000000", "invalid", "Address"));
        assertThrows(IllegalArgumentException.class, () -> OrderServiceImpl_24133028.validateContact("Khang", "0900000000", "a@b.com", " "));
    }
}
