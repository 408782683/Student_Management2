package com.example.academicsystem.entity;

import lombok.Data;

import java.time.LocalDate;

@Data
public class Student {
    private Long id;
    private String studentNo;
    private String name;
    private String gender;
    private LocalDate birthday;
    private Long classId;
    private String photoUrl;
    private String phone;
    private String email;
    private LocalDate enrollmentDate;
}
