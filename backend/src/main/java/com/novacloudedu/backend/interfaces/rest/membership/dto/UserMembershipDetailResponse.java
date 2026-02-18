package com.novacloudedu.backend.interfaces.rest.membership.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "用户会员详情响应")
public class UserMembershipDetailResponse {

    @Schema(description = "会员ID")
    private Long id;

    @Schema(description = "用户ID")
    private Long userId;

    @Schema(description = "计划ID")
    private Long planId;

    @Schema(description = "订单号")
    private String orderNo;

    @Schema(description = "开始时间")
    private LocalDateTime startTime;

    @Schema(description = "过期时间")
    private LocalDateTime expireTime;

    @Schema(description = "会员状态")
    private String status;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;

    @Schema(description = "计划名称")
    private String planName;

    @Schema(description = "计划编码")
    private String planCode;

    @Schema(description = "计划描述")
    private String planDescription;

    @Schema(description = "计划价格")
    private BigDecimal planPrice;

    @Schema(description = "计划时长（天）")
    private Integer planDurationDays;

    @Schema(description = "AI聊天每日限额")
    private Integer aiChatDailyLimit;

    @Schema(description = "AI聊天每月限额")
    private Integer aiChatMonthlyLimit;

    @Schema(description = "AI PPT每日限额")
    private Integer aiPptDailyLimit;

    @Schema(description = "AI PPT每月限额")
    private Integer aiPptMonthlyLimit;

    @Schema(description = "AI组卷每日限额")
    private Integer aiExamDailyLimit;

    @Schema(description = "AI组卷每月限额")
    private Integer aiExamMonthlyLimit;

    @Schema(description = "AI电子书每日限额")
    private Integer aiBookDailyLimit;

    @Schema(description = "AI电子书每月限额")
    private Integer aiBookMonthlyLimit;

    @Schema(description = "AI智能批改每日限额")
    private Integer aiGradingDailyLimit;

    @Schema(description = "AI智能批改每月限额")
    private Integer aiGradingMonthlyLimit;

    @Schema(description = "是否有课程会员访问权限")
    private Boolean courseMemberAccess;

    @Schema(description = "AI聊天今日剩余")
    private Integer aiChatDailyRemaining;

    @Schema(description = "AI聊天本月剩余")
    private Integer aiChatMonthlyRemaining;

    @Schema(description = "AI PPT今日剩余")
    private Integer aiPptDailyRemaining;

    @Schema(description = "AI PPT本月剩余")
    private Integer aiPptMonthlyRemaining;

    @Schema(description = "AI组卷今日剩余")
    private Integer aiExamDailyRemaining;

    @Schema(description = "AI组卷本月剩余")
    private Integer aiExamMonthlyRemaining;

    @Schema(description = "AI电子书今日剩余")
    private Integer aiBookDailyRemaining;

    @Schema(description = "AI电子书本月剩余")
    private Integer aiBookMonthlyRemaining;

    @Schema(description = "AI智能批改今日剩余")
    private Integer aiGradingDailyRemaining;

    @Schema(description = "AI智能批改本月剩余")
    private Integer aiGradingMonthlyRemaining;
}
