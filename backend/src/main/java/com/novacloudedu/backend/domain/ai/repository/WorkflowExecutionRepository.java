package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.valueobject.ExecutionStatus;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowExecutionId;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * 工作流执行记录仓储接口
 */
public interface WorkflowExecutionRepository {

    /**
     * 保存执行记录
     */
    void save(WorkflowExecution execution);

    /**
     * 更新执行记录
     */
    void update(WorkflowExecution execution);

    /**
     * 根据ID查找
     */
    Optional<WorkflowExecution> findById(WorkflowExecutionId id);

    /**
     * 根据工作流ID查找执行记录
     */
    List<WorkflowExecution> findByWorkflowId(WorkflowId workflowId, int page, int size);

    /**
     * 根据用户ID查找执行记录
     */
    List<WorkflowExecution> findByUserId(UserId userId, int page, int size);

    /**
     * 根据状态查找执行记录
     */
    List<WorkflowExecution> findByStatus(ExecutionStatus status);

    /**
     * 查找指定时间范围内的执行记录
     */
    List<WorkflowExecution> findByTimeRange(LocalDateTime start, LocalDateTime end, int page, int size);

    /**
     * 统计工作流执行次数
     */
    long countByWorkflowId(WorkflowId workflowId);

    /**
     * 统计用户执行次数
     */
    long countByUserId(UserId userId);

    /**
     * 统计指定状态的执行次数
     */
    long countByStatus(ExecutionStatus status);

    /**
     * 获取工作流执行统计
     */
    ExecutionStatistics getStatistics(WorkflowId workflowId);

    /**
     * 删除执行记录
     */
    void delete(WorkflowExecutionId id);

    /**
     * 清理过期的执行记录
     */
    int cleanupExpired(LocalDateTime before);

    /**
     * 执行统计
     */
    record ExecutionStatistics(
            long totalCount,
            long successCount,
            long failedCount,
            long cancelledCount,
            double avgDurationMs,
            double successRate
    ) {}
}
