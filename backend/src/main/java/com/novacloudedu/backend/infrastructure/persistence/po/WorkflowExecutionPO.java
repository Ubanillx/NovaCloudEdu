package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 工作流执行记录持久化对象
 */
@Data
@TableName("workflow_execution")
public class WorkflowExecutionPO {

    @TableId(type = IdType.ASSIGN_UUID)
    private String id;

    private Long workflowId;

    private String workflowName;

    private Integer workflowVersion;

    private String status;

    @TableField(typeHandler = com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler.class)
    private String input;

    @TableField(typeHandler = com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler.class)
    private String output;

    @TableField(typeHandler = com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler.class)
    private String variables;

    @TableField(typeHandler = com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler.class)
    private String nodeExecutions;

    private String currentNodeId;

    private String errorMessage;

    private Long userId;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private Long durationMs;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer deleted;
}
