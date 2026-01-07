package com.example.academicsystem.controller;

import com.example.academicsystem.dto.GradeSubmitRequest;
import com.example.academicsystem.dto.PasswordChangeRequest;
import com.example.academicsystem.entity.GradeRecord;
import com.example.academicsystem.entity.TeachingAssignment;
import com.example.academicsystem.entity.Timetable;
import com.example.academicsystem.service.TeacherService;
import com.example.academicsystem.util.ApiResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;
import java.util.List;

@RestController
@RequestMapping("/api/teacher")
public class TeacherController {

    private final TeacherService teacherService;

    public TeacherController(TeacherService teacherService) {
        this.teacherService = teacherService;
    }

    @PostMapping("/password")
    public ApiResponse<Void> changePassword(@Validated @RequestBody PasswordChangeRequest request) {
        teacherService.changePassword(request.getUsername(), request.getOldPassword(), request.getNewPassword());
        return ApiResponse.success(null);
    }

    @GetMapping("/assignments")
    public ApiResponse<List<TeachingAssignment>> listAssignments(@RequestParam Long teacherId, @RequestParam String term) {
        return ApiResponse.success(teacherService.listAssignments(teacherId, term));
    }

    @PostMapping("/grade")
    public ApiResponse<Void> submitGrade(@Validated @RequestBody GradeSubmitRequest request) {
        teacherService.submitGrade(request);
        return ApiResponse.success(null);
    }

    @GetMapping("/grades")
    public ApiResponse<List<GradeRecord>> listGrades(@RequestParam Long courseId, @RequestParam String term) {
        return ApiResponse.success(teacherService.listGradesByCourse(courseId, term));
    }

    @GetMapping("/timetable")
    public ApiResponse<Timetable> downloadTimetable(@RequestParam Long teacherId, @RequestParam String term) {
        return ApiResponse.success(teacherService.getTimetable(teacherId, term));
    }

    @GetMapping("/roster/export")
    public ResponseEntity<byte[]> exportRoster(@RequestParam Long classId, @RequestParam String term) {
        byte[] data = teacherService.exportRoster(classId, term);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=roster_" + term + ".doc")
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(data);
    }
}
