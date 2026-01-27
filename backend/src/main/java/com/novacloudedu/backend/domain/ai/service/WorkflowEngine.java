package com.novacloudedu.backend.domain.ai.service;

import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecutionLog;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.Map;

/**
 * 工作流执行引擎接口
 */
public interface WorkflowEngine {
    
    /**
     * 执行工作流
     */
    WorkflowExecution execute(Workflow workflow, Map<String, Object> input, UserId userId);
    
    /**
     * 异步执行工作流
     */
    WorkflowExecutionId executeAsync(Workflow workflow, Map<String, Object> input, UserId userId);
    
    /**
     * 暂停执行
     */
    void pause(WorkflowExecutionId executionId);
    
    /**
     * 恢复执行
     */
    void resume(WorkflowExecutionId executionId);
    
    /**
     * 取消执行
     */
    void cancel(WorkflowExecutionId executionId);
    
    /**
     * 获取执行状态
     */
    WorkflowExecution getExecution(WorkflowExecutionId executionId);
    
    /**
     * 调试模式执行（单步）
     */
    WorkflowExecution debugStep(WorkflowExecutionId executionId);
    
    /**
     * 设置断点
     */
    void setBreakpoint(WorkflowExecutionId executionId, String nodeId);
    
    /**
     * 移除断点
     */
    void removeBreakpoint(WorkflowExecutionId executionId, String nodeId);
}
