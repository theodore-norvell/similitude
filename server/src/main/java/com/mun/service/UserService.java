package com.mun.service;

/**
 * Created by wanhui on 23/03/2017.
 */
public interface UserService {

    /**
     * verify login
     * @param name  the user name
     * @param password the password
     * @return success or fail
     */
    boolean login(String name, String password);

}
