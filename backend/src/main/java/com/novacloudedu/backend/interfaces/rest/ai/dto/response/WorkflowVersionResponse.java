package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
@Schema(description = "工作流版本历史响应")
public class WorkflowVersionResponse {

    @Schema(description = "版本记录ID")
    private Long id;

    @Schema(description = "工作流ID")
    private Long workflowId;

    @Schema(description = "版本号")
    private int version;

    @Schema(description = "名称快照")
    private String name;

    @Schema(description = "描述快照")
    private String description;

    @Schema(description = "工作流定义快照JSON")
    private String definition;

    @Schema(description = "发布说明")
    private String publishNote;

    @Schema(description = "发布者ID")
    private Long publishedBy;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;
}
