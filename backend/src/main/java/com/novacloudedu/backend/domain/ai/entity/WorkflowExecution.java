package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 工作流执行实体
 */
@Getter
public class WorkflowExecution {
    
    private WorkflowExecutionId id;
    private WorkflowId workflowId;
    private String workflowName;
    private int workflowVersion;
    private ExecutionStatus status;
    private Map<String, Object> input;
    private Map<String, Object> output;
    private Map<String, Object> variables;
    private List<NodeExecution> nodeExecutions;
    private String currentNodeId;
    private String errorMessage;
    private UserId userId;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private long durationMs;
    
    private WorkflowExecution() {
        this.variables = new HashMap<>();
        this.nodeExecutions = new ArrayList<>();
    }
    
    public static WorkflowExecution create(Workflow workflow, Map<String, Object> input, UserId userId) {
        WorkflowExecution execution = new WorkflowExecution();
        execution.id = WorkflowExecutionId.generate();
        execution.workflowId = workflow.getId();
        execution.workflowName = workflow.getName();
        execution.workflowVersion = workflow.getVersion();
        execution.status = ExecutionStatus.PENDING;
        execution.input = input != null ? new HashMap<>(input) : new HashMap<>();
        execution.output = new HashMap<>();
        execution.userId = userId;
        return execution;
    }
    
    public static WorkflowExecution reconstruct(
            WorkflowExecutionId id,
            WorkflowId workflowId,
            String workflowName,
            int workflowVersion,
            ExecutionStatus status,
            Map<String, Object> input,
            Map<String, Object> output,
            Map<String, Object> variables,
            String currentNodeId,
            String errorMessage,
            UserId userId,
            LocalDateTime startTime,
            LocalDateTime endTime,
            long durationMs) {
        WorkflowExecution execution = new WorkflowExecution();
        execution.id = id;
        execution.workflowId = workflowId;
        execution.workflowName = workflowName;
        execution.workflowVersion = workflowVersion;
        execution.status = status;
        execution.input = input;
        execution.output = output;
        execution.variables = variables;
        execution.currentNodeId = currentNodeId;
        execution.errorMessage = errorMessage;
        execution.userId = userId;
        execution.startTime = startTime;
        execution.endTime = endTime;
        execution.durationMs = durationMs;
        return execution;
    }
    
    public void start() {
        this.status = ExecutionStatus.RUNNING;
        this.startTime = LocalDateTime.now();
    }
    
    public void pause() {
        this.status = ExecutionStatus.PAUSED;
    }
    
    public void resume() {
        this.status = ExecutionStatus.RUNNING;
    }
    
    public void complete(Map<String, Object> output) {
        this.status = ExecutionStatus.COMPLETED;
        this.output = output;
        this.endTime = LocalDateTime.now();
        this.durationMs = java.time.Duration.between(startTime, endTime).toMillis();
    }
    
    public void fail(String errorMessage) {
        this.status = ExecutionStatus.FAILED;
        this.errorMessage = errorMessage;
        this.endTime = LocalDateTime.now();
        if (this.startTime != null) {
            this.durationMs = java.time.Duration.between(startTime, endTime).toMillis();
        }
    }
    
    public void timeout() {
        this.status = ExecutionStatus.TIMEOUT;
        this.errorMessage = "执行超时";
        this.endTime = LocalDateTime.now();
        if (this.startTime != null) {
            this.durationMs = java.time.Duration.between(startTime, endTime).toMillis();
        }
    }
    
    public void cancel() {
        this.status = ExecutionStatus.CANCELLED;
        this.endTime = LocalDateTime.now();
        if (this.startTime != null) {
            this.durationMs = java.time.Duration.between(startTime, endTime).toMillis();
        }
    }
    
    public void setCurrentNode(String nodeId) {
        this.currentNodeId = nodeId;
    }
    
    public void setVariable(String name, Object value) {
        this.variables.put(name, value);
    }
    
    public Object getVariable(String name) {
        return this.variables.get(name);
    }
    
    public void addNodeExecution(NodeExecution nodeExecution) {
        this.nodeExecutions.add(nodeExecution);
    }
    
    @Getter
    public static class NodeExecution {
        private String nodeId;
        private String nodeName;
        private NodeType nodeType;
        private NodeExecutionStatus status;
        private Map<String, Object> input;
        private Map<String, Object> output;
        private String errorMessage;
        private int retryCount;
        private LocalDateTime startTime;
        private LocalDateTime endTime;
        private long durationMs;
        
        public static NodeExecution create(String nodeId, String nodeName, NodeType nodeType) {
            NodeExecution ne = new NodeExecution();
            ne.nodeId = nodeId;
            ne.nodeName = nodeName;
            ne.nodeType = nodeType;
            ne.status = NodeExecutionStatus.PENDING;
            ne.input = new HashMap<>();
            ne.output = new HashMap<>();
            ne.retryCount = 0;
            return ne;
        }
        
        public void start(Map<String, Object> input) {
            this.status = NodeExecutionStatus.RUNNING;
            this.input = input;
            this.startTime = LocalDateTime.now();
        }
        
        public void complete(Map<String, Object> output) {
            this.status = NodeExecutionStatus.COMPLETED;
            this.output = output;
            this.endTime = LocalDateTime.now();
            this.durationMs = java.time.Duration.between(startTime, endTime).toMillis();
        }
        
        public void fail(String errorMessage) {
            this.status = NodeExecutionStatus.FAILED;
            this.errorMessage = errorMessage;
            this.endTime = LocalDateTime.now();
            if (this.startTime != null) {
                this.durationMs = java.time.Duration.between(startTime, endTime).toMillis();
            }
        }
        
        public void skip() {
            this.status = NodeExecutionStatus.SKIPPED;
        }
        
        public void incrementRetry() {
            this.retryCount++;
        }
    }
}
