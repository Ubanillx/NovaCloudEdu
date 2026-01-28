package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Map;

/**
 * 定时触发节点配置请求
 */
@Data
@Schema(description = "定时触发节点配置")
public class ScheduleNodeConfigRequest {

    @Schema(description = "调度类型", example = "CRON", 
            allowableValues = {"CRON", "INTERVAL", "FIXED_TIME"})
    private String scheduleType;

    @Schema(description = "Cron表达式（CRON类型）", example = "0 0 9 * * ?")
    private String cronExpression;

    @Schema(description = "间隔时间（秒）（INTERVAL类型）", example = "3600")
    private Long intervalSeconds;

    @Schema(description = "固定执行时间（FIXED_TIME类型）", example = "2024-01-01T09:00:00")
    private String fixedTime;

    @Schema(description = "时区", example = "Asia/Shanghai")
    private String timezone;

    @Schema(description = "是否启用", example = "true")
    private Boolean enabled;

    @Schema(description = "开始时间")
    private String startTime;

    @Schema(description = "结束时间")
    private String endTime;

    @Schema(description = "最大执行次数（0表示无限）", example = "0")
    private Integer maxExecutions;

    @Schema(description = "执行时传入的参数")
    private Map<String, Object> inputParameters;

    @Schema(description = "是否允许并发执行", example = "false")
    private Boolean allowConcurrent;

    @Schema(description = "错过执行的处理策略", example = "SKIP", 
            allowableValues = {"SKIP", "EXECUTE_ONCE", "EXECUTE_ALL"})
    private String misfireStrategy;
}
