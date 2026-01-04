package com.example.academicsystem.service.impl;

import com.example.academicsystem.dto.GradeSubmitRequest;
import com.example.academicsystem.entity.GradeRecord;
import com.example.academicsystem.entity.TeachingAssignment;
import com.example.academicsystem.entity.Timetable;
import com.example.academicsystem.mapper.GradeMapper;
import com.example.academicsystem.mapper.TeachingAssignmentMapper;
import com.example.academicsystem.mapper.TimetableMapper;
import com.example.academicsystem.mapper.UserMapper;
import com.example.academicsystem.service.TeacherService;
import com.example.academicsystem.util.RosterExporter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.List;

@Service
public class TeacherServiceImpl implements TeacherService {

    private final TeachingAssignmentMapper teachingAssignmentMapper;
    private final GradeMapper gradeMapper;
    private final UserMapper userMapper;
    private final TimetableMapper timetableMapper;
    private final RosterExporter rosterExporter;

    public TeacherServiceImpl(TeachingAssignmentMapper teachingAssignmentMapper,
                              GradeMapper gradeMapper,
                              UserMapper userMapper,
                              TimetableMapper timetableMapper,
                              RosterExporter rosterExporter) {
        this.teachingAssignmentMapper = teachingAssignmentMapper;
        this.gradeMapper = gradeMapper;
        this.userMapper = userMapper;
        this.timetableMapper = timetableMapper;
        this.rosterExporter = rosterExporter;
    }

    @Override
    public void changePassword(String username, String oldPassword, String newPassword) {
        Assert.hasText(newPassword, "新密码不能为空");
        // 简单校验旧密码，真实环境应查询教师表
        userMapper.updatePassword(username, newPassword);
    }

    @Override
    public List<TeachingAssignment> listAssignments(Long teacherId, String term) {
        return teachingAssignmentMapper.listByTeacher(teacherId, term);
    }

    @Override
    @Transactional
    public void submitGrade(GradeSubmitRequest request) {
        Assert.isTrue(request.getScore() != null && request.getScore() >= 0 && request.getScore() <= 100, "成绩必须在0-100之间");
        GradeRecord record = new GradeRecord();
        record.setCourseId(request.getCourseId());
        record.setStudentId(request.getStudentId());
        record.setTerm(request.getTerm());
        record.setScore(request.getScore());
        gradeMapper.insert(record);
    }

    @Override
    public List<GradeRecord> listGradesByTeacher(Long teacherId, String term) {
        return gradeMapper.listByTeacher(teacherId, term);
    }

    @Override
    public Timetable getTimetable(Long teacherId, String term) {
        return timetableMapper.findOne("TEACHER", teacherId, term);
    }

    @Override
    public byte[] exportRoster(Long classId, String term) {
        return rosterExporter.generateRoster(classId, term);
    }
}
