package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 工作流响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流响应")
public class WorkflowResponse {

    @Schema(description = "工作流ID", example = "1")
    private Long id;

    @Schema(description = "工作流名称", example = "知识库问答工作流")
    private String name;

    @Schema(description = "工作流描述", example = "基于知识库的智能问答工作流")
    private String description;

    @Schema(description = "工作流定义JSON字符串")
    private String definition;

    @Schema(description = "工作流状态", example = "DRAFT", allowableValues = {"DRAFT", "PUBLISHED", "ARCHIVED"})
    private String status;

    @Schema(description = "版本号", example = "1")
    private int version;

    @Schema(description = "是否公开", example = "false")
    private boolean isPublic;

    @Schema(description = "创建者ID", example = "1")
    private Long creatorId;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
