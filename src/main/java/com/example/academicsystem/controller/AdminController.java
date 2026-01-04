package com.example.academicsystem.controller;

import com.example.academicsystem.entity.*;
import com.example.academicsystem.service.AdminService;
import com.example.academicsystem.util.ApiResponse;
import com.example.academicsystem.util.FileStorageService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    private final AdminService adminService;
    private final FileStorageService fileStorageService;

    public AdminController(AdminService adminService, FileStorageService fileStorageService) {
        this.adminService = adminService;
        this.fileStorageService = fileStorageService;
    }

    @PostMapping("/student")
    public ApiResponse<Void> saveStudent(@RequestBody Student student) {
        adminService.saveOrUpdateStudent(student);
        return ApiResponse.success(null);
    }

    @DeleteMapping("/student/{id}")
    public ApiResponse<Void> deleteStudent(@PathVariable Long id) {
        adminService.deleteStudent(id);
        return ApiResponse.success(null);
    }

    @GetMapping("/students")
    public ApiResponse<List<Student>> listStudents() {
        return ApiResponse.success(adminService.listStudents());
    }

    @PostMapping("/teacher")
    public ApiResponse<Void> saveTeacher(@RequestBody Teacher teacher) {
        adminService.saveOrUpdateTeacher(teacher);
        return ApiResponse.success(null);
    }

    @DeleteMapping("/teacher/{id}")
    public ApiResponse<Void> deleteTeacher(@PathVariable Long id) {
        adminService.deleteTeacher(id);
        return ApiResponse.success(null);
    }

    @GetMapping("/teachers")
    public ApiResponse<List<Teacher>> listTeachers() {
        return ApiResponse.success(adminService.listTeachers());
    }

    @PostMapping("/college")
    public ApiResponse<Void> saveCollege(@RequestBody College college) {
        adminService.saveCollege(college);
        return ApiResponse.success(null);
    }

    @GetMapping("/colleges")
    public ApiResponse<List<College>> listColleges() {
        return ApiResponse.success(adminService.listColleges());
    }

    @PostMapping("/major")
    public ApiResponse<Void> saveMajor(@RequestBody Major major) {
        adminService.saveMajor(major);
        return ApiResponse.success(null);
    }

    @GetMapping("/majors")
    public ApiResponse<List<Major>> listMajors(@RequestParam Long collegeId) {
        return ApiResponse.success(adminService.listMajorsByCollege(collegeId));
    }

    @PostMapping("/clazz")
    public ApiResponse<Void> saveClazz(@RequestBody Clazz clazz) {
        adminService.saveClazz(clazz);
        return ApiResponse.success(null);
    }

    @GetMapping("/clazzes")
    public ApiResponse<List<Clazz>> listClazz(@RequestParam Long majorId) {
        return ApiResponse.success(adminService.listClazzByMajor(majorId));
    }

    @PostMapping("/course")
    public ApiResponse<Void> saveCourse(@RequestBody Course course) {
        adminService.saveCourse(course);
        return ApiResponse.success(null);
    }

    @GetMapping("/courses")
    public ApiResponse<List<Course>> listCourses() {
        return ApiResponse.success(adminService.listCourses());
    }

    @PostMapping("/plan")
    public ApiResponse<Void> savePlan(@RequestBody TermPlan plan) {
        adminService.saveTermPlan(plan);
        return ApiResponse.success(null);
    }

    @GetMapping("/plans")
    public ApiResponse<List<TermPlan>> listPlans(@RequestParam String term, @RequestParam Long majorId) {
        return ApiResponse.success(adminService.listPlans(term, majorId));
    }

    @PostMapping("/assignment")
    public ApiResponse<Void> saveAssignment(@RequestBody TeachingAssignment assignment) {
        adminService.saveAssignment(assignment);
        return ApiResponse.success(null);
    }

    @GetMapping("/assignments")
    public ApiResponse<List<TeachingAssignment>> listAssignments(@RequestParam String term) {
        return ApiResponse.success(adminService.listAssignments(term));
    }

    @PostMapping("/timetable")
    public ApiResponse<Timetable> uploadTimetable(@RequestParam String ownerType,
                                                  @RequestParam Long ownerId,
                                                  @RequestParam String term,
                                                  @RequestParam("file") MultipartFile file) {
        String path = fileStorageService.storeFile(file);
        Timetable timetable = new Timetable();
        timetable.setOwnerType(ownerType);
        timetable.setOwnerId(ownerId);
        timetable.setTerm(term);
        timetable.setFileName(file.getOriginalFilename());
        timetable.setFileUrl(path);
        adminService.saveTimetable(timetable);
        return ApiResponse.success("上传成功", timetable);
    }

    @GetMapping("/timetables")
    public ApiResponse<List<Timetable>> listTimetables(@RequestParam String ownerType,
                                                       @RequestParam(required = false) Long ownerId,
                                                       @RequestParam String term) {
        return ApiResponse.success(adminService.listTimetables(ownerType, ownerId, term));
    }
}
