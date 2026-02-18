package com.novacloudedu.backend.interfaces.rest.grading.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "已发布试卷简要信息（供批改选择）")
public class PublishedExamPaperItem {

    @Schema(description = "试卷ID")
    private String id;

    @Schema(description = "标题")
    private String title;

    @Schema(description = "副标题")
    private String subtitle;

    @Schema(description = "学科代码")
    private String subject;

    @Schema(description = "学科名称")
    private String subjectName;

    @Schema(description = "年级")
    private String grade;

    @Schema(description = "总分")
    private Integer totalScore;

    @Schema(description = "考试时长(分钟)")
    private Integer durationMin;
}
