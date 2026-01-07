package com.example.academicsystem.mapper;

import com.example.academicsystem.entity.TermPlan;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TermPlanMapper {
    void insert(TermPlan plan);

    List<TermPlan> listByTermAndMajor(@Param("term") String term, @Param("majorId") Long majorId);
}
