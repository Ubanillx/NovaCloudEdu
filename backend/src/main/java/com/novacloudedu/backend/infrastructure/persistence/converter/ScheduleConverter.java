package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleItem;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleSetting;
import com.novacloudedu.backend.domain.schedule.valueobject.ScheduleCourseType;
import com.novacloudedu.backend.domain.schedule.valueobject.ScheduleWeekType;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassScheduleItemPO;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassScheduleSettingPO;
import org.springframework.stereotype.Component;

@Component
public class ScheduleConverter {
    
    private final ObjectMapper objectMapper = new ObjectMapper();

    public ClassScheduleSettingPO toSettingPO(ClassScheduleSetting setting) {
        if (setting == null) return null;
        ClassScheduleSettingPO po = new ClassScheduleSettingPO();
        po.setId(setting.getId());
        if (setting.getClassId() != null) {
            po.setClassId(setting.getClassId().getValue());
        }
        po.setSemester(setting.getSemester());
        po.setStartDate(setting.getStartDate());
        po.setTotalWeeks(setting.getTotalWeeks());
        po.setDaysPerWeek(setting.getDaysPerWeek());
        po.setSectionsPerDay(setting.getSectionsPerDay());
        po.setTimeConfig(setting.getTimeConfig());
        po.setIsActive(Boolean.TRUE.equals(setting.getIsActive()) ? 1 : 0);
        po.setCreateTime(setting.getCreateTime());
        po.setUpdateTime(setting.getUpdateTime());
        return po;
    }

    public ClassScheduleSetting toSetting(ClassScheduleSettingPO po) {
        if (po == null) return null;
        
        String timeConfigJson = "[]";
        try {
            if (po.getTimeConfig() != null) {
                timeConfigJson = objectMapper.writeValueAsString(po.getTimeConfig());
            }
        } catch (JsonProcessingException e) {
            // ignore
        }
        
        return ClassScheduleSetting.reconstruct(
                po.getId(),
                ClassId.of(po.getClassId()),
                po.getSemester(),
                po.getStartDate(),
                po.getTotalWeeks(),
                po.getDaysPerWeek(),
                po.getSectionsPerDay(),
                timeConfigJson,
                po.getIsActive() != null && po.getIsActive() == 1,
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    public ClassScheduleItemPO toItemPO(ClassScheduleItem item) {
        if (item == null) return null;
        ClassScheduleItemPO po = new ClassScheduleItemPO();
        po.setId(item.getId());
        po.setSettingId(item.getSettingId());
        if (item.getClassId() != null) {
            po.setClassId(item.getClassId().getValue());
        }
        if (item.getUserId() != null) {
            po.setUserId(item.getUserId().value());
        }
        if (item.getCourseType() != null) {
            po.setCourseType(item.getCourseType().getCode());
        }
        po.setCourseName(item.getCourseName());
        po.setTeacherName(item.getTeacherName());
        po.setLocation(item.getLocation());
        if (item.getCourseId() != null) {
            po.setCourseId(item.getCourseId().value());
        }
        if (item.getTeacherId() != null) {
            po.setTeacherId(item.getTeacherId().value());
        }
        po.setDayOfWeek(item.getDayOfWeek());
        po.setStartSection(item.getStartSection());
        po.setEndSection(item.getEndSection());
        po.setStartWeek(item.getStartWeek());
        po.setEndWeek(item.getEndWeek());
        if (item.getWeekType() != null) {
            po.setWeekType(item.getWeekType().getCode());
        }
        po.setColor(item.getColor());
        po.setRemark(item.getRemark());
        po.setCreateTime(item.getCreateTime());
        po.setUpdateTime(item.getUpdateTime());
        return po;
    }

    public ClassScheduleItem toItem(ClassScheduleItemPO po) {
        if (po == null) return null;
        return ClassScheduleItem.reconstruct(
                po.getId(),
                po.getSettingId(),
                po.getClassId() != null ? ClassId.of(po.getClassId()) : null,
                po.getUserId() != null ? UserId.of(po.getUserId()) : null,
                ScheduleCourseType.fromCode(po.getCourseType()),
                po.getCourseName(),
                po.getTeacherName(),
                po.getLocation(),
                po.getCourseId() != null ? CourseId.of(po.getCourseId()) : null,
                po.getTeacherId() != null ? TeacherId.of(po.getTeacherId()) : null,
                po.getDayOfWeek(),
                po.getStartSection(),
                po.getEndSection(),
                po.getStartWeek(),
                po.getEndWeek(),
                ScheduleWeekType.fromCode(po.getWeekType()),
                po.getColor(),
                po.getRemark(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
