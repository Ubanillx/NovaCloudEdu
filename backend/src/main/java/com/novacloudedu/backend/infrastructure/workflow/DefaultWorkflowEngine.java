package com.novacloudedu.backend.infrastructure.workflow;

import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.service.WorkflowEngine;
import com.novacloudedu.backend.domain.ai.service.WorkflowLogService;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import java.util.*;
import java.util.concurrent.*;

/**
 * 默认工作流执行引擎实现
 */
@Slf4j
@Service
public class DefaultWorkflowEngine implements WorkflowEngine {

    private final Map<NodeType, NodeExecutor> executors = new HashMap<>();
    private final Map<String, WorkflowExecution> runningExecutions = new ConcurrentHashMap<>();
    private final Map<String, Set<String>> breakpoints = new ConcurrentHashMap<>();
    private final WorkflowLogService logService;
    
    private ExecutorService workflowExecutor;

    public DefaultWorkflowEngine(WorkflowLogService logService, List<NodeExecutor> nodeExecutors) {
        this.logService = logService;
        for (NodeExecutor executor : nodeExecutors) {
            executors.put(executor.getNodeType(), executor);
        }
    }

    @PostConstruct
    public void init() {
        workflowExecutor = new ThreadPoolExecutor(
                4, 10, 60L, TimeUnit.SECONDS,
                new LinkedBlockingQueue<>(200),
                new ThreadPoolExecutor.CallerRunsPolicy()
        );
        log.info("工作流执行引擎初始化完成，已注册{}个节点执行器", executors.size());
    }

    @PreDestroy
    public void destroy() {
        if (workflowExecutor != null) {
            workflowExecutor.shutdown();
            try {
                if (!workflowExecutor.awaitTermination(60, TimeUnit.SECONDS)) {
                    workflowExecutor.shutdownNow();
                }
            } catch (InterruptedException e) {
                workflowExecutor.shutdownNow();
                Thread.currentThread().interrupt();
            }
        }
    }

    @Override
    public WorkflowExecution execute(Workflow workflow, Map<String, Object> input, UserId userId) {
        if (!workflow.canExecute()) {
            throw new IllegalStateException("工作流未发布，无法执行");
        }

        WorkflowExecution execution = WorkflowExecution.create(workflow, input, userId);
        runningExecutions.put(execution.getId().value(), execution);

        try {
            execution.start();
            
            // 初始化变量
            initializeVariables(execution, workflow.getDefinition(), input);
            
            // 找到开始节点
            WorkflowNode startNode = workflow.getDefinition().findStartNode();
            if (startNode == null) {
                throw new IllegalStateException("工作流缺少开始节点");
            }

            // 执行工作流
            executeFromNode(execution, workflow.getDefinition(), startNode.getId());

            // 完成执行
            execution.complete(execution.getVariables());
            
            log.info("工作流执行完成: executionId={}, duration={}ms", 
                    execution.getId().value(), execution.getDurationMs());

        } catch (Exception e) {
            log.error("工作流执行失败: executionId={}", execution.getId().value(), e);
            execution.fail(e.getMessage());
        } finally {
            runningExecutions.remove(execution.getId().value());
        }

        return execution;
    }

    @Override
    public WorkflowExecutionId executeAsync(Workflow workflow, Map<String, Object> input, UserId userId) {
        WorkflowExecution execution = WorkflowExecution.create(workflow, input, userId);
        runningExecutions.put(execution.getId().value(), execution);

        workflowExecutor.submit(() -> {
            try {
                execute(workflow, input, userId);
            } catch (Exception e) {
                log.error("异步工作流执行失败: executionId={}", execution.getId().value(), e);
            }
        });

        return execution.getId();
    }

    @Override
    public void pause(WorkflowExecutionId executionId) {
        WorkflowExecution execution = runningExecutions.get(executionId.value());
        if (execution != null) {
            execution.pause();
            log.info("工作流已暂停: executionId={}", executionId.value());
        }
    }

    @Override
    public void resume(WorkflowExecutionId executionId) {
        WorkflowExecution execution = runningExecutions.get(executionId.value());
        if (execution != null) {
            execution.resume();
            log.info("工作流已恢复: executionId={}", executionId.value());
        }
    }

    @Override
    public void cancel(WorkflowExecutionId executionId) {
        WorkflowExecution execution = runningExecutions.get(executionId.value());
        if (execution != null) {
            execution.cancel();
            runningExecutions.remove(executionId.value());
            log.info("工作流已取消: executionId={}", executionId.value());
        }
    }

    @Override
    public WorkflowExecution getExecution(WorkflowExecutionId executionId) {
        return runningExecutions.get(executionId.value());
    }

    @Override
    public WorkflowExecution debugStep(WorkflowExecutionId executionId) {
        WorkflowExecution execution = runningExecutions.get(executionId.value());
        if (execution == null) {
            throw new IllegalArgumentException("执行不存在: " + executionId.value());
        }
        // 单步执行逻辑
        return execution;
    }

    @Override
    public void setBreakpoint(WorkflowExecutionId executionId, String nodeId) {
        breakpoints.computeIfAbsent(executionId.value(), k -> new HashSet<>()).add(nodeId);
        log.info("设置断点: executionId={}, nodeId={}", executionId.value(), nodeId);
    }

    @Override
    public void removeBreakpoint(WorkflowExecutionId executionId, String nodeId) {
        Set<String> bps = breakpoints.get(executionId.value());
        if (bps != null) {
            bps.remove(nodeId);
        }
        log.info("移除断点: executionId={}, nodeId={}", executionId.value(), nodeId);
    }

    private void initializeVariables(WorkflowExecution execution, WorkflowDefinition definition, Map<String, Object> input) {
        // 设置默认变量
        for (Map.Entry<String, WorkflowDefinition.VariableDefinition> entry : definition.getVariables().entrySet()) {
            execution.setVariable(entry.getKey(), entry.getValue().getDefaultValue());
        }
        // 覆盖输入变量
        if (input != null) {
            for (Map.Entry<String, Object> entry : input.entrySet()) {
                execution.setVariable(entry.getKey(), entry.getValue());
            }
        }
    }

    private void executeFromNode(WorkflowExecution execution, WorkflowDefinition definition, String nodeId) {
        if (execution.getStatus() != ExecutionStatus.RUNNING) {
            return;
        }

        WorkflowNode node = definition.findNodeById(nodeId);
        if (node == null) {
            return;
        }

        // 检查断点
        Set<String> bps = breakpoints.get(execution.getId().value());
        if (bps != null && bps.contains(nodeId)) {
            execution.pause();
            log.info("命中断点，暂停执行: nodeId={}", nodeId);
            return;
        }

        execution.setCurrentNode(nodeId);

        // 创建节点执行记录
        WorkflowExecution.NodeExecution nodeExecution = 
                WorkflowExecution.NodeExecution.create(nodeId, node.getName(), node.getType());
        execution.addNodeExecution(nodeExecution);

        try {
            // 记录节点开始日志
            logService.logNodeStart(execution.getId(), execution.getWorkflowId(), 
                    execution.getWorkflowName(), node, execution.getVariables(), execution.getUserId());

            long startTime = System.currentTimeMillis();
            nodeExecution.start(new HashMap<>(execution.getVariables()));

            // 执行节点
            NodeExecutor executor = executors.get(node.getType());
            Map<String, Object> output;
            
            if (executor != null) {
                output = executeWithRetry(executor, node, execution);
            } else {
                // 默认处理
                output = handleDefaultNode(node, execution);
            }

            long duration = System.currentTimeMillis() - startTime;
            nodeExecution.complete(output);

            // 更新变量
            if (output != null) {
                for (Map.Entry<String, Object> entry : output.entrySet()) {
                    execution.setVariable(entry.getKey(), entry.getValue());
                }
            }

            // 记录节点完成日志
            logService.logNodeComplete(execution.getId(), execution.getWorkflowId(),
                    execution.getWorkflowName(), node, output, duration, execution.getUserId());

            // 处理下一个节点
            List<WorkflowEdge> outgoingEdges = definition.findOutgoingEdges(nodeId);
            for (WorkflowEdge edge : outgoingEdges) {
                if (evaluateCondition(edge.getCondition(), execution.getVariables())) {
                    executeFromNode(execution, definition, edge.getTargetNodeId());
                    break;
                }
            }

        } catch (Exception e) {
            nodeExecution.fail(e.getMessage());
            logService.logNodeError(execution.getId(), execution.getWorkflowId(),
                    execution.getWorkflowName(), node, e.getMessage(), 
                    getStackTrace(e), execution.getUserId());
            
            // 错误处理
            handleNodeError(execution, definition, node, e);
        }
    }

    private Map<String, Object> executeWithRetry(NodeExecutor executor, WorkflowNode node, 
                                                   WorkflowExecution execution) {
        WorkflowNode.ErrorHandlingConfig errorConfig = node.getErrorHandling();
        if (errorConfig == null) {
            errorConfig = WorkflowNode.ErrorHandlingConfig.defaultConfig();
        }

        int maxRetries = errorConfig.getRetryCount();
        long retryDelay = errorConfig.getRetryDelayMs();
        
        Exception lastException = null;
        for (int i = 0; i <= maxRetries; i++) {
            try {
                return executor.execute(node, execution.getVariables(), execution);
            } catch (Exception e) {
                lastException = e;
                if (i < maxRetries) {
                    log.warn("节点执行失败，准备重试: nodeId={}, retry={}/{}", 
                            node.getId(), i + 1, maxRetries);
                    try {
                        Thread.sleep(retryDelay);
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                        throw new RuntimeException("重试被中断", ie);
                    }
                }
            }
        }
        throw new RuntimeException("节点执行失败，已重试" + maxRetries + "次", lastException);
    }

    private Map<String, Object> handleDefaultNode(WorkflowNode node, WorkflowExecution execution) {
        switch (node.getType()) {
            case START:
                return new HashMap<>(execution.getInput());
            case END:
                return execution.getVariables();
            case VARIABLE_SET:
                return handleVariableSet(node, execution);
            case VARIABLE_GET:
                return handleVariableGet(node, execution);
            default:
                log.warn("未找到节点执行器: nodeType={}", node.getType());
                return new HashMap<>();
        }
    }

    private Map<String, Object> handleVariableSet(WorkflowNode node, WorkflowExecution execution) {
        Map<String, Object> config = node.getConfig();
        if (config != null) {
            String varName = (String) config.get("variableName");
            Object varValue = config.get("value");
            if (varName != null) {
                execution.setVariable(varName, varValue);
            }
        }
        return new HashMap<>();
    }

    private Map<String, Object> handleVariableGet(WorkflowNode node, WorkflowExecution execution) {
        Map<String, Object> config = node.getConfig();
        Map<String, Object> result = new HashMap<>();
        if (config != null) {
            String varName = (String) config.get("variableName");
            if (varName != null) {
                result.put("value", execution.getVariable(varName));
            }
        }
        return result;
    }

    private void handleNodeError(WorkflowExecution execution, WorkflowDefinition definition,
                                  WorkflowNode node, Exception e) {
        WorkflowNode.ErrorHandlingConfig errorConfig = node.getErrorHandling();
        if (errorConfig == null) {
            errorConfig = WorkflowNode.ErrorHandlingConfig.defaultConfig();
        }

        switch (errorConfig.getOnError()) {
            case STOP:
                execution.fail(e.getMessage());
                break;
            case CONTINUE:
                // 继续执行下一个节点
                List<WorkflowEdge> edges = definition.findOutgoingEdges(node.getId());
                if (!edges.isEmpty()) {
                    executeFromNode(execution, definition, edges.get(0).getTargetNodeId());
                }
                break;
            case FALLBACK:
                String fallbackNodeId = errorConfig.getFallbackNodeId();
                if (fallbackNodeId != null) {
                    executeFromNode(execution, definition, fallbackNodeId);
                } else {
                    execution.fail(e.getMessage());
                }
                break;
            default:
                execution.fail(e.getMessage());
        }
    }

    private boolean evaluateCondition(String condition, Map<String, Object> variables) {
        if (condition == null || condition.isEmpty()) {
            return true;
        }
        // 简单条件评估，实际项目中可使用表达式引擎
        // 这里只支持简单的变量比较
        try {
            if (condition.contains("==")) {
                String[] parts = condition.split("==");
                String varName = parts[0].trim();
                String expected = parts[1].trim().replace("\"", "").replace("'", "");
                Object actual = variables.get(varName);
                return expected.equals(String.valueOf(actual));
            }
            return true;
        } catch (Exception e) {
            log.warn("条件评估失败: condition={}", condition, e);
            return true;
        }
    }

    private String getStackTrace(Exception e) {
        StringBuilder sb = new StringBuilder();
        sb.append(e.toString()).append("\n");
        for (StackTraceElement element : e.getStackTrace()) {
            sb.append("\tat ").append(element.toString()).append("\n");
            if (sb.length() > 2000) {
                sb.append("...(truncated)");
                break;
            }
        }
        return sb.toString();
    }
}
