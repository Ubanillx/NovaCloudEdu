package com.novacloudedu.backend.interfaces.rest.dailylearning.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
@Schema(description = "更新每日文章请求")
public class UpdateDailyArticleRequest {

    @NotBlank(message = "标题不能为空")
    @Schema(description = "文章标题")
    private String title;

    @NotBlank(message = "内容不能为空")
    @Schema(description = "文章内容")
    private String content;

    @Schema(description = "文章摘要")
    private String summary;

    @Schema(description = "封面图片URL")
    private String coverImage;

    @Schema(description = "作者")
    private String author;

    @Schema(description = "来源")
    private String source;

    @Schema(description = "原文链接")
    private String sourceUrl;

    @Schema(description = "文章分类")
    private String category;

    @Schema(description = "标签列表")
    private List<String> tags;

    @NotNull(message = "难度等级不能为空")
    @Schema(description = "难度等级：1-简单，2-中等，3-困难")
    private Integer difficulty;

    @Schema(description = "预计阅读时间(分钟)")
    private Integer readTime;

    @NotNull(message = "发布日期不能为空")
    @Schema(description = "发布日期")
    private LocalDate publishDate;
}
