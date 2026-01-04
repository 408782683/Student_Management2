package com.example.academicsystem.entity;

import lombok.Data;

@Data
public class TeachingAssignment {
    private Long id;
    private Long termPlanId;
    private Long teacherId;
    private String courseType;
    private String remarks;
}
