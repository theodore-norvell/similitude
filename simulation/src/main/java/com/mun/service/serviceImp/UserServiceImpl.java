package com.mun.service.serviceImp;

import com.mun.dao.UserDao;
import com.mun.entity.UserEntity;
import com.mun.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * Created by wanhui on 23/03/2017.
 */
@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDao userDao;

    public boolean login(String name, String password) {
        UserEntity user = userDao.findByName(name);
        if(user.getPassword() == password) {
            return true;
        }else {
            return false;
        }
    }
}
