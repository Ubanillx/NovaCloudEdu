package com.novacloudedu.backend.interfaces.rest.analytics.dto.response;

import lombok.Data;

import java.util.List;

/**
 * 学习趋势响应
 */
@Data
public class LearningTrendResponse {
    private String granularity;
    private List<TrendItem> items;

    @Data
    public static class TrendItem {
        private String period;
        private long activityCount;
        private long totalDurationSec;
        private String durationText;
    }
}
