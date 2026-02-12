package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * AI助手持久化对象
 */
@Data
@TableName("ai_assistant")
public class AiAssistantPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;
    private String description;
    private String avatarUrl;
    private String tags;
    private String category;

    private String systemPrompt;
    private String openingMessage;
    private String suggestedQuestions;

    private String modelName;
    private BigDecimal temperature;
    private BigDecimal topP;
    private Integer maxTokens;

    /** 绑定的MCP服务器ID列表，JSON数组格式 */
    private String mcpServerIds;

    private String status;
    private Integer version;
    private Integer publishedVersion;

    private Integer isPublic;
    private Integer usageCount;
    private BigDecimal rating;

    private Long creatorId;
    private Integer sort;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
