package com.example.academicsystem.service.impl;

import com.example.academicsystem.dto.LoginRequest;
import com.example.academicsystem.entity.User;
import com.example.academicsystem.mapper.UserMapper;
import com.example.academicsystem.service.AuthService;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class AuthServiceImpl implements AuthService {

    private final UserMapper userMapper;
    private final Map<String, String> captchaCache = new ConcurrentHashMap<>();

    public AuthServiceImpl(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public String generateCaptcha(String key) {
        String captcha = RandomStringUtils.randomAlphanumeric(4).toUpperCase();
        captchaCache.put(key, captcha);
        return captcha;
    }

    @Override
    public User login(LoginRequest request) {
        String expected = captchaCache.get(request.getUsername());
        if (!StringUtils.hasText(expected) || !expected.equalsIgnoreCase(request.getCaptcha())) {
            throw new IllegalArgumentException("验证码错误或已过期");
        }
        User user = userMapper.findByUsernameAndRole(request.getUsername(), request.getRole().name());
        if (user == null || !request.getPassword().equals(user.getPassword())) {
            throw new IllegalArgumentException("用户名或密码错误");
        }
        return user;
    }
}
