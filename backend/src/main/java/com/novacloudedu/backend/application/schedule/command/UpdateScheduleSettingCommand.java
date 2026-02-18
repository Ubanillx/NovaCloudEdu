package com.novacloudedu.backend.application.schedule.command;

import com.novacloudedu.backend.domain.schedule.valueobject.TimeConfigItem;

import java.time.LocalDate;
import java.util.List;

/**
 * 更新课程表设置命令
 */
public record UpdateScheduleSettingCommand(
        Long settingId,
        String semester,
        LocalDate startDate,
        Integer totalWeeks,
        Integer daysPerWeek,
        Integer sectionsPerDay,
        List<TimeConfigItem> timeConfig
) {}
