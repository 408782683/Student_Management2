package com.example.academicsystem.service;

import com.example.academicsystem.dto.LoginRequest;
import com.example.academicsystem.entity.User;

public interface AuthService {
    String generateCaptcha(String key);

    User login(LoginRequest request);
}
