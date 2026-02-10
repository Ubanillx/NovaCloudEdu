package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Map;

@Data
@Builder
@Schema(description = "工作流触发器响应")
public class WorkflowTriggerResponse {

    @Schema(description = "触发器ID")
    private Long id;

    @Schema(description = "工作流ID")
    private Long workflowId;

    @Schema(description = "触发器类型：SCHEDULE/WEBHOOK/EVENT")
    private String type;

    @Schema(description = "触发器名称")
    private String name;

    @Schema(description = "是否启用")
    private boolean enabled;

    @Schema(description = "配置JSON")
    private Map<String, Object> config;

    @Schema(description = "最后触发时间")
    private LocalDateTime lastTriggeredAt;

    @Schema(description = "触发次数")
    private int triggerCount;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;
}
