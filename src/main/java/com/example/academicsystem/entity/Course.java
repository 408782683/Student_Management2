package com.example.academicsystem.entity;

import lombok.Data;

@Data
public class Course {
    private Long id;
    private String code;
    private String name;
    private Double credit;
    private String assessmentMethod;
    private String category;
    private String nature;
}
