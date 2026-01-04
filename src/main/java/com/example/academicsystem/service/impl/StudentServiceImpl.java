package com.example.academicsystem.service.impl;

import com.example.academicsystem.entity.GradeRecord;
import com.example.academicsystem.entity.Timetable;
import com.example.academicsystem.mapper.GradeMapper;
import com.example.academicsystem.mapper.TimetableMapper;
import com.example.academicsystem.mapper.UserMapper;
import com.example.academicsystem.service.StudentService;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    private final GradeMapper gradeMapper;
    private final TimetableMapper timetableMapper;
    private final UserMapper userMapper;

    public StudentServiceImpl(GradeMapper gradeMapper, TimetableMapper timetableMapper, UserMapper userMapper) {
        this.gradeMapper = gradeMapper;
        this.timetableMapper = timetableMapper;
        this.userMapper = userMapper;
    }

    @Override
    public void changePassword(String username, String oldPassword, String newPassword) {
        Assert.hasText(newPassword, "新密码不能为空");
        userMapper.updatePassword(username, newPassword);
    }

    @Override
    public List<GradeRecord> listGrades(Long studentId) {
        return gradeMapper.listByStudent(studentId);
    }

    @Override
    public Timetable getTimetable(Long studentId, String term) {
        return timetableMapper.findOne("STUDENT", studentId, term);
    }
}
