package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.Teacher;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TeacherMapper {
    void insert(Teacher teacher);

    void update(Teacher teacher);

    void delete(@Param("id") Long id);

    List<Teacher> findAll();

    Teacher findById(@Param("id") Long id);
}
