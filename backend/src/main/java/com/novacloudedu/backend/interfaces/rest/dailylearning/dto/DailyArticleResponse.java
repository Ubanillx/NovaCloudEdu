package com.novacloudedu.backend.interfaces.rest.dailylearning.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@Schema(description = "每日文章响应")
public class DailyArticleResponse {

    @Schema(description = "ID")
    private Long id;

    @Schema(description = "文章标题")
    private String title;

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

    @Schema(description = "难度等级")
    private Integer difficulty;

    @Schema(description = "难度描述")
    private String difficultyDesc;

    @Schema(description = "预计阅读时间(分钟)")
    private Integer readTime;

    @Schema(description = "发布日期")
    private LocalDate publishDate;

    @Schema(description = "查看次数")
    private Integer viewCount;

    @Schema(description = "点赞次数")
    private Integer likeCount;

    @Schema(description = "收藏次数")
    private Integer collectCount;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
