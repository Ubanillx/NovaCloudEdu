package com.novacloudedu.backend.interfaces.rest.dailylearning.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;

@Data
@Schema(description = "创建每日单词请求")
public class CreateDailyWordRequest {

    @NotBlank(message = "单词不能为空")
    @Schema(description = "单词")
    private String word;

    @Schema(description = "音标")
    private String pronunciation;

    @Schema(description = "发音音频URL")
    private String audioUrl;

    @NotBlank(message = "翻译不能为空")
    @Schema(description = "翻译")
    private String translation;

    @Schema(description = "例句")
    private String example;

    @Schema(description = "例句翻译")
    private String exampleTranslation;

    @NotNull(message = "难度等级不能为空")
    @Schema(description = "难度等级：1-简单，2-中等，3-困难")
    private Integer difficulty;

    @Schema(description = "单词分类")
    private String category;

    @Schema(description = "单词笔记")
    private String notes;

    @NotNull(message = "发布日期不能为空")
    @Schema(description = "发布日期")
    private LocalDate publishDate;
}
