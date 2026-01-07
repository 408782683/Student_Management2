package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.GradeRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface GradeMapper {
    void insert(GradeRecord record);

    List<GradeRecord> listByStudent(@Param("studentId") Long studentId);

    List<GradeRecord> listByTeacher(@Param("teacherId") Long teacherId, @Param("term") String term);

    List<GradeRecord> listByCourse(@Param("courseId") Long courseId, @Param("term") String term);
}
