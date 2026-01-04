package com.example.academicsystem.entity;

import lombok.Data;

@Data
public class GradeRecord {
    private Long id;
    private Long studentId;
    private Long courseId;
    private String term;
    private Double score;
}
