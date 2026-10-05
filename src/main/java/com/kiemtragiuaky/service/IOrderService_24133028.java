package com.kiemtragiuaky.service;

import com.kiemtragiuaky.entity.Order_24133028;
import java.util.Map;

public interface IOrderService_24133028 {
    Order_24133028 checkoutCod(int userId, String name, String phone, String email, String address, Map<Integer, Integer> cart);
}
