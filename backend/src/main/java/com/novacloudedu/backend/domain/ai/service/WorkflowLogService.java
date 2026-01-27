package com.novacloudedu.backend.domain.ai.service;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecutionLog;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 工作流日志服务接口
 */
public interface WorkflowLogService {
    
    /**
     * 记录日志
     */
    void log(WorkflowExecutionId executionId, 
             WorkflowId workflowId,
             String workflowName,
             String nodeId,
             String nodeName,
             NodeType nodeType,
             LogLevel level,
             String message,
             UserId userId);
    
    /**
     * 记录节点开始
     */
    void logNodeStart(WorkflowExecutionId executionId,
                      WorkflowId workflowId,
                      String workflowName,
                      WorkflowNode node,
                      Map<String, Object> input,
                      UserId userId);
    
    /**
     * 记录节点完成
     */
    void logNodeComplete(WorkflowExecutionId executionId,
                         WorkflowId workflowId,
                         String workflowName,
                         WorkflowNode node,
                         Map<String, Object> output,
                         long durationMs,
                         UserId userId);
    
    /**
     * 记录节点失败
     */
    void logNodeError(WorkflowExecutionId executionId,
                      WorkflowId workflowId,
                      String workflowName,
                      WorkflowNode node,
                      String errorMessage,
                      String errorStack,
                      UserId userId);
    
    /**
     * 查询执行日志
     */
    List<WorkflowExecutionLog> findByExecutionId(WorkflowExecutionId executionId);
    
    /**
     * 查询工作流日志
     */
    List<WorkflowExecutionLog> findByWorkflowId(WorkflowId workflowId, 
                                                 LocalDateTime startTime, 
                                                 LocalDateTime endTime,
                                                 int page,
                                                 int size);
    
    /**
     * 按日志级别查询
     */
    List<WorkflowExecutionLog> findByLevel(WorkflowExecutionId executionId, LogLevel level);
}
