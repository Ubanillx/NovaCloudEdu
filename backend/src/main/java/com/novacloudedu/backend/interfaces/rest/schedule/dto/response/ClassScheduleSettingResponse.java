package com.novacloudedu.backend.interfaces.rest.schedule.dto.response;

import com.novacloudedu.backend.domain.schedule.valueobject.TimeConfigItem;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class ClassScheduleSettingResponse {
    private String id;
    private String classId;
    private String semester;
    private LocalDate startDate;
    private Integer totalWeeks;
    private Integer daysPerWeek;
    private Integer sectionsPerDay;
    private List<TimeConfigItem> timeConfig;
    private Boolean isActive;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
