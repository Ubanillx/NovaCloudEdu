package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.CourseSectionPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CourseSectionMapper extends BaseMapper<CourseSectionPO> {

    @Select("SELECT COALESCE(SUM(duration), 0) FROM course_section WHERE course_id = #{courseId} AND is_delete = 0")
    int sumDurationByCourseId(@Param("courseId") Long courseId);
}
