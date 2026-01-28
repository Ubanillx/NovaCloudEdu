package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.Map;

/**
 * 添加工作流节点请求
 */
@Data
@Schema(description = "添加工作流节点请求")
public class AddNodeRequest {

    @NotBlank(message = "节点ID不能为空")
    @Schema(description = "节点唯一标识", requiredMode = Schema.RequiredMode.REQUIRED, example = "node-1")
    private String nodeId;

    @NotNull(message = "节点类型不能为空")
    @Schema(description = "节点类型", requiredMode = Schema.RequiredMode.REQUIRED, example = "LLM")
    private NodeType type;

    @NotBlank(message = "节点名称不能为空")
    @Schema(description = "节点名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "GPT问答节点")
    private String name;

    @Schema(description = "节点位置X坐标", example = "100")
    private int positionX;

    @Schema(description = "节点位置Y坐标", example = "200")
    private int positionY;

    @Schema(description = "节点配置参数")
    private Map<String, Object> config;

    @Schema(description = "错误处理配置")
    private ErrorHandlingConfigDTO errorHandling;

    @Data
    @Schema(description = "错误处理配置")
    public static class ErrorHandlingConfigDTO {
        @Schema(description = "错误处理策略", example = "RETRY", allowableValues = {"STOP", "RETRY", "SKIP", "FALLBACK"})
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
