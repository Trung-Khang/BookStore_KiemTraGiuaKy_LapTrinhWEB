package com.kiemtragiuaky.dao;

import com.kiemtragiuaky.entity.Order_24133028;
import java.util.Map;

public interface IOrderDao_24133028 {
    Order_24133028 createCodOrder(int userId, String name, String phone, String email, String address, Map<Integer, Integer> quantities);
}
