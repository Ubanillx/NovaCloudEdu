package com.novacloudedu.backend.interfaces.rest.grading.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Schema(description = "知识画像响应")
public class KnowledgeProfileResponse {

    @Schema(description = "知识点名称")
    private String knowledgePoint;

    @Schema(description = "学科")
    private String subject;

    @Schema(description = "掌握度 0.0~1.0")
    private double masteryLevel;

    @Schema(description = "掌握度等级: EXCELLENT/GOOD/MEDIUM/WEAK/VERY_WEAK")
    private String masteryGrade;

    @Schema(description = "总答题次数")
    private int totalAttempts;

    @Schema(description = "正确次数")
    private int correctCount;

    @Schema(description = "正确率")
    private double correctRate;

    @Schema(description = "近期错误类型")
    private List<String> recentErrorCategories;

    @Schema(description = "是否薄弱知识点")
    private boolean weakPoint;

    @Schema(description = "最近更新时间")
    private LocalDateTime lastUpdated;

    public static String toMasteryGrade(double level) {
        if (level >= 0.8) return "EXCELLENT";
        if (level >= 0.6) return "GOOD";
        if (level >= 0.4) return "MEDIUM";
        if (level >= 0.2) return "WEAK";
        return "VERY_WEAK";
    }
}
