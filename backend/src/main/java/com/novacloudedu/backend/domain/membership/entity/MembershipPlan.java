package com.novacloudedu.backend.domain.membership.entity;

import com.novacloudedu.backend.domain.membership.valueobject.AiFeatureType;
import com.novacloudedu.backend.domain.membership.valueobject.PlanCode;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 会员计划聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MembershipPlan {

    private Long id;
    private String name;
    private PlanCode code;
    private String description;
    private BigDecimal price;
    private Integer durationDays;
    private Integer aiChatDailyLimit;
    private Integer aiChatMonthlyLimit;
    private Integer aiPptDailyLimit;
    private Integer aiPptMonthlyLimit;
    private Integer aiExamDailyLimit;
    private Integer aiExamMonthlyLimit;
    private Integer aiBookDailyLimit;
    private Integer aiBookMonthlyLimit;
    private boolean courseMemberAccess;
    private boolean isDefault;
    private Integer sortOrder;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private boolean isDelete;

    public static MembershipPlan create(String name, PlanCode code, String description,
                                        BigDecimal price, Integer durationDays) {
        MembershipPlan plan = new MembershipPlan();
        plan.name = name;
        plan.code = code;
        plan.description = description;
        plan.price = price != null ? price : BigDecimal.ZERO;
        plan.durationDays = durationDays != null ? durationDays : 30;
        plan.aiChatDailyLimit = -1;
        plan.aiChatMonthlyLimit = -1;
        plan.aiPptDailyLimit = -1;
        plan.aiPptMonthlyLimit = -1;
        plan.aiExamDailyLimit = -1;
        plan.aiExamMonthlyLimit = -1;
        plan.aiBookDailyLimit = -1;
        plan.aiBookMonthlyLimit = -1;
        plan.courseMemberAccess = false;
        plan.isDefault = false;
        plan.sortOrder = 0;
        plan.isDelete = false;
        plan.createTime = LocalDateTime.now();
        plan.updateTime = LocalDateTime.now();
        return plan;
    }

    public static MembershipPlan reconstruct(Long id, String name, PlanCode code, String description,
                                              BigDecimal price, Integer durationDays,
                                              Integer aiChatDailyLimit, Integer aiChatMonthlyLimit,
                                              Integer aiPptDailyLimit, Integer aiPptMonthlyLimit,
                                              Integer aiExamDailyLimit, Integer aiExamMonthlyLimit,
                                              Integer aiBookDailyLimit, Integer aiBookMonthlyLimit,
                                              boolean courseMemberAccess, boolean isDefault,
                                              Integer sortOrder,
                                              LocalDateTime createTime, LocalDateTime updateTime,
                                              boolean isDelete) {
        MembershipPlan plan = new MembershipPlan();
        plan.id = id;
        plan.name = name;
        plan.code = code;
        plan.description = description;
        plan.price = price;
        plan.durationDays = durationDays;
        plan.aiChatDailyLimit = aiChatDailyLimit;
        plan.aiChatMonthlyLimit = aiChatMonthlyLimit;
        plan.aiPptDailyLimit = aiPptDailyLimit;
        plan.aiPptMonthlyLimit = aiPptMonthlyLimit;
        plan.aiExamDailyLimit = aiExamDailyLimit;
        plan.aiExamMonthlyLimit = aiExamMonthlyLimit;
        plan.aiBookDailyLimit = aiBookDailyLimit;
        plan.aiBookMonthlyLimit = aiBookMonthlyLimit;
        plan.courseMemberAccess = courseMemberAccess;
        plan.isDefault = isDefault;
        plan.sortOrder = sortOrder;
        plan.createTime = createTime;
        plan.updateTime = updateTime;
        plan.isDelete = isDelete;
        return plan;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("计划ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void updateBasicInfo(String name, String description, BigDecimal price, Integer durationDays) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.durationDays = durationDays;
        this.updateTime = LocalDateTime.now();
    }

    public void updateQuota(Integer aiChatDailyLimit, Integer aiChatMonthlyLimit,
                            Integer aiPptDailyLimit, Integer aiPptMonthlyLimit,
                            Integer aiExamDailyLimit, Integer aiExamMonthlyLimit,
                            Integer aiBookDailyLimit, Integer aiBookMonthlyLimit) {
        this.aiChatDailyLimit = aiChatDailyLimit;
        this.aiChatMonthlyLimit = aiChatMonthlyLimit;
        this.aiPptDailyLimit = aiPptDailyLimit;
        this.aiPptMonthlyLimit = aiPptMonthlyLimit;
        this.aiExamDailyLimit = aiExamDailyLimit;
        this.aiExamMonthlyLimit = aiExamMonthlyLimit;
        this.aiBookDailyLimit = aiBookDailyLimit;
        this.aiBookMonthlyLimit = aiBookMonthlyLimit;
        this.updateTime = LocalDateTime.now();
    }

    public void updateCourseMemberAccess(boolean courseMemberAccess) {
        this.courseMemberAccess = courseMemberAccess;
        this.updateTime = LocalDateTime.now();
    }

    public void markAsDefault() {
        this.isDefault = true;
        this.updateTime = LocalDateTime.now();
    }

    public void unmarkDefault() {
        this.isDefault = false;
        this.updateTime = LocalDateTime.now();
    }

    public void delete() {
        this.isDelete = true;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 获取指定AI功能的每日限额
     */
    public int getDailyLimit(AiFeatureType featureType) {
        return switch (featureType) {
            case AI_CHAT -> aiChatDailyLimit;
            case AI_PPT -> aiPptDailyLimit;
            case AI_EXAM -> aiExamDailyLimit;
            case AI_BOOK -> aiBookDailyLimit;
        };
    }

    /**
     * 获取指定AI功能的每月限额
     */
    public int getMonthlyLimit(AiFeatureType featureType) {
        return switch (featureType) {
            case AI_CHAT -> aiChatMonthlyLimit;
            case AI_PPT -> aiPptMonthlyLimit;
            case AI_EXAM -> aiExamMonthlyLimit;
            case AI_BOOK -> aiBookMonthlyLimit;
        };
    }
}
