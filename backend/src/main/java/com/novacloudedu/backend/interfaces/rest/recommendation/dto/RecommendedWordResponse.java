package com.novacloudedu.backend.interfaces.rest.recommendation.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
@Schema(description = "推荐单词响应")
public class RecommendedWordResponse {

    @Schema(description = "ID")
    private Long id;

    @Schema(description = "单词")
    private String word;

    @Schema(description = "音标")
    private String pronunciation;

    @Schema(description = "发音音频URL")
    private String audioUrl;

    @Schema(description = "翻译")
    private String translation;

    @Schema(description = "例句")
    private String example;

    @Schema(description = "例句翻译")
    private String exampleTranslation;

    @Schema(description = "难度等级")
    private Integer difficulty;

    @Schema(description = "难度描述")
    private String difficultyDesc;

    @Schema(description = "单词分类")
    private String category;

    @Schema(description = "发布日期")
    private LocalDate publishDate;

    @Schema(description = "推荐原因")
    private String recommendReason;
}
