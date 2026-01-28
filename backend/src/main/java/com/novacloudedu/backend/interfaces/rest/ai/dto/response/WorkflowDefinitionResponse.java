package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

/**
 * 工作流定义详情响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流定义详情响应")
public class WorkflowDefinitionResponse {

    @Schema(description = "工作流ID", example = "1")
    private Long workflowId;

    @Schema(description = "工作流名称", example = "知识库问答工作流")
    private String workflowName;

    @Schema(description = "定义版本", example = "1.0")
    private String version;

    @Schema(description = "节点列表")
    private List<WorkflowNodeResponse> nodes;

    @Schema(description = "连接线列表")
    private List<WorkflowEdgeResponse> edges;

    @Schema(description = "变量定义")
    private Map<String, WorkflowVariableResponse> variables;

    @Schema(description = "工作流设置")
    private WorkflowSettingsDTO settings;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(description = "工作流设置")
    public static class WorkflowSettingsDTO {
        @Schema(description = "最大执行时间（毫秒）", example = "60000")
        private long maxExecutionTimeMs;

        @Schema(description = "是否启用日志", example = "true")
        private boolean enableLogging;

        @Schema(description = "日志级别", example = "INFO")
        private String logLevel;

        @Schema(description = "是否启用调试模式", example = "false")
        private boolean enableDebug;
    }
}
