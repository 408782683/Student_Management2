package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.StudentCourse;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StudentCourseMapper {
    void insert(StudentCourse record);

    StudentCourse find(@Param("studentId") Long studentId, @Param("courseId") Long courseId, @Param("term") String term);

    List<StudentCourse> listByStudent(@Param("studentId") Long studentId);
}
