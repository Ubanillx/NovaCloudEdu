package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@TableName(value = "recommendation_history")
@Data
public class RecommendationHistoryPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long userId;

    private String targetType;

    private Long targetId;

    private BigDecimal recommendationScore;

    private String recommendationReason;

    private Integer isClicked;

    private Integer isInteracted;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
