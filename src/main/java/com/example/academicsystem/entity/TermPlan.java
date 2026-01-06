package com.example.academicsystem.entity;

import lombok.Data;

@Data
public class TermPlan {
    private Long id;
    private String term;
    private Long majorId;
    private Long courseId;
}
