package com.novacloudedu.backend.interfaces.rest.recommendation.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "记录行为请求")
public class RecordBehaviorRequest {

    @NotBlank(message = "行为类型不能为空")
    @Schema(description = "行为类型：STUDY-学习，READ-阅读，COLLECT-收藏，LIKE-点赞，SEARCH-搜索")
    private String behaviorType;

    @NotBlank(message = "目标类型不能为空")
    @Schema(description = "目标类型：WORD-单词，ARTICLE-文章")
    private String targetType;

    @NotNull(message = "目标ID不能为空")
    @Schema(description = "目标ID")
    private Long targetId;

    @Schema(description = "行为数据（JSON格式）")
    private String behaviorData;

    @Schema(description = "持续时长（秒）")
    private Integer duration;
}
