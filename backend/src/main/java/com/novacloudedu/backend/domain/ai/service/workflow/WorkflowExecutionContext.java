package com.novacloudedu.backend.domain.ai.service.workflow;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 工作流执行上下文
 * 管理整个工作流执行过程中的数据流转
 */
@Data
@Slf4j
public class WorkflowExecutionContext {

    /** 执行ID */
    private final String executionId;
    
    /** 工作流ID */
    private final Long workflowId;
    
    /** 用户ID */
    private final Long userId;
    
    /** 执行开始时间 */
    private final LocalDateTime startTime;
    
    /** 全局变量（整个工作流共享） */
    private final Map<String, Object> globalVariables = new ConcurrentHashMap<>();
    
    /** 节点输出缓存（nodeId -> output） */
    private final Map<String, Map<String, Object>> nodeOutputs = new ConcurrentHashMap<>();
    
    /** 节点执行状态（nodeId -> status） */
    private final Map<String, NodeExecutionStatus> nodeStatuses = new ConcurrentHashMap<>();
    
    /** 执行日志 */
    private final List<ExecutionLog> executionLogs = Collections.synchronizedList(new ArrayList<>());
    
    /** 输入参数 */
    private final Map<String, Object> input;
    
    /** 最终输出 */
    private Map<String, Object> output;
    
    /** 执行状态 */
    private ExecutionStatus status = ExecutionStatus.RUNNING;
    
    /** 错误信息 */
    private String errorMessage;
    
    /** 当前执行的节点ID */
    private String currentNodeId;
    
    /** 循环上下文栈（支持嵌套循环） */
    private final Deque<LoopContext> loopContextStack = new ArrayDeque<>();

    public WorkflowExecutionContext(String executionId, Long workflowId, Long userId, Map<String, Object> input) {
        this.executionId = executionId;
        this.workflowId = workflowId;
        this.userId = userId;
        this.input = input != null ? new HashMap<>(input) : new HashMap<>();
        this.startTime = LocalDateTime.now();
        
        // 将输入参数设置为全局变量
        this.globalVariables.putAll(this.input);
    }

    // ==================== 变量操作 ====================

    /**
     * 设置全局变量
     */
    public void setVariable(String name, Object value) {
        globalVariables.put(name, value);
        log.debug("设置变量: {} = {}", name, value);
    }

    /**
     * 获取变量值（优先从当前循环上下文获取，然后是全局变量）
     */
    public Object getVariable(String name) {
        // 先从循环上下文查找
        if (!loopContextStack.isEmpty()) {
            LoopContext loopContext = loopContextStack.peek();
            if (loopContext.hasVariable(name)) {
                return loopContext.getVariable(name);
            }
        }
        return globalVariables.get(name);
    }

    /**
     * 获取变量值，带默认值
     */
    public Object getVariable(String name, Object defaultValue) {
        Object value = getVariable(name);
        return value != null ? value : defaultValue;
    }

    /**
     * 获取所有可用变量（合并循环上下文和全局变量）
     */
    public Map<String, Object> getAllVariables() {
        Map<String, Object> allVars = new HashMap<>(globalVariables);
        if (!loopContextStack.isEmpty()) {
            allVars.putAll(loopContextStack.peek().getVariables());
        }
        return allVars;
    }

    /**
     * 解析模板字符串，替换变量占位符
     */
    public String resolveTemplate(String template) {
        if (template == null) return null;
        
        String result = template;
        Map<String, Object> allVars = getAllVariables();
        
        for (Map.Entry<String, Object> entry : allVars.entrySet()) {
            String placeholder = "${" + entry.getKey() + "}";
            if (result.contains(placeholder)) {
                result = result.replace(placeholder, String.valueOf(entry.getValue()));
            }
        }
        return result;
    }

    // ==================== 节点输出管理 ====================

    /**
     * 保存节点输出
     */
    public void saveNodeOutput(String nodeId, Map<String, Object> output) {
        nodeOutputs.put(nodeId, new HashMap<>(output));
        
        // 将节点输出合并到全局变量
        globalVariables.putAll(output);
        
        log.debug("保存节点输出: nodeId={}, keys={}", nodeId, output.keySet());
    }

    /**
     * 获取节点输出
     */
    public Map<String, Object> getNodeOutput(String nodeId) {
        return nodeOutputs.getOrDefault(nodeId, Map.of());
    }

    /**
     * 获取上游节点的输出（用于数据流转）
     */
    public Object getUpstreamOutput(String nodeId, String outputKey) {
        Map<String, Object> output = nodeOutputs.get(nodeId);
        return output != null ? output.get(outputKey) : null;
    }

    // ==================== 节点状态管理 ====================

    /**
     * 更新节点执行状态
     */
    public void updateNodeStatus(String nodeId, NodeExecutionStatus status) {
        nodeStatuses.put(nodeId, status);
        this.currentNodeId = nodeId;
    }

    /**
     * 获取节点执行状态
     */
    public NodeExecutionStatus getNodeStatus(String nodeId) {
        return nodeStatuses.getOrDefault(nodeId, NodeExecutionStatus.PENDING);
    }

    /**
     * 检查节点是否已执行
     */
    public boolean isNodeExecuted(String nodeId) {
        NodeExecutionStatus status = nodeStatuses.get(nodeId);
        return status == NodeExecutionStatus.SUCCESS || status == NodeExecutionStatus.SKIPPED;
    }

    // ==================== 执行日志 ====================

    /**
     * 添加执行日志
     */
    public void addLog(String nodeId, String level, String message) {
        executionLogs.add(new ExecutionLog(
                LocalDateTime.now(),
                nodeId,
                level,
                message
        ));
    }

    /**
     * 添加INFO日志
     */
    public void logInfo(String nodeId, String message) {
        addLog(nodeId, "INFO", message);
    }

    /**
     * 添加ERROR日志
     */
    public void logError(String nodeId, String message) {
        addLog(nodeId, "ERROR", message);
    }

    // ==================== 循环上下文管理 ====================

    /**
     * 进入循环
     */
    public void enterLoop(String loopNodeId, String itemVariable, String indexVariable) {
        LoopContext loopContext = new LoopContext(loopNodeId, itemVariable, indexVariable);
        loopContextStack.push(loopContext);
        log.debug("进入循环: nodeId={}, itemVar={}, indexVar={}", loopNodeId, itemVariable, indexVariable);
    }

    /**
     * 设置当前循环迭代
     */
    public void setLoopIteration(Object item, int index) {
        if (!loopContextStack.isEmpty()) {
            LoopContext loopContext = loopContextStack.peek();
            loopContext.setCurrentItem(item);
            loopContext.setCurrentIndex(index);
            
            // 同时设置到全局变量，方便节点访问
            if (loopContext.getItemVariable() != null) {
                globalVariables.put(loopContext.getItemVariable(), item);
            }
            if (loopContext.getIndexVariable() != null) {
                globalVariables.put(loopContext.getIndexVariable(), index);
            }
        }
    }

    /**
     * 退出循环
     */
    public void exitLoop() {
        if (!loopContextStack.isEmpty()) {
            LoopContext loopContext = loopContextStack.pop();
            log.debug("退出循环: nodeId={}", loopContext.getLoopNodeId());
        }
    }

    /**
     * 获取当前循环上下文
     */
    public LoopContext getCurrentLoopContext() {
        return loopContextStack.peek();
    }

    // ==================== 执行完成 ====================

    /**
     * 标记执行成功
     */
    public void markSuccess(Map<String, Object> output) {
        this.status = ExecutionStatus.SUCCESS;
        this.output = output;
    }

    /**
     * 标记执行失败
     */
    public void markFailed(String errorMessage) {
        this.status = ExecutionStatus.FAILED;
        this.errorMessage = errorMessage;
    }

    /**
     * 获取执行耗时（毫秒）
     */
    public long getDurationMs() {
        return java.time.Duration.between(startTime, LocalDateTime.now()).toMillis();
    }

    // ==================== 内部类 ====================

    /**
     * 节点执行状态
     */
    public enum NodeExecutionStatus {
        PENDING,    // 待执行
        RUNNING,    // 执行中
        SUCCESS,    // 成功
        FAILED,     // 失败
        SKIPPED     // 跳过
    }

    /**
     * 执行状态
     */
    public enum ExecutionStatus {
        RUNNING,    // 运行中
        SUCCESS,    // 成功
        FAILED,     // 失败
        CANCELLED   // 已取消
    }

    /**
     * 执行日志
     */
    public record ExecutionLog(
            LocalDateTime timestamp,
            String nodeId,
            String level,
            String message
    ) {}

    /**
     * 循环上下文
     */
    @Data
    public static class LoopContext {
        private final String loopNodeId;
        private final String itemVariable;
        private final String indexVariable;
        private final Map<String, Object> variables = new HashMap<>();
        private Object currentItem;
        private int currentIndex;
        private final List<Object> results = new ArrayList<>();

        public LoopContext(String loopNodeId, String itemVariable, String indexVariable) {
            this.loopNodeId = loopNodeId;
            this.itemVariable = itemVariable;
            this.indexVariable = indexVariable;
        }

        public boolean hasVariable(String name) {
            return variables.containsKey(name) || 
                   name.equals(itemVariable) || 
                   name.equals(indexVariable);
        }

        public Object getVariable(String name) {
            if (name.equals(itemVariable)) return currentItem;
            if (name.equals(indexVariable)) return currentIndex;
            return variables.get(name);
        }

        public void setVariable(String name, Object value) {
            variables.put(name, value);
        }

        public void addResult(Object result) {
            results.add(result);
        }
    }
}
