package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

/**
 * 工作流节点响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流节点响应")
public class WorkflowNodeResponse {

    @Schema(description = "节点ID", example = "node-1")
    private String id;

    @Schema(description = "节点类型", example = "LLM")
    private String type;

    @Schema(description = "节点类型描述", example = "大语言模型")
    private String typeDescription;

    @Schema(description = "节点名称", example = "GPT问答节点")
    private String name;

    @Schema(description = "节点位置")
    private PositionDTO position;

    @Schema(description = "节点配置参数")
    private Map<String, Object> config;

    @Schema(description = "错误处理配置")
    private ErrorHandlingConfigDTO errorHandling;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(description = "节点位置")
    public static class PositionDTO {
        @Schema(description = "X坐标", example = "100")
        private int x;

        @Schema(description = "Y坐标", example = "200")
        private int y;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(description = "错误处理配置")
    public static class ErrorHandlingConfigDTO {
        @Schema(description = "错误处理策略", example = "RETRY")
        private String onError;

        @Schema(description = "重试次数", example = "3")
        private int retryCount;

        @Schema(description = "重试延迟（毫秒）", example = "1000")
        private long retryDelayMs;

        @Schema(description = "回退节点ID", example = "fallback-node-1")
        private String fallbackNodeId;

        @Schema(description = "超时时间（毫秒）", example = "30000")
        private long timeoutMs;
    }
}
