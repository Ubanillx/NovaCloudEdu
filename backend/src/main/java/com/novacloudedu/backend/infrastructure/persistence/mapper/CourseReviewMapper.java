package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.CourseReviewPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.math.BigDecimal;

@Mapper
public interface CourseReviewMapper extends BaseMapper<CourseReviewPO> {

    @Select("SELECT COALESCE(AVG(rating), 0) FROM course_review WHERE course_id = #{courseId} AND is_delete = 0")
    BigDecimal calculateAverageRating(@Param("courseId") Long courseId);
}
