package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 更新工作流设置请求
 */
@Data
@Schema(description = "更新工作流设置请求")
public class UpdateWorkflowSettingsRequest {

    @Schema(description = "最大执行时间（毫秒）", example = "120000")
    private Long maxExecutionTimeMs;

    @Schema(description = "是否启用日志", example = "true")
    private Boolean enableLogging;

    @Schema(description = "日志级别", example = "DEBUG", allowableValues = {"DEBUG", "INFO", "WARN", "ERROR"})
    private String logLevel;

    @Schema(description = "是否启用调试模式", example = "true")
    private Boolean enableDebug;
}
