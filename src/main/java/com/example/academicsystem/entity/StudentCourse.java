package com.example.academicsystem.entity;

import lombok.Data;

@Data
public class StudentCourse {
    private Long id;
    private Long studentId;
    private Long courseId;
    private String term;
}
