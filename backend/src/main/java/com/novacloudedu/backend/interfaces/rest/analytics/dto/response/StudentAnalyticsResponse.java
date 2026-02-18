package com.novacloudedu.backend.interfaces.rest.analytics.dto.response;

import lombok.Data;

import java.util.Map;

/**
 * 个人学情概览响应
 */
@Data
public class StudentAnalyticsResponse {
    private long totalDurationSec;
    private String totalDurationText;
    private long courseWatchCount;
    private long wordStudyCount;
    private long articleReadCount;
    private long homeworkSubmitCount;
    private long checkinCount;
    private int totalCheckinDays;
    private int currentStreak;
    private Map<String, Double> subjectMastery;
    private long weakPointCount;
    private long totalKnowledgePoints;
}
