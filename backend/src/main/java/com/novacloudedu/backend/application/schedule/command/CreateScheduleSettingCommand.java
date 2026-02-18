package com.novacloudedu.backend.application.schedule.command;

import com.novacloudedu.backend.domain.schedule.valueobject.TimeConfigItem;

import java.time.LocalDate;
import java.util.List;

/**
 * 创建课程表设置命令
 */
public record CreateScheduleSettingCommand(
        Long classId,
        String semester,
        LocalDate startDate,
        Integer totalWeeks,
        Integer daysPerWeek,
        Integer sectionsPerDay,
        List<TimeConfigItem> timeConfig
) {}
