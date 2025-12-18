package com.novacloudedu.backend.interfaces.rest.dailylearning.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
@Schema(description = "用户每日单词响应")
public class UserDailyWordResponse {

    @Schema(description = "ID")
    private Long id;

    @Schema(description = "用户ID")
    private Long userId;

    @Schema(description = "单词ID")
    private Long wordId;

    @Schema(description = "是否学习")
    private Boolean studied;

    @Schema(description = "是否收藏")
    private Boolean collected;

    @Schema(description = "掌握程度")
    private Integer masteryLevel;

    @Schema(description = "掌握程度描述")
    private String masteryLevelDesc;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;

    @Schema(description = "单词详情")
    private DailyWordResponse word;
}
