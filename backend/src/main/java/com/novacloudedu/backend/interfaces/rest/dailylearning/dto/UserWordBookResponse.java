package com.novacloudedu.backend.interfaces.rest.dailylearning.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
@Schema(description = "用户生词本响应")
public class UserWordBookResponse {

    @Schema(description = "ID")
    private Long id;

    @Schema(description = "用户ID")
    private Long userId;

    @Schema(description = "单词ID")
    private Long wordId;

    @Schema(description = "学习状态")
    private Integer learningStatus;

    @Schema(description = "学习状态描述")
    private String learningStatusDesc;

    @Schema(description = "收藏时间")
    private LocalDateTime collectedTime;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;

    @Schema(description = "单词详情")
    private DailyWordResponse word;
}
