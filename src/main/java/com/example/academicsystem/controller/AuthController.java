package com.example.academicsystem.controller;

import com.example.academicsystem.dto.LoginRequest;
import com.example.academicsystem.entity.User;
import com.example.academicsystem.service.AuthService;
import com.example.academicsystem.util.ApiResponse;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/captcha")
    public ApiResponse<String> captcha(@RequestParam String key) {
        return ApiResponse.success(authService.generateCaptcha(key));
    }

    @PostMapping("/login")
    public ApiResponse<User> login(@Validated @RequestBody LoginRequest request) {
        return ApiResponse.success(authService.login(request));
    }
}
