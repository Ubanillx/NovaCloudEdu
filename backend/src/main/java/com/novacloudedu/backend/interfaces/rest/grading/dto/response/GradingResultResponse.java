package com.novacloudedu.backend.interfaces.rest.grading.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Schema(description = "批改结果响应")
public class GradingResultResponse {

    @Schema(description = "提交ID")
    private String submissionId;

    @Schema(description = "总得分")
    private Integer totalScore;

    @Schema(description = "满分")
    private Integer maxScore;

    @Schema(description = "总评语")
    private String overallComment;

    @Schema(description = "使用的AI模型")
    private String modelId;

    @Schema(description = "批改完成时间")
    private LocalDateTime gradingTime;

    @Schema(description = "逐题批改详情")
    private List<QuestionGradingItem> questions;

    @Data
    @Schema(description = "单题批改详情")
    public static class QuestionGradingItem {
        @Schema(description = "题号")
        private int questionIndex;

        @Schema(description = "题干")
        private String questionContent;

        @Schema(description = "题型")
        private String questionType;

        @Schema(description = "学生答案")
        private String studentAnswer;

        @Schema(description = "标准答案")
        private String standardAnswer;

        @Schema(description = "得分")
        private int score;

        @Schema(description = "满分")
        private int maxScore;

        @Schema(description = "错误分类")
        private List<String> errorCategories;

        @Schema(description = "错误详情")
        private String errorDetail;

        @Schema(description = "关联知识点")
        private List<String> knowledgePoints;

        @Schema(description = "评语")
        private String comment;
    }
}
