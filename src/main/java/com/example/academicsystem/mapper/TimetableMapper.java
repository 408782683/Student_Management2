package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.Timetable;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TimetableMapper {
    void insert(Timetable timetable);

    Timetable findOne(@Param("ownerType") String ownerType, @Param("ownerId") Long ownerId, @Param("term") String term);

    List<Timetable> findAll(@Param("ownerType") String ownerType, @Param("ownerId") Long ownerId, @Param("term") String term);
}
