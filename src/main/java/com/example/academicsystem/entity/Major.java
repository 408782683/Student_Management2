package com.example.academicsystem.entity;

import lombok.Data;

@Data
public class Major {
    private Long id;
    private String name;
    private String code;
    private Long collegeId;
    private String description;
}
