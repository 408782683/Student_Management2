package com.example.academicsystem.entity;

import lombok.Data;

import java.time.LocalDate;

@Data
public class Teacher {
    private Long id;
    private String teacherNo;
    private String name;
    private String title;
    private LocalDate hiredDate;
    private Long collegeId;
    private String photoUrl;
    private String phone;
    private String email;
}
