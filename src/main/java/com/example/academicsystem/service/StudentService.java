package com.example.academicsystem.service;

import com.example.academicsystem.entity.GradeRecord;
import com.example.academicsystem.entity.StudentCourse;
import com.example.academicsystem.entity.Timetable;

import java.util.List;

public interface StudentService {
    void changePassword(String username, String oldPassword, String newPassword);

    List<GradeRecord> listGrades(Long studentId);

    Timetable getTimetable(Long studentId, String term);

    void selectCourse(Long studentId, Long courseId, String term);

    List<StudentCourse> listSelectedCourses(Long studentId);
}
