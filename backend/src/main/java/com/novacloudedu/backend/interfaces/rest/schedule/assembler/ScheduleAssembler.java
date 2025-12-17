package com.novacloudedu.backend.interfaces.rest.schedule.assembler;

import com.novacloudedu.backend.application.schedule.query.GetClassScheduleQuery;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleItem;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleSetting;
import com.novacloudedu.backend.interfaces.rest.schedule.dto.response.ClassScheduleItemResponse;
import com.novacloudedu.backend.interfaces.rest.schedule.dto.response.ClassScheduleSettingResponse;
import com.novacloudedu.backend.interfaces.rest.schedule.dto.response.ScheduleResponse;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class ScheduleAssembler {

    public ClassScheduleSettingResponse toSettingResponse(ClassScheduleSetting setting) {
        if (setting == null) {
            return null;
        }
        ClassScheduleSettingResponse response = new ClassScheduleSettingResponse();
        response.setId(String.valueOf(setting.getId()));
        if (setting.getClassId() != null) {
            response.setClassId(String.valueOf(setting.getClassId().getValue()));
        }
        response.setSemester(setting.getSemester());
        response.setStartDate(setting.getStartDate());
        response.setTotalWeeks(setting.getTotalWeeks());
        response.setDaysPerWeek(setting.getDaysPerWeek());
        response.setSectionsPerDay(setting.getSectionsPerDay());
        response.setTimeConfig(setting.getTimeConfig());
        response.setIsActive(setting.getIsActive());
        response.setCreateTime(setting.getCreateTime());
        response.setUpdateTime(setting.getUpdateTime());
        return response;
    }

    public ClassScheduleItemResponse toItemResponse(ClassScheduleItem item) {
        if (item == null) {
            return null;
        }
        ClassScheduleItemResponse response = new ClassScheduleItemResponse();
        response.setId(String.valueOf(item.getId()));
        response.setSettingId(String.valueOf(item.getSettingId()));
        if (item.getClassId() != null) {
            response.setClassId(String.valueOf(item.getClassId().getValue()));
        }
        if (item.getUserId() != null) {
            response.setUserId(String.valueOf(item.getUserId().value()));
        }
        if (item.getCourseType() != null) {
            response.setCourseType(item.getCourseType().getCode());
            response.setCourseTypeDesc(item.getCourseType().getDescription());
        }
        response.setCourseName(item.getCourseName());
        response.setTeacherName(item.getTeacherName());
        response.setLocation(item.getLocation());
        
        if (item.getCourseId() != null) {
            response.setCourseId(String.valueOf(item.getCourseId().value()));
        }
        if (item.getTeacherId() != null) {
            response.setTeacherId(String.valueOf(item.getTeacherId().value()));
        }
        
        response.setDayOfWeek(item.getDayOfWeek());
        response.setStartSection(item.getStartSection());
        response.setEndSection(item.getEndSection());
        response.setStartWeek(item.getStartWeek());
        response.setEndWeek(item.getEndWeek());
        
        if (item.getWeekType() != null) {
            response.setWeekType(item.getWeekType().getCode());
            response.setWeekTypeDesc(item.getWeekType().getDescription());
        }
        
        response.setColor(item.getColor());
        response.setRemark(item.getRemark());
        response.setCreateTime(item.getCreateTime());
        response.setUpdateTime(item.getUpdateTime());
        return response;
    }

    public List<ClassScheduleItemResponse> toItemResponses(List<ClassScheduleItem> items) {
        if (items == null) {
            return Collections.emptyList();
        }
        return items.stream()
                .map(this::toItemResponse)
                .collect(Collectors.toList());
    }

    public ScheduleResponse toScheduleResponse(GetClassScheduleQuery.ScheduleDTO dto) {
        if (dto == null) {
            return null;
        }
        return new ScheduleResponse(
                toSettingResponse(dto.getSetting()),
                toItemResponses(dto.getItems())
        );
    }
}
