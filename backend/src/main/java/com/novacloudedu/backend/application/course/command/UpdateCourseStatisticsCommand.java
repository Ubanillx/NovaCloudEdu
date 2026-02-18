package com.novacloudedu.backend.application.course.command;

import java.math.BigDecimal;

/**
 * 更新课程统计命令
 */
public record UpdateCourseStatisticsCommand(
        Long courseId,
        Integer studentCount,
        Integer reviewCount,
        BigDecimal averageScore,
        Integer viewCount
) {}
