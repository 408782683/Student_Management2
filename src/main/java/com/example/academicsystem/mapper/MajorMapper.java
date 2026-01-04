package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.Major;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MajorMapper {
    void insert(Major major);

    List<Major> findByCollegeId(@Param("collegeId") Long collegeId);
}
