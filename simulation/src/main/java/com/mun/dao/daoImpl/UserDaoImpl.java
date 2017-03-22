package com.mun.dao.daoImpl;

import com.mun.dao.UserDao;
import com.mun.entity.UserEntity;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wanhui on 22/03/2017.
 */
@Repository
public class UserDaoImpl implements UserDao{


    public boolean addUser(UserEntity user) {
        return false;
    }

    public boolean deleteUser(UserEntity user) {
        return false;
    }

    public List<UserEntity> findAllUser() {
        return null;
    }

    public UserEntity getUserByID(Integer id) {
        return null;
    }

    public UserEntity getUserByFullName(String name) {
        return null;
    }

    public List<UserEntity> getUserListByName(String name) {
        return null;
    }

    public boolean UpdateUser(UserEntity user) {
        return false;
    }
}
