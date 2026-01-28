package com.novacloudedu.backend.domain.ai.service.workflow;

import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.infrastructure.workflow.NodeExecutorRegistry;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.ai.service.workflow.WorkflowExecutionContext.NodeExecutionStatus;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 工作流执行引擎
 * 负责解析工作流定义，按拓扑顺序执行节点，处理数据流转
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class WorkflowEngine {

    private final NodeExecutorRegistry executorRegistry;

    /**
     * 执行工作流
     */
    public WorkflowExecutionResult execute(Workflow workflow, Map<String, Object> input) {
        String executionId = UUID.randomUUID().toString();
        WorkflowExecutionContext context = new WorkflowExecutionContext(
                executionId,
                workflow.getId() != null ? workflow.getId().value() : null,
                workflow.getCreatorId() != null ? workflow.getCreatorId().value() : null,
                input
        );

        log.info("开始执行工作流: workflowId={}, executionId={}", workflow.getId(), executionId);

        try {
            WorkflowDefinition definition = workflow.getDefinition();
            if (definition == null) {
                throw new IllegalStateException("工作流定义为空");
            }

            // 构建节点图
            WorkflowGraph graph = buildGraph(definition);

            // 找到开始节点
            WorkflowNode startNode = findStartNode(definition.getNodes());
            if (startNode == null) {
                throw new IllegalStateException("未找到开始节点");
            }

            // 从开始节点执行
            executeFromNode(startNode.getId(), graph, context);

            // 检查执行结果
            if (context.getStatus() == WorkflowExecutionContext.ExecutionStatus.RUNNING) {
                context.markSuccess(context.getGlobalVariables());
            }

            log.info("工作流执行完成: workflowId={}, executionId={}, status={}, duration={}ms",
                    workflow.getId(), executionId, context.getStatus(), context.getDurationMs());

            return WorkflowExecutionResult.builder()
                    .executionId(executionId)
                    .workflowId(workflow.getId() != null ? workflow.getId().value() : null)
                    .status(context.getStatus().name())
                    .output(context.getOutput())
                    .logs(context.getExecutionLogs())
                    .durationMs(context.getDurationMs())
                    .build();

        } catch (Exception e) {
            log.error("工作流执行失败: workflowId={}, executionId={}, error={}",
                    workflow.getId(), executionId, e.getMessage(), e);

            context.markFailed(e.getMessage());

            return WorkflowExecutionResult.builder()
                    .executionId(executionId)
                    .workflowId(workflow.getId() != null ? workflow.getId().value() : null)
                    .status("FAILED")
                    .errorMessage(e.getMessage())
                    .logs(context.getExecutionLogs())
                    .durationMs(context.getDurationMs())
                    .build();
        }
    }

    /**
     * 从指定节点开始执行
     */
    private void executeFromNode(String nodeId, WorkflowGraph graph, WorkflowExecutionContext context) {
        if (nodeId == null || context.isNodeExecuted(nodeId)) {
            return;
        }

        WorkflowNode node = graph.getNode(nodeId);
        if (node == null) {
            log.warn("节点不存在: {}", nodeId);
            return;
        }

        // 检查所有前置节点是否已执行
        List<String> predecessors = graph.getPredecessors(nodeId);
        for (String predId : predecessors) {
            if (!context.isNodeExecuted(predId)) {
                // 前置节点未执行，先执行前置节点
                executeFromNode(predId, graph, context);
            }
        }

        // 执行当前节点
        executeNode(node, graph, context);

        // 如果执行失败，停止
        if (context.getStatus() == WorkflowExecutionContext.ExecutionStatus.FAILED) {
            return;
        }

        // 获取下一个节点
        List<String> nextNodes = determineNextNodes(node, graph, context);

        // 执行后续节点
        for (String nextNodeId : nextNodes) {
            executeFromNode(nextNodeId, graph, context);
        }
    }

    /**
     * 执行单个节点
     */
    private void executeNode(WorkflowNode node, WorkflowGraph graph, WorkflowExecutionContext context) {
        String nodeId = node.getId();
        NodeType nodeType = node.getType();

        log.debug("执行节点: id={}, type={}, name={}", nodeId, nodeType, node.getName());
        context.updateNodeStatus(nodeId, NodeExecutionStatus.RUNNING);
        context.logInfo(nodeId, "开始执行节点: " + node.getName());

        long startTime = System.currentTimeMillis();

        try {
            // 特殊处理循环节点
            if (nodeType == NodeType.LOOP) {
                executeLoopNode(node, graph, context);
                return;
            }

            // 获取节点执行器
            NodeExecutor executor = executorRegistry.getExecutorOrThrow(nodeType);

            // 准备输入数据（合并上下文变量和节点输出）
            Map<String, Object> input = new HashMap<>(context.getAllVariables());
            input.putAll(context.getInput());

            // 执行节点 - 使用新的接口签名
            Map<String, Object> output = executor.execute(node, input, null);

            long durationMs = System.currentTimeMillis() - startTime;

            // 保存节点输出到上下文
            context.saveNodeOutput(nodeId, output);
            context.updateNodeStatus(nodeId, NodeExecutionStatus.SUCCESS);
            context.logInfo(nodeId, "节点执行成功，耗时: " + durationMs + "ms");

            // 如果节点输出指定了下一个节点（如条件分支），记录下来
            if (output != null && output.containsKey("_nextNodeId")) {
                context.setVariable("_nextNodeId_" + nodeId, output.get("_nextNodeId"));
            }

        } catch (Exception e) {
            log.error("节点执行异常: nodeId={}, error={}", nodeId, e.getMessage(), e);
            handleNodeError(node, e.getMessage(), context);
        }
    }

    /**
     * 执行循环节点
     */
    @SuppressWarnings("unchecked")
    private void executeLoopNode(WorkflowNode node, WorkflowGraph graph, WorkflowExecutionContext context) {
        Map<String, Object> config = node.getConfig();
        String loopType = (String) config.getOrDefault("loopType", "FOR_EACH");
        String itemVariable = (String) config.get("itemVariable");
        String indexVariable = (String) config.getOrDefault("indexVariable", "index");
        String loopBodyStartNodeId = (String) config.get("loopBodyStartNodeId");
        String resultVariable = (String) config.get("resultVariable");
        Integer maxIterations = getInteger(config, "maxIterations", 100);

        // 进入循环上下文
        context.enterLoop(node.getId(), itemVariable, indexVariable);

        try {
            List<?> items = null;
            int loopCount = 0;

            switch (loopType) {
                case "FOR_EACH" -> {
                    String iterableVariable = (String) config.get("iterableVariable");
                    Object iterable = context.getVariable(iterableVariable);
                    if (iterable instanceof List) {
                        items = (List<?>) iterable;
                    } else if (iterable instanceof Collection) {
                        items = new ArrayList<>((Collection<?>) iterable);
                    }
                    loopCount = items != null ? items.size() : 0;
                }
                case "FOR_COUNT" -> {
                    loopCount = getInteger(config, "loopCount", 0);
                    items = new ArrayList<>();
                    for (int i = 0; i < loopCount; i++) {
                        ((List<Object>) items).add(i);
                    }
                }
                case "WHILE" -> {
                    // WHILE循环在每次迭代时检查条件
                    loopCount = maxIterations;
                }
            }

            List<Object> results = new ArrayList<>();
            int actualIterations = 0;

            for (int i = 0; i < Math.min(loopCount, maxIterations); i++) {
                // WHILE循环检查条件
                if ("WHILE".equals(loopType)) {
                    String whileCondition = (String) config.get("whileCondition");
                    if (!evaluateCondition(whileCondition, context)) {
                        break;
                    }
                }

                // 设置当前迭代
                Object currentItem = items != null && i < items.size() ? items.get(i) : i;
                context.setLoopIteration(currentItem, i);

                context.logInfo(node.getId(), "循环迭代 " + (i + 1) + "/" + loopCount);

                // 执行循环体
                if (loopBodyStartNodeId != null) {
                    executeFromNode(loopBodyStartNodeId, graph, context);
                }

                // 收集结果
                WorkflowExecutionContext.LoopContext loopContext = context.getCurrentLoopContext();
                if (loopContext != null && !loopContext.getResults().isEmpty()) {
                    results.addAll(loopContext.getResults());
                    loopContext.getResults().clear();
                }

                actualIterations++;

                // 检查是否执行失败
                if (context.getStatus() == WorkflowExecutionContext.ExecutionStatus.FAILED) {
                    break;
                }
            }

            // 保存循环结果
            if (resultVariable != null) {
                context.setVariable(resultVariable, results);
            }

            context.updateNodeStatus(node.getId(), NodeExecutionStatus.SUCCESS);
            context.logInfo(node.getId(), "循环完成，共执行 " + actualIterations + " 次迭代");

        } finally {
            // 退出循环上下文
            context.exitLoop();
        }
    }

    /**
     * 确定下一个要执行的节点
     */
    private List<String> determineNextNodes(WorkflowNode node, WorkflowGraph graph, WorkflowExecutionContext context) {
        NodeType nodeType = node.getType();

        // 条件分支节点：根据执行结果确定下一个节点
        if (nodeType == NodeType.CONDITION || nodeType == NodeType.SWITCH) {
            String nextNodeId = (String) context.getVariable("_nextNodeId_" + node.getId());
            if (nextNodeId != null) {
                return List.of(nextNodeId);
            }
        }

        // 结束节点：没有后续节点
        if (nodeType == NodeType.END || nodeType == NodeType.RESPONSE) {
            return List.of();
        }

        // 普通节点：返回所有后继节点
        return graph.getSuccessors(node.getId());
    }

    /**
     * 处理节点执行错误
     */
    private void handleNodeError(WorkflowNode node, String errorMessage, WorkflowExecutionContext context) {
        WorkflowNode.ErrorHandlingConfig errorHandling = node.getErrorHandling();

        if (errorHandling != null) {
            ErrorHandlingStrategy strategy = errorHandling.getOnError();
            if (strategy == null) {
                strategy = ErrorHandlingStrategy.STOP;
            }

            switch (strategy) {
                case CONTINUE -> {
                    context.updateNodeStatus(node.getId(), NodeExecutionStatus.SKIPPED);
                    context.logInfo(node.getId(), "节点执行失败，已忽略: " + errorMessage);
                }
                case RETRY -> {
                    int maxRetries = errorHandling.getRetryCount();
                    // TODO: 实现重试逻辑
                    context.updateNodeStatus(node.getId(), NodeExecutionStatus.FAILED);
                    context.markFailed("节点执行失败（重试未实现）: " + errorMessage);
                }
                case FALLBACK -> {
                    String fallbackNodeId = errorHandling.getFallbackNodeId();
                    if (fallbackNodeId != null) {
                        context.setVariable("_nextNodeId_" + node.getId(), fallbackNodeId);
                        context.updateNodeStatus(node.getId(), NodeExecutionStatus.SKIPPED);
                        context.logInfo(node.getId(), "节点执行失败，跳转到备用节点: " + fallbackNodeId);
                    }
                }
                default -> {
                    context.updateNodeStatus(node.getId(), NodeExecutionStatus.FAILED);
                    context.markFailed("节点执行失败: " + errorMessage);
                    context.logError(node.getId(), "节点执行失败: " + errorMessage);
                }
            }
        } else {
            context.updateNodeStatus(node.getId(), NodeExecutionStatus.FAILED);
            context.markFailed("节点执行失败: " + errorMessage);
            context.logError(node.getId(), "节点执行失败: " + errorMessage);
        }
    }

    /**
     * 构建工作流图
     */
    private WorkflowGraph buildGraph(WorkflowDefinition definition) {
        WorkflowGraph graph = new WorkflowGraph();

        // 添加所有节点
        for (WorkflowNode node : definition.getNodes()) {
            graph.addNode(node);
        }

        // 添加所有边
        for (WorkflowEdge edge : definition.getEdges()) {
            graph.addEdge(edge);
        }

        return graph;
    }

    /**
     * 找到开始节点
     */
    private WorkflowNode findStartNode(List<WorkflowNode> nodes) {
        return nodes.stream()
                .filter(n -> n.getType() == NodeType.START)
                .findFirst()
                .orElse(null);
    }

    /**
     * 评估条件表达式
     */
    private boolean evaluateCondition(String condition, WorkflowExecutionContext context) {
        if (condition == null || condition.isBlank()) {
            return false;
        }
        // 简单实现：替换变量后求值
        String resolved = context.resolveTemplate(condition);
        // TODO: 使用SpEL或其他表达式引擎
        return Boolean.parseBoolean(resolved);
    }

    private Integer getInteger(Map<String, Object> config, String key, int defaultValue) {
        Object value = config.get(key);
        if (value == null) return defaultValue;
        if (value instanceof Number) return ((Number) value).intValue();
        return defaultValue;
    }

    /**
     * 工作流图结构
     */
    private static class WorkflowGraph {
        private final Map<String, WorkflowNode> nodes = new HashMap<>();
        private final Map<String, List<WorkflowEdge>> outgoingEdges = new HashMap<>();
        private final Map<String, List<WorkflowEdge>> incomingEdges = new HashMap<>();

        void addNode(WorkflowNode node) {
            nodes.put(node.getId(), node);
            outgoingEdges.putIfAbsent(node.getId(), new ArrayList<>());
            incomingEdges.putIfAbsent(node.getId(), new ArrayList<>());
        }

        void addEdge(WorkflowEdge edge) {
            outgoingEdges.computeIfAbsent(edge.getSourceNodeId(), k -> new ArrayList<>()).add(edge);
            incomingEdges.computeIfAbsent(edge.getTargetNodeId(), k -> new ArrayList<>()).add(edge);
        }

        WorkflowNode getNode(String nodeId) {
            return nodes.get(nodeId);
        }

        List<String> getSuccessors(String nodeId) {
            return outgoingEdges.getOrDefault(nodeId, List.of()).stream()
                    .map(WorkflowEdge::getTargetNodeId)
                    .collect(Collectors.toList());
        }

        List<String> getPredecessors(String nodeId) {
            return incomingEdges.getOrDefault(nodeId, List.of()).stream()
                    .map(WorkflowEdge::getSourceNodeId)
                    .collect(Collectors.toList());
        }
    }
}
