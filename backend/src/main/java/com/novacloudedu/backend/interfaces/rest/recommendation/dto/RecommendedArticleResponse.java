package com.novacloudedu.backend.interfaces.rest.recommendation.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
@Builder
@Schema(description = "推荐文章响应")
public class RecommendedArticleResponse {

    @Schema(description = "ID")
    private Long id;

    @Schema(description = "文章标题")
    private String title;

    @Schema(description = "文章摘要")
    private String summary;

    @Schema(description = "封面图片URL")
    private String coverImage;

    @Schema(description = "作者")
    private String author;

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

    @Schema(description = "推荐原因")
    private String recommendReason;
}
