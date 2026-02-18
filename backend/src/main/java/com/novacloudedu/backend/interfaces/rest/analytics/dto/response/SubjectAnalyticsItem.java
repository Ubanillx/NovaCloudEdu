package com.novacloudedu.backend.interfaces.rest.analytics.dto.response;

import lombok.Data;

/**
 * 学科分析项
 */
@Data
public class SubjectAnalyticsItem {
    private String subjectCode;
    private String subjectName;
    private double avgMasteryLevel;
    private long totalKnowledgePoints;
    private long weakPointCount;
    private long strongPointCount;
    private int totalAttempts;
    private double correctRate;
}
