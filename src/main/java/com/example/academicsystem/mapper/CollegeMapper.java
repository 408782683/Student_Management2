package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.College;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CollegeMapper {
    void insert(College college);

    List<College> findAll();
}
