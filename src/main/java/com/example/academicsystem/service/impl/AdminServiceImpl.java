package com.example.academicsystem.service.impl;

import com.example.academicsystem.entity.*;
import com.example.academicsystem.mapper.*;
import com.example.academicsystem.service.AdminService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    private final StudentMapper studentMapper;
    private final TeacherMapper teacherMapper;
    private final CollegeMapper collegeMapper;
    private final MajorMapper majorMapper;
    private final ClazzMapper clazzMapper;
    private final CourseMapper courseMapper;
    private final TermPlanMapper termPlanMapper;
    private final TeachingAssignmentMapper teachingAssignmentMapper;
    private final TimetableMapper timetableMapper;

    public AdminServiceImpl(StudentMapper studentMapper,
                            TeacherMapper teacherMapper,
                            CollegeMapper collegeMapper,
                            MajorMapper majorMapper,
                            ClazzMapper clazzMapper,
                            CourseMapper courseMapper,
                            TermPlanMapper termPlanMapper,
                            TeachingAssignmentMapper teachingAssignmentMapper,
                            TimetableMapper timetableMapper) {
        this.studentMapper = studentMapper;
        this.teacherMapper = teacherMapper;
        this.collegeMapper = collegeMapper;
        this.majorMapper = majorMapper;
        this.clazzMapper = clazzMapper;
        this.courseMapper = courseMapper;
        this.termPlanMapper = termPlanMapper;
        this.teachingAssignmentMapper = teachingAssignmentMapper;
        this.timetableMapper = timetableMapper;
    }

    @Override
    @Transactional
    public void saveOrUpdateStudent(Student student) {
        if (student.getId() == null) {
            studentMapper.insert(student);
        } else {
            studentMapper.update(student);
        }
    }

    @Override
    @Transactional
    public void saveOrUpdateTeacher(Teacher teacher) {
        if (teacher.getId() == null) {
            teacherMapper.insert(teacher);
        } else {
            teacherMapper.update(teacher);
        }
    }

    @Override
    public void deleteStudent(Long id) {
        studentMapper.delete(id);
    }

    @Override
    public void deleteTeacher(Long id) {
        teacherMapper.delete(id);
    }

    @Override
    public List<Student> listStudents() {
        return studentMapper.findAll();
    }

    @Override
    public List<Teacher> listTeachers() {
        return teacherMapper.findAll();
    }

    @Override
    public void saveCollege(College college) {
        collegeMapper.insert(college);
    }

    @Override
    public void saveMajor(Major major) {
        majorMapper.insert(major);
    }

    @Override
    public void saveClazz(Clazz clazz) {
        clazzMapper.insert(clazz);
    }

    @Override
    public List<College> listColleges() {
        return collegeMapper.findAll();
    }

    @Override
    public List<Major> listMajorsByCollege(Long collegeId) {
        return majorMapper.findByCollegeId(collegeId);
    }

    @Override
    public List<Clazz> listClazzByMajor(Long majorId) {
        return clazzMapper.findByMajorId(majorId);
    }

    @Override
    public void saveCourse(Course course) {
        courseMapper.insert(course);
    }

    @Override
    public List<Course> listCourses() {
        return courseMapper.findAll();
    }

    @Override
    public void saveTermPlan(TermPlan plan) {
        termPlanMapper.insert(plan);
    }

    @Override
    public List<TermPlan> listPlans(String term, Long majorId) {
        return termPlanMapper.listByTermAndMajor(term, majorId);
    }

    @Override
    public void saveAssignment(TeachingAssignment assignment) {
        teachingAssignmentMapper.insert(assignment);
    }

    @Override
    public List<TeachingAssignment> listAssignments(String term) {
        return teachingAssignmentMapper.listByTerm(term);
    }

    @Override
    public void saveTimetable(Timetable timetable) {
        timetableMapper.insert(timetable);
    }

    @Override
    public List<Timetable> listTimetables(String ownerType, Long ownerId, String term) {
        return timetableMapper.findAll(ownerType, ownerId, term);
    }
}
