package com.example.academicsystem.dto;

import com.example.academicsystem.entity.UserRole;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
public class LoginRequest {
    @NotBlank
    private String username;
    @NotBlank
    private String password;
    @NotBlank
    private String captcha;
    @NotNull
    private UserRole role;
}
