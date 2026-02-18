package com.novacloudedu.backend.application.schedule.command;

/**
 * 添加课程表项命令
 */
public record AddScheduleItemCommand(
        Long settingId,
        Integer courseType,
        String courseName,
        String teacherName,
        String location,
        Long courseId,
        Long teacherId,
        Integer dayOfWeek,
        Integer startSection,
        Integer endSection,
        Integer startWeek,
        Integer endWeek,
        Integer weekType,
        String color,
        String remark
) {}
