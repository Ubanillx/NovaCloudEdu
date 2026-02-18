package com.novacloudedu.backend.interfaces.rest.analytics.dto.response;

import lombok.Data;

import java.util.Map;

/**
 * 班级学情概览响应
 */
@Data
public class ClassAnalyticsResponse {
    private int memberCount;
    private long totalDurationSec;
    private String totalDurationText;
    private long avgDurationSecPerMember;
    private String avgDurationText;
    private long totalActivities;
    private Map<String, Long> activityTypeCounts;
    private double avgScoreRate;
}
