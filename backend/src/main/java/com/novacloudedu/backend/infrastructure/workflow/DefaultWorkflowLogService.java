package com.novacloudedu.backend.infrastructure.workflow;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecutionLog;
import com.novacloudedu.backend.domain.ai.repository.WorkflowExecutionLogRepository;
import com.novacloudedu.backend.domain.ai.service.WorkflowLogService;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 默认工作流日志服务实现
 * <p>
 * 写入时同时写数据库（持久化）和内存缓存（加速当前会话查询）。
 * 查询时优先从内存缓存读取，缓存未命中则回退到数据库。
 * 内存缓存仅保留最近的执行日志，避免内存泄漏。
 */
@Slf4j
@Service
public class DefaultWorkflowLogService implements WorkflowLogService {

    private static final int MAX_CACHE_EXECUTIONS = 100;

    private final WorkflowExecutionLogRepository logRepository;
    private final Map<String, List<WorkflowExecutionLog>> logCache = new ConcurrentHashMap<>();

    public DefaultWorkflowLogService(WorkflowExecutionLogRepository logRepository) {
        this.logRepository = logRepository;
    }

    @Override
    public void log(WorkflowExecutionId executionId,
                    WorkflowId workflowId,
                    String workflowName,
                    String nodeId,
                    String nodeName,
                    NodeType nodeType,
                    LogLevel level,
                    String message,
                    UserId userId) {
        WorkflowExecutionLog logEntry = WorkflowExecutionLog.create(
                executionId, workflowId, workflowName,
                nodeId, nodeName, nodeType,
                level, message, userId
        );
        
        persistAndCache(executionId.value(), logEntry);
        
        // 同时输出到系统日志
        switch (level) {
            case DEBUG:
                log.debug("[Workflow] {} - {}: {}", executionId.value(), nodeName, message);
                break;
            case INFO:
                log.info("[Workflow] {} - {}: {}", executionId.value(), nodeName, message);
                break;
            case WARN:
                log.warn("[Workflow] {} - {}: {}", executionId.value(), nodeName, message);
                break;
            case ERROR:
                log.error("[Workflow] {} - {}: {}", executionId.value(), nodeName, message);
                break;
        }
    }

    @Override
    public void logNodeStart(WorkflowExecutionId executionId,
                             WorkflowId workflowId,
                             String workflowName,
                             WorkflowNode node,
                             Map<String, Object> input,
                             UserId userId) {
        WorkflowExecutionLog logEntry = WorkflowExecutionLog.create(
                executionId, workflowId, workflowName,
                node.getId(), node.getName(), node.getType(),
                LogLevel.INFO, "节点开始执行", userId
        ).withInput(input);
        
        persistAndCache(executionId.value(), logEntry);
        log.info("[Workflow] {} - 节点[{}]开始执行", executionId.value(), node.getName());
    }

    @Override
    public void logNodeComplete(WorkflowExecutionId executionId,
                                WorkflowId workflowId,
                                String workflowName,
                                WorkflowNode node,
                                Map<String, Object> output,
                                long durationMs,
                                UserId userId) {
        WorkflowExecutionLog logEntry = WorkflowExecutionLog.create(
                executionId, workflowId, workflowName,
                node.getId(), node.getName(), node.getType(),
                LogLevel.INFO, "节点执行完成", userId
        ).withOutput(output).withDuration(durationMs);
        
        persistAndCache(executionId.value(), logEntry);
        log.info("[Workflow] {} - 节点[{}]执行完成, 耗时{}ms", 
                executionId.value(), node.getName(), durationMs);
    }

    @Override
    public void logNodeError(WorkflowExecutionId executionId,
                             WorkflowId workflowId,
                             String workflowName,
                             WorkflowNode node,
                             String errorMessage,
                             String errorStack,
                             UserId userId) {
        WorkflowExecutionLog logEntry = WorkflowExecutionLog.create(
                executionId, workflowId, workflowName,
                node.getId(), node.getName(), node.getType(),
                LogLevel.ERROR, errorMessage, userId
        ).withError(errorStack);
        
        persistAndCache(executionId.value(), logEntry);
        log.error("[Workflow] {} - 节点[{}]执行失败: {}", 
                executionId.value(), node.getName(), errorMessage);
    }

    @Override
    public List<WorkflowExecutionLog> findByExecutionId(WorkflowExecutionId executionId) {
        // 优先内存缓存
        List<WorkflowExecutionLog> cached = logCache.get(executionId.value());
        if (cached != null && !cached.isEmpty()) {
            return new ArrayList<>(cached);
        }
        // 回退到数据库
        return logRepository.findByExecutionId(executionId);
    }

    @Override
    public List<WorkflowExecutionLog> findByWorkflowId(WorkflowId workflowId,
                                                        LocalDateTime startTime,
                                                        LocalDateTime endTime,
                                                        int page,
                                                        int size) {
        // 跨执行查询直接走数据库
        return logRepository.findByWorkflowId(workflowId, startTime, endTime, page, size);
    }

    @Override
    public List<WorkflowExecutionLog> findByLevel(WorkflowExecutionId executionId, LogLevel level) {
        // 优先内存缓存
        List<WorkflowExecutionLog> cached = logCache.get(executionId.value());
        if (cached != null && !cached.isEmpty()) {
            return cached.stream()
                    .filter(l -> l.getLevel() == level || l.getLevel().getLevel() >= level.getLevel())
                    .toList();
        }
        // 回退到数据库
        return logRepository.findByLevel(executionId, level);
    }

    /**
     * 同时写入数据库和内存缓存
     */
    private void persistAndCache(String executionId, WorkflowExecutionLog logEntry) {
        // 1. 持久化到数据库
        try {
            logRepository.save(logEntry);
        } catch (Exception e) {
            log.warn("持久化执行日志失败(不影响执行): executionId={}", executionId, e);
        }
        // 2. 写入内存缓存
        logCache.computeIfAbsent(executionId, k -> new ArrayList<>()).add(logEntry);
        // 3. 防止内存泄漏：缓存超过上限时淘汰最早的执行
        if (logCache.size() > MAX_CACHE_EXECUTIONS) {
            String oldest = logCache.keySet().iterator().next();
            logCache.remove(oldest);
        }
    }
}
