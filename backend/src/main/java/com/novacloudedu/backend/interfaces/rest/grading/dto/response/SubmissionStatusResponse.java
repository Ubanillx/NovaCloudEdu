package com.novacloudedu.backend.interfaces.rest.grading.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Schema(description = "作业提交状态响应")
public class SubmissionStatusResponse {

    @Schema(description = "提交ID")
    private String submissionId;

    @Schema(description = "批改模式: EXAM_PAPER/GENERAL")
    private String gradingMode;

    @Schema(description = "作业标题")
    private String title;

    @Schema(description = "学科（可能为null，通用模式下AI推断后回填）")
    private String subject;

    @Schema(description = "年级")
    private String grade;

    @Schema(description = "作业图片URL列表")
    private List<String> imageUrls;

    @Schema(description = "批改状态: PENDING/OCR_PROCESSING/GRADING/COMPLETED/FAILED")
    private String status;

    @Schema(description = "关联试卷ID")
    private String examPaperId;

    @Schema(description = "总得分（已完成时有值）")
    private Integer totalScore;

    @Schema(description = "满分（已完成时有值）")
    private Integer maxScore;

    @Schema(description = "提交时间")
    private LocalDateTime createTime;
}
