package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * 工作流执行结果响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流执行结果响应")
public class ExecutionResultResponse {

    @Schema(description = "执行ID", example = "exec-123456")
    private String executionId;

    @Schema(description = "工作流ID", example = "1")
    private Long workflowId;

    @Schema(description = "工作流名称", example = "知识库问答工作流")
    private String workflowName;

    @Schema(description = "执行状态", example = "COMPLETED", 
            allowableValues = {"PENDING", "RUNNING", "COMPLETED", "FAILED", "CANCELLED"})
    private String status;

    @Schema(description = "输入参数")
    private Map<String, Object> input;

    @Schema(description = "输出结果")
    private Map<String, Object> output;

    @Schema(description = "执行过程中的变量")
    private Map<String, Object> variables;

    @Schema(description = "当前执行节点ID", example = "node-1")
    private String currentNodeId;

    @Schema(description = "错误信息", example = "执行超时")
    private String errorMessage;

    @Schema(description = "开始时间")
    private LocalDateTime startTime;

    @Schema(description = "结束时间")
    private LocalDateTime endTime;

    @Schema(description = "执行耗时（毫秒）", example = "1500")
    private long durationMs;
}
