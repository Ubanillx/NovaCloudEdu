package com.novacloudedu.backend.interfaces.rest.grading.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@Schema(description = "批改历史统计响应")
public class GradingStatsResponse {

    @Schema(description = "总批改次数")
    private long totalSubmissions;

    @Schema(description = "平均得分率（0.0~1.0）")
    private double avgScoreRate;

    @Schema(description = "最近10次得分趋势 [{submissionId, score, maxScore, subject, createTime}]")
    private List<ScoreTrendItem> scoreTrend;

    @Schema(description = "学科得分分布 {subject: avgScoreRate}")
    private Map<String, Double> subjectScoreRates;

    @Schema(description = "错因分布（Top 错误类型及次数）")
    private List<ErrorCategoryCount> errorDistribution;

    @Data
    @Schema(description = "得分趋势项")
    public static class ScoreTrendItem {
        private String submissionId;
        private int score;
        private int maxScore;
        private String subject;
        private String createTime;
    }

    @Data
    @Schema(description = "错因统计项")
    public static class ErrorCategoryCount {
        private String category;
        private String categoryName;
        private long count;
    }
}
