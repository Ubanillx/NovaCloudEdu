package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 工作流执行实体 — 跟踪一次工作流执行的完整状态
 *
 * <h3>生命周期</h3>
 * <pre>
 * PENDING → start() → RUNNING → complete()/fail()/timeout()/cancel() → 终态
 *                         ↓
 *                     pause() → PAUSED → resume() → RUNNING
 * </pre>
 *
 * <h3>关键字段</h3>
 * <ul>
 *   <li><b>variables</b>: ConcurrentHashMap — 工作流全局变量，节点执行时读写</li>
 *   <li><b>nodeExecutions</b>: CopyOnWriteArrayList — 节点执行历史记录</li>
 *   <li><b>status</b>: volatile — 保证多线程可见性（并行分支场景）</li>
 *   <li><b>nodeExecutionCount</b>: AtomicInteger — 全局节点执行计数，防止无限循环</li>
 *   <li><b>deadlineMs</b>: 执行超时截止时间戳</li>
 *   <li><b>parentExecution</b>: 并行分支的父执行引用，用于感知取消/暂停</li>
 * </ul>
 *
 * <h3>并行分支场景 (forkForBranch)</h3>
 * <p>为并行分支创建的副本具有以下特点：</p>
 * <ul>
 *   <li>变量 (variables) 使用独立快照，避免多线程竞态</li>
 *   <li>nodeExecutionCount 共享父执行的 AtomicInteger，确保全局上限生效</li>
 *   <li>parentExecution 指向父执行，使分支能在 checkExecutionLimits() 中感知取消/暂停</li>
 *   <li>nodeExecutions 列表独立（分支的节点执行历史不合并到父执行）</li>
 * </ul>
 *
 * <h3>安全限制</h3>
 * <ul>
 *   <li>MAX_NODE_EXECUTIONS = 10000 — 单次执行最大节点执行次数，超限抛异常</li>
 *   <li>DEFAULT_TIMEOUT_MS = 300000 (5分钟) — 默认超时，可通过工作流定义覆盖</li>
 * </ul>
 */
@Getter
public class WorkflowExecution {
    
    private WorkflowExecutionId id;
    private WorkflowId workflowId;
    private String workflowName;
    private int workflowVersion;
    private volatile ExecutionStatus status;
    private Map<String, Object> input;
    private Map<String, Object> output;
    private Map<String, Object> variables;
    private List<NodeExecution> nodeExecutions;
    private volatile String currentNodeId;
    private String errorMessage;
    private UserId userId;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private long durationMs;
    private long deadlineMs;
    private AtomicInteger nodeExecutionCount = new AtomicInteger(0);
    private static final int MAX_NODE_EXECUTIONS = 10000;
    private static final long DEFAULT_TIMEOUT_MS = 300000; // 5分钟
    
    /** 并行分支的父执行引用，用于检查父执行是否已取消/暂停 */
    private volatile WorkflowExecution parentExecution;
    
    private WorkflowExecution() {
        this.variables = new ConcurrentHashMap<>();
        this.nodeExecutions = new CopyOnWriteArrayList<>();
    }
    
    public static WorkflowExecution create(Workflow workflow, Map<String, Object> input, UserId userId) {
        WorkflowExecution execution = new WorkflowExecution();
        execution.id = WorkflowExecutionId.generate();
        execution.workflowId = workflow.getId();
        execution.workflowName = workflow.getName();
        execution.workflowVersion = workflow.getVersion();
        execution.status = ExecutionStatus.PENDING;
        execution.input = input != null ? new ConcurrentHashMap<>(input) : new ConcurrentHashMap<>();
        execution.output = new ConcurrentHashMap<>();
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
            long durationMs,
            List<NodeExecution> nodeExecutions) {
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
        if (nodeExecutions != null) {
            execution.nodeExecutions = new CopyOnWriteArrayList<>(nodeExecutions);
        }
        return execution;
    }
    
    public void start() {
        this.status = ExecutionStatus.RUNNING;
        this.startTime = LocalDateTime.now();
        if (this.deadlineMs <= 0) {
            this.deadlineMs = System.currentTimeMillis() + DEFAULT_TIMEOUT_MS;
        }
    }
    
    public void setDeadlineMs(long deadlineMs) {
        this.deadlineMs = deadlineMs;
    }
    
    /**
     * 检查执行是否已超时或超过最大节点执行次数。
     * 每次节点执行前调用，自动递增计数器。
     * @throws IllegalStateException 如果超时或超限
     */
    public void checkExecutionLimits() {
        // 检查父执行是否已取消/暂停（并行分支场景）
        if (parentExecution != null) {
            ExecutionStatus parentStatus = parentExecution.status;
            if (parentStatus == ExecutionStatus.CANCELLED || parentStatus == ExecutionStatus.FAILED 
                    || parentStatus == ExecutionStatus.TIMEOUT) {
                this.status = parentStatus;
                throw new IllegalStateException("父执行已终止(status=" + parentStatus + ")，分支中止");
            }
            if (parentStatus == ExecutionStatus.PAUSED) {
                this.status = ExecutionStatus.PAUSED;
                throw new IllegalStateException("父执行已暂停，分支中止");
            }
        }
        if (System.currentTimeMillis() > deadlineMs) {
            this.timeout();
            throw new IllegalStateException("工作流执行超时(deadline=" + deadlineMs + "ms)");
        }
        int count = nodeExecutionCount.incrementAndGet();
        if (count > MAX_NODE_EXECUTIONS) {
            throw new IllegalStateException("工作流执行节点次数超限(max=" + MAX_NODE_EXECUTIONS + ")，可能存在无限循环");
        }
    }
    
    public void pause() {
        this.status = ExecutionStatus.PAUSED;
    }
    
    public void resume() {
        this.status = ExecutionStatus.RUNNING;
    }
    
    /**
     * 标记执行成功完成，记录输出和持续时间。
     */
    public void complete(Map<String, Object> output) {
        this.status = ExecutionStatus.COMPLETED;
        this.output = output;
        this.endTime = LocalDateTime.now();
        if (this.startTime != null) {
            this.durationMs = java.time.Duration.between(startTime, endTime).toMillis();
        }
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
        // ConcurrentHashMap 不允许 null value，null 语义等同于移除变量
        if (value == null) {
            this.variables.remove(name);
        } else {
            this.variables.put(name, value);
        }
    }
    
    public Object getVariable(String name) {
        return this.variables.get(name);
    }
    
    public void addNodeExecution(NodeExecution nodeExecution) {
        this.nodeExecutions.add(nodeExecution);
    }
    
    /**
     * 为并行分支创建一个轻量级的执行上下文副本。
     *
     * <p>副本特点：</p>
     * <ul>
     *   <li>共享: id, workflowId, workflowName, workflowVersion, input, userId, startTime, deadlineMs</li>
     *   <li>独立: variables (快照拷贝), output, nodeExecutions</li>
     *   <li>共享父计数器: nodeExecutionCount 与父执行共享同一个 AtomicInteger，
     *       确保所有分支的节点执行总数不超过 MAX_NODE_EXECUTIONS</li>
     *   <li>父执行引用: parentExecution 指向父执行，使分支在 checkExecutionLimits() 中
     *       能感知父执行的取消/暂停/失败/超时状态</li>
     * </ul>
     *
     * @return 新的 WorkflowExecution 副本
     */
    public WorkflowExecution forkForBranch() {
        WorkflowExecution fork = new WorkflowExecution();
        fork.id = this.id;
        fork.workflowId = this.workflowId;
        fork.workflowName = this.workflowName;
        fork.workflowVersion = this.workflowVersion;
        fork.status = this.status;
        fork.input = this.input;
        fork.output = new ConcurrentHashMap<>();
        fork.variables = new ConcurrentHashMap<>(this.variables);
        fork.userId = this.userId;
        fork.startTime = this.startTime;
        fork.deadlineMs = this.deadlineMs;
        // Fix: 共享父执行的节点计数器，确保全局上限生效
        fork.nodeExecutionCount = this.nodeExecutionCount;
        // Fix: 持有父执行引用，以便分支能感知父执行的取消/暂停
        fork.parentExecution = this;
        return fork;
    }
    
    /**
     * 单个节点的执行记录 — 跟踪节点的输入、输出、状态、持续时间、重试次数等。
     *
     * <p>生命周期: create() → start(input) → complete(output) / fail(errorMessage) / skip()</p>
     */
    @Getter
    @lombok.Setter
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
