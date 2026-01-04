package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.Course;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CourseMapper {
    void insert(Course course);

    List<Course> findAll();
}
