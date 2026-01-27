package com.novacloudedu.backend.application.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecutionLog;
import com.novacloudedu.backend.domain.ai.repository.WorkflowRepository;
import com.novacloudedu.backend.domain.ai.service.WorkflowEngine;
import com.novacloudedu.backend.domain.ai.service.WorkflowLogService;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 工作流应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class WorkflowApplicationService {

    private final WorkflowRepository workflowRepository;
    private final WorkflowEngine workflowEngine;
    private final WorkflowLogService logService;
    private final ObjectMapper objectMapper;

    /**
     * 创建工作流
     */
    @Transactional
    public WorkflowVO create(Long userId, String name, String description) {
        log.info("创建工作流: userId={}, name={}", userId, name);
        
        Workflow workflow = Workflow.create(name, description, UserId.of(userId));
        workflow = workflowRepository.save(workflow);
        
        return toVO(workflow);
    }

    /**
     * 更新工作流基本信息
     */
    @Transactional
    public WorkflowVO updateBasicInfo(Long id, String name, String description) {
        log.info("更新工作流基本信息: id={}", id);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + id));
        
        workflow.updateBasicInfo(name, description);
        workflow = workflowRepository.save(workflow);
        
        return toVO(workflow);
    }

    /**
     * 更新工作流定义
     */
    @Transactional
    public WorkflowVO updateDefinition(Long id, WorkflowDefinition definition) {
        log.info("更新工作流定义: id={}", id);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + id));
        
        workflow.updateDefinition(definition);
        workflow = workflowRepository.save(workflow);
        
        return toVO(workflow);
    }

    /**
     * 获取工作流详情
     */
    public WorkflowVO getById(Long id) {
        Workflow workflow = workflowRepository.findById(WorkflowId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + id));
        return toVO(workflow);
    }

    /**
     * 获取用户的工作流列表
     */
    public List<WorkflowVO> listByUser(Long userId, int page, int size) {
        List<Workflow> workflows = workflowRepository.findByCreatorId(UserId.of(userId), page, size);
        return workflows.stream().map(this::toVO).collect(Collectors.toList());
    }

    /**
     * 获取公开的工作流列表
     */
    public List<WorkflowVO> listPublic(int page, int size) {
        List<Workflow> workflows = workflowRepository.findPublicWorkflows(page, size);
        return workflows.stream().map(this::toVO).collect(Collectors.toList());
    }

    /**
     * 发布工作流
     */
    @Transactional
    public WorkflowVO publish(Long id) {
        log.info("发布工作流: id={}", id);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + id));
        
        workflow.publish();
        workflow = workflowRepository.save(workflow);
        
        return toVO(workflow);
    }

    /**
     * 归档工作流
     */
    @Transactional
    public WorkflowVO archive(Long id) {
        log.info("归档工作流: id={}", id);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + id));
        
        workflow.archive();
        workflow = workflowRepository.save(workflow);
        
        return toVO(workflow);
    }

    /**
     * 删除工作流
     */
    @Transactional
    public void delete(Long id) {
        log.info("删除工作流: id={}", id);
        workflowRepository.delete(WorkflowId.of(id));
    }

    /**
     * 执行工作流
     */
    public ExecutionResultVO execute(Long workflowId, Map<String, Object> input, Long userId) {
        log.info("执行工作流: workflowId={}, userId={}", workflowId, userId);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowExecution execution = workflowEngine.execute(workflow, input, UserId.of(userId));
        
        return toExecutionResultVO(execution);
    }

    /**
     * 异步执行工作流
     */
    public String executeAsync(Long workflowId, Map<String, Object> input, Long userId) {
        log.info("异步执行工作流: workflowId={}, userId={}", workflowId, userId);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowExecutionId executionId = workflowEngine.executeAsync(workflow, input, UserId.of(userId));
        
        return executionId.value();
    }

    /**
     * 获取执行状态
     */
    public ExecutionResultVO getExecutionStatus(String executionId) {
        WorkflowExecution execution = workflowEngine.getExecution(WorkflowExecutionId.of(executionId));
        if (execution == null) {
            throw new IllegalArgumentException("执行不存在: " + executionId);
        }
        return toExecutionResultVO(execution);
    }

    /**
     * 取消执行
     */
    public void cancelExecution(String executionId) {
        log.info("取消执行: executionId={}", executionId);
        workflowEngine.cancel(WorkflowExecutionId.of(executionId));
    }

    /**
     * 获取执行日志
     */
    public List<ExecutionLogVO> getExecutionLogs(String executionId) {
        List<WorkflowExecutionLog> logs = logService.findByExecutionId(WorkflowExecutionId.of(executionId));
        return logs.stream().map(this::toLogVO).collect(Collectors.toList());
    }

    private WorkflowVO toVO(Workflow workflow) {
        WorkflowVO vo = new WorkflowVO();
        vo.setId(workflow.getId().value());
        vo.setName(workflow.getName());
        vo.setDescription(workflow.getDescription());
        vo.setStatus(workflow.getStatus().name());
        vo.setVersion(workflow.getVersion());
        vo.setPublic(workflow.isPublic());
        vo.setCreatorId(workflow.getCreatorId().value());
        vo.setCreateTime(workflow.getCreateTime());
        vo.setUpdateTime(workflow.getUpdateTime());
        
        try {
            vo.setDefinition(objectMapper.writeValueAsString(workflow.getDefinition()));
        } catch (Exception e) {
            vo.setDefinition("{}");
        }
        
        return vo;
    }

    private ExecutionResultVO toExecutionResultVO(WorkflowExecution execution) {
        ExecutionResultVO vo = new ExecutionResultVO();
        vo.setExecutionId(execution.getId().value());
        vo.setWorkflowId(execution.getWorkflowId().value());
        vo.setWorkflowName(execution.getWorkflowName());
        vo.setStatus(execution.getStatus().name());
        vo.setInput(execution.getInput());
        vo.setOutput(execution.getOutput());
        vo.setVariables(execution.getVariables());
        vo.setCurrentNodeId(execution.getCurrentNodeId());
        vo.setErrorMessage(execution.getErrorMessage());
        vo.setStartTime(execution.getStartTime());
        vo.setEndTime(execution.getEndTime());
        vo.setDurationMs(execution.getDurationMs());
        return vo;
    }

    private ExecutionLogVO toLogVO(WorkflowExecutionLog log) {
        ExecutionLogVO vo = new ExecutionLogVO();
        vo.setExecutionId(log.getExecutionId().value());
        vo.setNodeId(log.getNodeId());
        vo.setNodeName(log.getNodeName());
        vo.setNodeType(log.getNodeType() != null ? log.getNodeType().name() : null);
        vo.setLevel(log.getLevel().name());
        vo.setMessage(log.getMessage());
        vo.setDurationMs(log.getDurationMs());
        vo.setTimestamp(log.getTimestamp());
        return vo;
    }

    @lombok.Data
    public static class WorkflowVO {
        private Long id;
        private String name;
        private String description;
        private String definition;
        private String status;
        private int version;
        private boolean isPublic;
        private Long creatorId;
        private java.time.LocalDateTime createTime;
        private java.time.LocalDateTime updateTime;
    }

    @lombok.Data
    public static class ExecutionResultVO {
        private String executionId;
        private Long workflowId;
        private String workflowName;
        private String status;
        private Map<String, Object> input;
        private Map<String, Object> output;
        private Map<String, Object> variables;
        private String currentNodeId;
        private String errorMessage;
        private java.time.LocalDateTime startTime;
        private java.time.LocalDateTime endTime;
        private long durationMs;
    }

    @lombok.Data
    public static class ExecutionLogVO {
        private String executionId;
        private String nodeId;
        private String nodeName;
        private String nodeType;
        private String level;
        private String message;
        private long durationMs;
        private java.time.LocalDateTime timestamp;
    }
}
