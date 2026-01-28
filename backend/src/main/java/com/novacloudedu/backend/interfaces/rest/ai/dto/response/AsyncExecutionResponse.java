package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 异步执行工作流响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "异步执行工作流响应")
public class AsyncExecutionResponse {

    @Schema(description = "执行ID，用于后续查询执行状态", example = "exec-123456")
    private String executionId;

    @Schema(description = "提示消息", example = "工作流已开始异步执行")
    private String message;
}
