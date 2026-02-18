package com.novacloudedu.backend.interfaces.rest.membership.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "修改计划AI配额请求")
public class UpdatePlanQuotaRequest {

    @Schema(description = "AI对话每日限额，-1表示无限制")
    private Integer aiChatDailyLimit;

    @Schema(description = "AI对话每月限额，-1表示无限制")
    private Integer aiChatMonthlyLimit;

    @Schema(description = "PPT生成每日限额，-1表示无限制")
    private Integer aiPptDailyLimit;

    @Schema(description = "PPT生成每月限额，-1表示无限制")
    private Integer aiPptMonthlyLimit;

    @Schema(description = "AI出题每日限额，-1表示无限制")
    private Integer aiExamDailyLimit;

    @Schema(description = "AI出题每月限额，-1表示无限制")
    private Integer aiExamMonthlyLimit;

    @Schema(description = "电子书AI每日限额，-1表示无限制")
    private Integer aiBookDailyLimit;

    @Schema(description = "电子书AI每月限额，-1表示无限制")
    private Integer aiBookMonthlyLimit;

    @Schema(description = "智能批改每日限额，-1表示无限制")
    private Integer aiGradingDailyLimit;

    @Schema(description = "智能批改每月限额，-1表示无限制")
    private Integer aiGradingMonthlyLimit;
}
