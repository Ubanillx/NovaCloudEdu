package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 工作流执行日志持久化对象
 */
@Data
@TableName("ai_workflow_execution_log")
public class WorkflowExecutionLogPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String executionId;

    private Long workflowId;

    private String workflowName;

    private String nodeId;

    private String nodeName;

    private String nodeType;

    private String level;

    private String message;

    private String input;

    private String output;

    private String errorStack;

    private Long durationMs;

    private String traceId;

    private Long userId;

    private LocalDateTime timestamp;
}
