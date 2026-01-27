package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * 工作流执行日志实体
 */
@Getter
public class WorkflowExecutionLog {
    
    private Long id;
    private WorkflowExecutionId executionId;
    private WorkflowId workflowId;
    private String workflowName;
    private String nodeId;
    private String nodeName;
    private NodeType nodeType;
    private LogLevel level;
    private String message;
    private Map<String, Object> input;
    private Map<String, Object> output;
    private String errorStack;
    private long durationMs;
    private String traceId;
    private UserId userId;
    private LocalDateTime timestamp;
    
    private WorkflowExecutionLog() {}
    
    public static WorkflowExecutionLog create(
            WorkflowExecutionId executionId,
            WorkflowId workflowId,
            String workflowName,
            String nodeId,
            String nodeName,
            NodeType nodeType,
            LogLevel level,
            String message,
            UserId userId) {
        WorkflowExecutionLog log = new WorkflowExecutionLog();
        log.executionId = executionId;
        log.workflowId = workflowId;
        log.workflowName = workflowName;
        log.nodeId = nodeId;
        log.nodeName = nodeName;
        log.nodeType = nodeType;
        log.level = level;
        log.message = message;
        log.userId = userId;
        log.timestamp = LocalDateTime.now();
        return log;
    }
    
    public WorkflowExecutionLog withInput(Map<String, Object> input) {
        this.input = input;
        return this;
    }
    
    public WorkflowExecutionLog withOutput(Map<String, Object> output) {
        this.output = output;
        return this;
    }
    
    public WorkflowExecutionLog withError(String errorStack) {
        this.errorStack = errorStack;
        return this;
    }
    
    public WorkflowExecutionLog withDuration(long durationMs) {
        this.durationMs = durationMs;
        return this;
    }
    
    public WorkflowExecutionLog withTraceId(String traceId) {
        this.traceId = traceId;
        return this;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
}
