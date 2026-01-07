package com.example.academicsystem.dto;

import lombok.Data;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

@Data
public class GradeSubmitRequest {
    @NotNull
    private Long studentId;
    @NotNull
    private Long courseId;
    @NotNull
    private String term;
    @Min(0)
    @Max(100)
    private Double score;
}
