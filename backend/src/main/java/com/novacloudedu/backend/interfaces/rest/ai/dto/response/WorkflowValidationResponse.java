package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 工作流验证响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流验证响应")
public class WorkflowValidationResponse {

    @Schema(description = "是否验证通过", example = "true")
    private boolean valid;

    @Schema(description = "错误列表")
    private List<ValidationErrorDTO> errors;

    @Schema(description = "警告列表")
    private List<ValidationWarningDTO> warnings;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(description = "验证错误")
    public static class ValidationErrorDTO {
        @Schema(description = "错误代码", example = "NO_START_NODE")
        private String code;

        @Schema(description = "错误消息", example = "工作流缺少开始节点")
        private String message;

        @Schema(description = "相关节点ID", example = "node-1")
        private String nodeId;

        @Schema(description = "相关连接线ID", example = "edge-1")
        private String edgeId;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(description = "验证警告")
    public static class ValidationWarningDTO {
        @Schema(description = "警告代码", example = "UNREACHABLE_NODE")
        private String code;

        @Schema(description = "警告消息", example = "节点node-3不可达")
        private String message;

        @Schema(description = "相关节点ID", example = "node-3")
        private String nodeId;
    }
}
