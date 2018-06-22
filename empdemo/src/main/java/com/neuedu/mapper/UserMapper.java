package com.neuedu.mapper;


import com.neuedu.entity.User;

public interface UserMapper {

    /**
     * 根据用户名查询用户
     * @param username
     * @return 用户对象
     */
    User getUserByUserName(String username);

}
