package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * AI助手与知识库关联持久化对象
 */
@Data
@TableName("ai_assistant_knowledge")
public class AiAssistantKnowledgePO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long assistantId;
    private Long knowledgeBaseId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
}
