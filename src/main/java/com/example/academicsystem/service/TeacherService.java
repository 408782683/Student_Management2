package com.example.academicsystem.service;

import com.example.academicsystem.dto.GradeSubmitRequest;
import com.example.academicsystem.entity.GradeRecord;
import com.example.academicsystem.entity.TeachingAssignment;
import com.example.academicsystem.entity.Timetable;

import java.util.List;

public interface TeacherService {
    void changePassword(String username, String oldPassword, String newPassword);

    List<TeachingAssignment> listAssignments(Long teacherId, String term);

    void submitGrade(GradeSubmitRequest request);

    List<GradeRecord> listGradesByTeacher(Long teacherId, String term);

    Timetable getTimetable(Long teacherId, String term);

    byte[] exportRoster(Long classId, String term);
}
