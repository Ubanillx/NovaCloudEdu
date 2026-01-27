package com.novacloudedu.backend.infrastructure.workflow;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecutionLog;
import com.novacloudedu.backend.domain.ai.service.WorkflowLogService;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 默认工作流日志服务实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class DefaultWorkflowLogService implements WorkflowLogService {

    private final Map<String, List<WorkflowExecutionLog>> logStore = new ConcurrentHashMap<>();

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
        
        storeLog(executionId.value(), logEntry);
        
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
        
        storeLog(executionId.value(), logEntry);
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
        
        storeLog(executionId.value(), logEntry);
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
        
        storeLog(executionId.value(), logEntry);
        log.error("[Workflow] {} - 节点[{}]执行失败: {}", 
                executionId.value(), node.getName(), errorMessage);
    }

    @Override
    public List<WorkflowExecutionLog> findByExecutionId(WorkflowExecutionId executionId) {
        return logStore.getOrDefault(executionId.value(), new ArrayList<>());
    }

    @Override
    public List<WorkflowExecutionLog> findByWorkflowId(WorkflowId workflowId,
                                                        LocalDateTime startTime,
                                                        LocalDateTime endTime,
                                                        int page,
                                                        int size) {
        List<WorkflowExecutionLog> result = new ArrayList<>();
        for (List<WorkflowExecutionLog> logs : logStore.values()) {
            for (WorkflowExecutionLog logEntry : logs) {
                if (logEntry.getWorkflowId().equals(workflowId)) {
                    LocalDateTime ts = logEntry.getTimestamp();
                    if ((startTime == null || !ts.isBefore(startTime)) &&
                        (endTime == null || !ts.isAfter(endTime))) {
                        result.add(logEntry);
                    }
                }
            }
        }
        
        int start = page * size;
        int end = Math.min(start + size, result.size());
        if (start >= result.size()) {
            return new ArrayList<>();
        }
        return result.subList(start, end);
    }

    @Override
    public List<WorkflowExecutionLog> findByLevel(WorkflowExecutionId executionId, LogLevel level) {
        List<WorkflowExecutionLog> logs = logStore.getOrDefault(executionId.value(), new ArrayList<>());
        return logs.stream()
                .filter(l -> l.getLevel() == level || l.getLevel().getLevel() >= level.getLevel())
                .toList();
    }

    private void storeLog(String executionId, WorkflowExecutionLog logEntry) {
        logStore.computeIfAbsent(executionId, k -> new ArrayList<>()).add(logEntry);
    }
}
