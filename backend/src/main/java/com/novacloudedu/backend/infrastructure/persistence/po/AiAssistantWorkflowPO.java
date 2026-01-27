package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * AI助手工作流关联持久化对象
 */
@Data
@TableName("ai_assistant_workflow")
public class AiAssistantWorkflowPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long assistantId;

    private Long workflowId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
