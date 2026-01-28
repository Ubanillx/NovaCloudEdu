package com.novacloudedu.backend.domain.ai.service.workflow;

import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 工作流执行结果
 */
@Data
@Builder
public class WorkflowExecutionResult {
    
    /** 执行ID */
    private String executionId;
    
    /** 工作流ID */
    private Long workflowId;
    
    /** 执行状态 */
    private String status;
    
    /** 输出结果 */
    private Map<String, Object> output;
    
    /** 错误信息 */
    private String errorMessage;
    
    /** 执行日志 */
    private List<WorkflowExecutionContext.ExecutionLog> logs;
    
    /** 执行耗时（毫秒） */
    private long durationMs;
}
