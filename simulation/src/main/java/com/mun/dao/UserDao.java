package com.mun.dao;

import com.mun.entity.UserEntity;

import java.util.List;

/**
 * Created by wanhui on 22/03/2017.
 */
public interface UserDao {
    /**
     * insert a user into database
     * @param user user
     * @return success or false
     */
    boolean addUser(UserEntity user);

    /**
     * delete a user from database
     * @param user user
     * @return success or false
     */
    boolean deleteUser(UserEntity user);

    /**
     * get all of the user from database
     * @return list of users
     */
    List<UserEntity> findAllUser();

    /**
     * get user by id
     * @param id id
     * @return the user or null
     */
    UserEntity getUserByID(Integer id);

    /**
     * get user by exact name
     * @param name name
     * @return the user or null
     */
    UserEntity getUserByFullName(String name);

    /**
     * get user by a part of name or full name
     * @param name name
     * @return the list of the user looking up or null
     */
    List<UserEntity> getUserListByName(String name);

    /**
     * update the corresponding user record
     * @param user user
     * @return success or false
     */
    boolean UpdateUser(UserEntity user);
}
