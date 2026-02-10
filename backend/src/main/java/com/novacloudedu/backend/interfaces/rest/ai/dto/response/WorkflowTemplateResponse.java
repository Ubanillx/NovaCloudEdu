package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@Schema(description = "工作流模板响应")
public class WorkflowTemplateResponse {

    @Schema(description = "模板ID")
    private Long id;

    @Schema(description = "模板名称")
    private String name;

    @Schema(description = "模板描述")
    private String description;

    @Schema(description = "分类")
    private String category;

    @Schema(description = "图标URL")
    private String icon;

    @Schema(description = "工作流定义JSON")
    private String definition;

    @Schema(description = "标签")
    private List<String> tags;

    @Schema(description = "是否系统预置")
    private boolean isSystem;

    @Schema(description = "是否公开")
    private boolean isPublic;

    @Schema(description = "创建者ID")
    private Long creatorId;

    @Schema(description = "使用次数")
    private int usageCount;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;
}
