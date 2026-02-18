package com.novacloudedu.backend.interfaces.rest.admin.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 仪表盘学情概览响应
 */
@Data
@Builder
public class DashboardLearningResponse {

    private List<Map<String, Object>> activityDistribution;
    private long totalDurationSec;
    private double avgHomeworkScoreRate;
    private List<Map<String, Object>> topActiveUsers;
    private List<Map<String, Object>> topActiveClasses;
    private List<Map<String, Object>> dailyActiveTrend;
}
