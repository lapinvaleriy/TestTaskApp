package com.testtask.service.user.service;

import com.testtask.dao.user.dao.UserDao;
import com.testtask.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public void save(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userDao.save(user);
    }

    @Override
    public User findUserByEmail(String userEmail) {
        return userDao.findUserByEmail(userEmail);
    }

    @Override
    public User loginValidation(String userEmail, String password) {
        if (userEmail == null || userEmail.isEmpty() || password.isEmpty() || password == null) {
            return null;
        }

        User user = userDao.findUserByEmail(userEmail);

        if (user == null)
            return null;

        if (bCryptPasswordEncoder.matches(password, user.getPassword())) {
            return user;
        } else {
            return null;
        }
    }
}
