package com.testtask.service.user.service;

import com.testtask.model.User;

public interface UserService {
    void save(User user);

    User findUserByEmail(String userEmail);

    User loginValidation(String userEmail, String password);
}
