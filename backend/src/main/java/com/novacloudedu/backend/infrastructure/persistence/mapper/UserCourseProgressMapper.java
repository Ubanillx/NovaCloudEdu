package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserCourseProgressPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserCourseProgressMapper extends BaseMapper<UserCourseProgressPO> {

    @Select("SELECT COUNT(*) FROM user_course_progress WHERE user_id = #{userId} AND course_id = #{courseId} AND is_completed = 1")
    long countCompletedSections(@Param("userId") Long userId, @Param("courseId") Long courseId);

    @Select("SELECT COUNT(*) FROM course_section WHERE course_id = #{courseId} AND is_delete = 0")
    long countTotalSections(@Param("courseId") Long courseId);

    @Select("SELECT COALESCE(AVG(progress), 0) FROM user_course_progress WHERE user_id = #{userId} AND course_id = #{courseId}")
    int calculateAvgProgress(@Param("userId") Long userId, @Param("courseId") Long courseId);
}
