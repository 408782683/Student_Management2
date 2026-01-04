package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    User findByUsernameAndRole(@Param("username") String username, @Param("role") String role);

    void updatePassword(@Param("username") String username, @Param("password") String password);
}
