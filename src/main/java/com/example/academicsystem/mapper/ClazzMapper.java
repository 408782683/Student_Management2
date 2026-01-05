package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.Clazz;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ClazzMapper {
    void insert(Clazz clazz);

    List<Clazz> findByMajorId(@Param("majorId") Long majorId);
}
