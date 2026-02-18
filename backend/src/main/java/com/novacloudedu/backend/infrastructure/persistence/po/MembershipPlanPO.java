package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@TableName(value = "membership_plan")
@Data
public class MembershipPlanPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String name;

    private String code;

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

    private Integer aiGradingDailyLimit;

    private Integer aiGradingMonthlyLimit;

    private Integer courseMemberAccess;

    private Integer isDefault;

    private Integer sortOrder;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
