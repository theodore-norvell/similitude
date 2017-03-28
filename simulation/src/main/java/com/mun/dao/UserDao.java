package com.mun.dao;

import com.mun.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by wanhui on 23/03/2017.
 */
public interface UserDao extends JpaRepository<UserEntity, Integer> {
    /**
     * find user by name
     * @param name name
     * @return The user or null
     */
    UserEntity findByName(String name);

    /**
     * find user by id
     * @param id id
     * @return The user or null
     */
    UserEntity findById(int id);

}
