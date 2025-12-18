package com.novacloudedu.backend.interfaces.rest.dailylearning.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
@Schema(description = "用户每日文章响应")
public class UserDailyArticleResponse {

    @Schema(description = "ID")
    private Long id;

    @Schema(description = "用户ID")
    private Long userId;

    @Schema(description = "文章ID")
    private Long articleId;

    @Schema(description = "是否阅读")
    private Boolean read;

    @Schema(description = "是否点赞")
    private Boolean liked;

    @Schema(description = "是否收藏")
    private Boolean collected;

    @Schema(description = "评论内容")
    private String commentContent;

    @Schema(description = "评论时间")
    private LocalDateTime commentTime;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;

    @Schema(description = "文章详情")
    private DailyArticleResponse article;
}
