package com.example.academicsystem.service;

import com.example.academicsystem.entity.*;

import java.util.List;

public interface AdminService {
    void saveOrUpdateStudent(Student student);

    void saveOrUpdateTeacher(Teacher teacher);

    void deleteStudent(Long id);

    void deleteTeacher(Long id);

    List<Student> listStudents();

    List<Teacher> listTeachers();

    void saveCollege(College college);

    void saveMajor(Major major);

    void saveClazz(Clazz clazz);

    List<College> listColleges();

    List<Major> listMajorsByCollege(Long collegeId);

    List<Clazz> listClazzByMajor(Long majorId);

    void saveCourse(Course course);

    List<Course> listCourses();

    void saveTermPlan(TermPlan plan);

    List<TermPlan> listPlans(String term, Long majorId);

    void saveAssignment(TeachingAssignment assignment);

    List<TeachingAssignment> listAssignments(String term);

    void saveTimetable(Timetable timetable);

    List<Timetable> listTimetables(String ownerType, Long ownerId, String term);
}
