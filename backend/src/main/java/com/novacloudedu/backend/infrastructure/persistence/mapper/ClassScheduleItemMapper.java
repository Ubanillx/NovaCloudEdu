package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassScheduleItemPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ClassScheduleItemMapper extends BaseMapper<ClassScheduleItemPO> {

    @Select("SELECT i.* FROM class_schedule_item i " +
            "INNER JOIN class_schedule_setting s ON i.setting_id = s.id " +
            "WHERE i.teacher_id = #{teacherId} AND s.is_active = 1 " +
            "AND i.is_delete = 0 AND s.is_delete = 0 " +
            "ORDER BY i.day_of_week, i.start_section")
    List<ClassScheduleItemPO> selectActiveByTeacherId(Long teacherId);
}
