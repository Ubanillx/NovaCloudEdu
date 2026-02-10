package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 工作流执行统计响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流执行统计响应")
public class ExecutionStatisticsResponse {

    @Schema(description = "总执行次数", example = "100")
    private long totalCount;

    @Schema(description = "成功次数", example = "85")
    private long successCount;

    @Schema(description = "失败次数", example = "10")
    private long failedCount;

    @Schema(description = "取消次数", example = "5")
    private long cancelledCount;

    @Schema(description = "平均耗时（毫秒）", example = "1500.5")
    private double avgDurationMs;

    @Schema(description = "成功率（0~1）", example = "0.85")
    private double successRate;
}
