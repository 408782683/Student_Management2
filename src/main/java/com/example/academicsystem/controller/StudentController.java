package com.example.academicsystem.controller;

import com.example.academicsystem.dto.PasswordChangeRequest;
import com.example.academicsystem.entity.GradeRecord;
import com.example.academicsystem.entity.Timetable;
import com.example.academicsystem.service.StudentService;
import com.example.academicsystem.util.ApiResponse;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/student")
public class StudentController {

    private final StudentService studentService;

    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    @PostMapping("/password")
    public ApiResponse<Void> changePassword(@Validated @RequestBody PasswordChangeRequest request) {
        studentService.changePassword(request.getUsername(), request.getOldPassword(), request.getNewPassword());
        return ApiResponse.success(null);
    }

    @GetMapping("/grades")
    public ApiResponse<List<GradeRecord>> listGrades(@RequestParam Long studentId) {
        return ApiResponse.success(studentService.listGrades(studentId));
    }

    @GetMapping("/timetable")
    public ApiResponse<Timetable> downloadTimetable(@RequestParam Long studentId, @RequestParam String term) {
        return ApiResponse.success(studentService.getTimetable(studentId, term));
    }
}
