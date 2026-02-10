package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecutionLog;
import com.novacloudedu.backend.domain.ai.repository.WorkflowExecutionLogRepository;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.WorkflowExecutionLogMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowExecutionLogPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 工作流执行日志仓储实现
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class WorkflowExecutionLogRepositoryImpl implements WorkflowExecutionLogRepository {

    private final WorkflowExecutionLogMapper mapper;
    private final ObjectMapper objectMapper;

    @Override
    public void save(WorkflowExecutionLog logEntry) {
        try {
            WorkflowExecutionLogPO po = toPO(logEntry);
            mapper.insert(po);
            logEntry.setId(po.getId());
        } catch (Exception e) {
            log.error("保存工作流执行日志失败: executionId={}", logEntry.getExecutionId().value(), e);
        }
    }

    @Override
    public void saveBatch(List<WorkflowExecutionLog> logs) {
        if (logs == null || logs.isEmpty()) return;
        for (WorkflowExecutionLog logEntry : logs) {
            save(logEntry);
        }
    }

    @Override
    public List<WorkflowExecutionLog> findByExecutionId(WorkflowExecutionId executionId) {
        try {
            List<WorkflowExecutionLogPO> poList = mapper.findByExecutionId(executionId.value());
            return poList.stream().map(this::toDomain).collect(Collectors.toList());
        } catch (Exception e) {
            log.error("查询执行日志失败: executionId={}", executionId.value(), e);
            return Collections.emptyList();
        }
    }

    @Override
    public List<WorkflowExecutionLog> findByWorkflowId(WorkflowId workflowId,
                                                         LocalDateTime startTime,
                                                         LocalDateTime endTime,
                                                         int page,
                                                         int size) {
        try {
            int offset = page * size;
            List<WorkflowExecutionLogPO> poList = mapper.findByWorkflowId(
                    workflowId.value(), startTime, endTime, offset, size);
            return poList.stream().map(this::toDomain).collect(Collectors.toList());
        } catch (Exception e) {
            log.error("查询工作流日志失败: workflowId={}", workflowId.value(), e);
            return Collections.emptyList();
        }
    }

    @Override
    public List<WorkflowExecutionLog> findByLevel(WorkflowExecutionId executionId, LogLevel level) {
        try {
            List<WorkflowExecutionLogPO> poList = mapper.findByLevel(executionId.value(), level.name());
            return poList.stream().map(this::toDomain).collect(Collectors.toList());
        } catch (Exception e) {
            log.error("按级别查询执行日志失败: executionId={}, level={}", executionId.value(), level, e);
            return Collections.emptyList();
        }
    }

    @Override
    public void deleteByExecutionId(WorkflowExecutionId executionId) {
        try {
            mapper.deleteByExecutionId(executionId.value());
        } catch (Exception e) {
            log.error("删除执行日志失败: executionId={}", executionId.value(), e);
        }
    }

    @Override
    public void deleteOlderThan(LocalDateTime time) {
        try {
            mapper.deleteOlderThan(time);
        } catch (Exception e) {
            log.error("清理过期日志失败: before={}", time, e);
        }
    }

    // ========== PO <-> Domain 转换 ==========

    private WorkflowExecutionLogPO toPO(WorkflowExecutionLog logEntry) {
        WorkflowExecutionLogPO po = new WorkflowExecutionLogPO();
        po.setId(logEntry.getId());
        po.setExecutionId(logEntry.getExecutionId().value());
        po.setWorkflowId(logEntry.getWorkflowId().value());
        po.setWorkflowName(logEntry.getWorkflowName());
        po.setNodeId(logEntry.getNodeId());
        po.setNodeName(logEntry.getNodeName());
        po.setNodeType(logEntry.getNodeType() != null ? logEntry.getNodeType().name() : null);
        po.setLevel(logEntry.getLevel().name());
        po.setMessage(logEntry.getMessage());
        po.setInput(toJson(logEntry.getInput()));
        po.setOutput(toJson(logEntry.getOutput()));
        po.setErrorStack(logEntry.getErrorStack());
        po.setDurationMs(logEntry.getDurationMs());
        po.setTraceId(logEntry.getTraceId());
        po.setUserId(logEntry.getUserId() != null ? logEntry.getUserId().value() : null);
        po.setTimestamp(logEntry.getTimestamp());
        return po;
    }

    private WorkflowExecutionLog toDomain(WorkflowExecutionLogPO po) {
        WorkflowExecutionLog logEntry = WorkflowExecutionLog.create(
                WorkflowExecutionId.of(po.getExecutionId()),
                WorkflowId.of(po.getWorkflowId()),
                po.getWorkflowName(),
                po.getNodeId(),
                po.getNodeName(),
                po.getNodeType() != null ? NodeType.valueOf(po.getNodeType()) : null,
                LogLevel.valueOf(po.getLevel()),
                po.getMessage(),
                po.getUserId() != null ? new UserId(po.getUserId()) : null
        );
        logEntry.setId(po.getId());

        if (po.getInput() != null) {
            logEntry.withInput(fromJson(po.getInput()));
        }
        if (po.getOutput() != null) {
            logEntry.withOutput(fromJson(po.getOutput()));
        }
        if (po.getErrorStack() != null) {
            logEntry.withError(po.getErrorStack());
        }
        if (po.getDurationMs() != null) {
            logEntry.withDuration(po.getDurationMs());
        }
        if (po.getTraceId() != null) {
            logEntry.withTraceId(po.getTraceId());
        }
        return logEntry;
    }

    private String toJson(Object obj) {
        if (obj == null) return null;
        try {
            return objectMapper.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            log.warn("序列化JSON失败", e);
            return null;
        }
    }

    private Map<String, Object> fromJson(String json) {
        if (json == null || json.isBlank()) return null;
        try {
            return objectMapper.readValue(json, new TypeReference<>() {});
        } catch (JsonProcessingException e) {
            log.warn("反序列化JSON失败", e);
            return null;
        }
    }
}
