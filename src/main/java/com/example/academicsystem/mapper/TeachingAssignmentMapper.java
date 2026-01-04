package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.TeachingAssignment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TeachingAssignmentMapper {
    void insert(TeachingAssignment assignment);

    List<TeachingAssignment> listByTerm(@Param("term") String term);

    List<TeachingAssignment> listByTeacher(@Param("teacherId") Long teacherId, @Param("term") String term);
}
