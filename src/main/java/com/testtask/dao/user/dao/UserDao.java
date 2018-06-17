package com.testtask.dao.user.dao;

import com.testtask.model.User;

public interface UserDao {
    void save(User user);

    User findUserByEmail(String userEmail);
}
