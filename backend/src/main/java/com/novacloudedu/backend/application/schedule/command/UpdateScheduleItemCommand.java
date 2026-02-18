package com.novacloudedu.backend.application.schedule.command;

/**
 * 更新课程表项命令
 */
public record UpdateScheduleItemCommand(
        Long itemId,
        String location,
        Integer dayOfWeek,
        Integer startSection,
        Integer endSection,
        Integer startWeek,
        Integer endWeek,
        Integer weekType,
        String color,
        String remark,
        String courseName,
        String teacherName
) {}
