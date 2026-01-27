package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecutionLog;
import com.novacloudedu.backend.domain.ai.valueobject.LogLevel;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowExecutionId;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 工作流执行日志仓储接口
 */
public interface WorkflowExecutionLogRepository {

    void save(WorkflowExecutionLog log);

    void saveBatch(List<WorkflowExecutionLog> logs);

    List<WorkflowExecutionLog> findByExecutionId(WorkflowExecutionId executionId);

    List<WorkflowExecutionLog> findByWorkflowId(WorkflowId workflowId, 
                                                 LocalDateTime startTime, 
                                                 LocalDateTime endTime,
                                                 int page, 
                                                 int size);

    List<WorkflowExecutionLog> findByLevel(WorkflowExecutionId executionId, LogLevel level);

    void deleteByExecutionId(WorkflowExecutionId executionId);

    void deleteOlderThan(LocalDateTime time);
}
