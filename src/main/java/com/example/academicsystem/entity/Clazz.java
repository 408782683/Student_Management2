package com.example.academicsystem.entity;

import lombok.Data;

@Data
public class Clazz {
    private Long id;
    private String name;
    private Long majorId;
    private Integer grade;
    private String counselor;
}
