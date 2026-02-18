package com.novacloudedu.backend.interfaces.rest.grading.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "学科知识画像汇总")
public class SubjectProfileSummary {

    @Schema(description = "学科")
    private String subject;

    @Schema(description = "学科名称")
    private String subjectName;

    @Schema(description = "平均掌握度")
    private double avgMasteryLevel;

    @Schema(description = "总知识点数")
    private int totalPoints;

    @Schema(description = "薄弱知识点数")
    private int weakPointCount;

    @Schema(description = "优势知识点数（掌握度>=0.8）")
    private int strongPointCount;

    @Schema(description = "薄弱知识点列表")
    private List<KnowledgeProfileResponse> weakPoints;

    @Schema(description = "优势知识点列表")
    private List<KnowledgeProfileResponse> strongPoints;
}
