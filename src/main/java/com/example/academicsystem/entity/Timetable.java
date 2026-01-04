package com.example.academicsystem.entity;

import lombok.Data;

@Data
public class Timetable {
    private Long id;
    private String ownerType; // STUDENT or TEACHER or MAJOR
    private Long ownerId;
    private String term;
    private String fileName;
    private String fileUrl;
}
