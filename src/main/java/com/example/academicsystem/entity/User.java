package com.example.academicsystem.entity;

import lombok.Data;

@Data
public class User {
    private Long id;
    private String username;
    private String password;
    private UserRole role;
    private String name;
    private String phone;
    private Boolean active;
    private Long studentId;
    private Long teacherId;
}
