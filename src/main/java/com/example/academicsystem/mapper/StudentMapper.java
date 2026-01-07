package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.Student;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StudentMapper {
    void insert(Student student);

    void update(Student student);

    void delete(@Param("id") Long id);

    List<Student> findAll();

    Student findById(@Param("id") Long id);
}
