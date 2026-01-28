package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 工作流执行日志响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流执行日志响应")
public class ExecutionLogResponse {

    @Schema(description = "执行ID", example = "exec-123456")
    private String executionId;

    @Schema(description = "节点ID", example = "node-1")
    private String nodeId;

    @Schema(description = "节点名称", example = "知识库检索")
    private String nodeName;

    @Schema(description = "节点类型", example = "KNOWLEDGE_RETRIEVAL",
            allowableValues = {"START", "END", "LLM", "KNOWLEDGE_RETRIEVAL", "CODE", "CONDITION", "LOOP", "HTTP", "VARIABLE"})
    private String nodeType;

    @Schema(description = "日志级别", example = "INFO", allowableValues = {"DEBUG", "INFO", "WARN", "ERROR"})
    private String level;

    @Schema(description = "日志消息", example = "成功检索到5条相关文档")
    private String message;

    @Schema(description = "节点执行耗时（毫秒）", example = "200")
    private long durationMs;

    @Schema(description = "日志时间戳")
    private LocalDateTime timestamp;
}
