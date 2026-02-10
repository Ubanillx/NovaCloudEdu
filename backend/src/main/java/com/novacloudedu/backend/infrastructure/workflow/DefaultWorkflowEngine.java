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
 *
 * <h3>整体执行流程</h3>
 * <pre>
 * 1. execute() / executeAsync() 入口：
 *    a. 校验工作流是否已发布
 *    b. 创建 WorkflowExecution 实体，状态 PENDING
 *    c. 深拷贝并展平工作流定义（flattenChildren）—— 将嵌套在 LOOP/PARALLEL 容器内的子节点和边提升到顶层
 *    d. 校验定义（validateDefinition）
 *    e. 设置超时截止时间 (deadlineMs)
 *    f. 初始化变量（定义默认值 + 输入覆盖）
 *    g. 找到 START 节点，调用 executeFromNode() 开始执行
 *    h. 完成/失败/超时 → 更新执行状态
 *
 * 2. executeFromNode() 核心循环（已从递归改为迭代，避免栈溢出）：
 *    while (nodeId != null):
 *      a. 检查执行状态、超时、节点执行次数上限
 *      b. 检查断点，命中则暂停
 *      c. 创建 NodeExecution 记录
 *      d. 根据节点类型分派：
 *         - LOOP  + 有子节点 → executeLoopContainer()
 *         - PARALLEL          → executeParallelContainer()
 *         - CONDITION/SWITCH  → 执行后根据 output.branch 匹配出边
 *         - 普通节点           → 执行后走第一条满足条件的出边
 *      e. 设置 nextNodeId，继续 while 循环
 *      f. 异常 → handleNodeError() 处理（STOP/CONTINUE/FALLBACK）
 *
 * 3. executeLoopContainer() 循环容器：
 *    - 通过 sourceHandle="loop-start" 的边找到循环体入口节点
 *    - 根据 loopType (FOR_EACH/FOR_COUNT/WHILE) 执行迭代
 *    - 每次迭代调用 executeFromNode(入口节点)，循环体内节点走到 LOOP_END 或无出边时结束
 *    - 支持 _loopBreak 变量提前跳出循环
 *    - 迭代失败时记录 loopError 并终止循环
 *
 * 4. executeParallelContainer() 并行容器：
 *    - 为每个分支创建独立的 WorkflowExecution 副本 (forkForBranch)
 *    - 用 CompletableFuture + 线程池并行执行
 *    - 根据 waitStrategy (ALL/ANY/N_OF_M) 等待分支完成
 *    - 根据 mergeStrategy (OBJECT/ARRAY/FIRST/LAST) 合并结果
 *    - 取消/超时时通过 cancelBranchExecutions() 标记分支状态并中断 Future
 * </pre>
 *
 * <h3>错误处理策略 (handleNodeError)</h3>
 * <ul>
 *   <li>STOP     : 标记执行失败，终止工作流</li>
 *   <li>CONTINUE : 跳过当前节点，走下一条出边继续（条件/分支节点优先走 default 边）</li>
 *   <li>FALLBACK : 跳转到指定的 fallbackNodeId（不存在则失败）</li>
 * </ul>
 *
 * <h3>线程安全</h3>
 * <ul>
 *   <li>runningExecutions: ConcurrentHashMap 保证并发访问安全</li>
 *   <li>WorkflowExecution.variables: ConcurrentHashMap</li>
 *   <li>WorkflowExecution.status: volatile 保证可见性</li>
 *   <li>并行分支使用独立变量快照，通过 parentExecution 感知父执行取消</li>
 *   <li>nodeExecutionCount: AtomicInteger，并行分支共享父计数器</li>
 * </ul>
 */
@Slf4j
@Service
public class DefaultWorkflowEngine implements WorkflowEngine {

    private final Map<NodeType, NodeExecutor> executors = new HashMap<>();
    private final Map<String, WorkflowExecution> runningExecutions = new ConcurrentHashMap<>();
    private final Map<String, Set<String>> breakpoints = new ConcurrentHashMap<>();
    private final WorkflowLogService logService;
    private final com.novacloudedu.backend.domain.ai.repository.WorkflowExecutionRepository executionRepository;
    
    private ExecutorService workflowExecutor;

    public DefaultWorkflowEngine(WorkflowLogService logService, List<NodeExecutor> nodeExecutors,
                                 com.novacloudedu.backend.domain.ai.repository.WorkflowExecutionRepository executionRepository) {
        this.logService = logService;
        this.executionRepository = executionRepository;
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
            
            // 深拷贝并展平定义，使循环容器的子节点/内部边可被引擎直接访问
            WorkflowDefinition definition = workflow.getDefinition().copy();
            definition.flattenChildren();
            log.info("工作流定义展平完成: 节点数={}, 边数={}", definition.getNodes().size(), definition.getEdges().size());
            
            // 执行前校验
            validateDefinition(definition);

            // 设置执行超时截止时间（使用工作流定义的设置）
            long maxTimeMs = definition.getSettings().getMaxExecutionTimeMs();
            if (maxTimeMs > 0) {
                execution.setDeadlineMs(System.currentTimeMillis() + maxTimeMs);
            }

            // 初始化变量
            initializeVariables(execution, definition, input);
            
            // 找到开始节点
            WorkflowNode startNode = definition.findStartNode();
            if (startNode == null) {
                throw new IllegalStateException("工作流缺少开始节点");
            }

            // 执行工作流
            executeFromNode(execution, definition, startNode.getId());

            // 仅当执行仍处于 RUNNING 状态才标记为完成
            // （handleNodeError STOP 会设为 FAILED，断点会设为 PAUSED，取消会设为 CANCELLED）
            if (execution.getStatus() == ExecutionStatus.RUNNING) {
                execution.complete(execution.getVariables());
                log.info("工作流执行完成: executionId={}, duration={}ms", 
                        execution.getId().value(), execution.getDurationMs());
            } else {
                log.info("工作流执行结束(非正常完成): executionId={}, status={}, duration={}ms",
                        execution.getId().value(), execution.getStatus(), execution.getDurationMs());
            }

        } catch (Exception e) {
            log.error("工作流执行失败: executionId={}", execution.getId().value(), e);
            execution.fail(e.getMessage());
        } finally {
            runningExecutions.remove(execution.getId().value());
            try {
                executionRepository.save(execution);
                log.info("执行记录已保存: executionId={}, status={}", execution.getId().value(), execution.getStatus());
            } catch (Exception e) {
                log.error("保存执行记录失败: executionId={}", execution.getId().value(), e);
            }
        }

        return execution;
    }

    @SuppressWarnings("unchecked")
    private void validateDefinition(WorkflowDefinition definition) {
        List<String> warnings = new ArrayList<>();

        for (WorkflowNode node : definition.getNodes()) {
            if (node.getType() == NodeType.PARALLEL) {
                Map<String, Object> cfg = node.getConfig() != null ? node.getConfig() : Map.of();
                List<Map<String, Object>> branches = (List<Map<String, Object>>) cfg.get("branches");
                boolean hasValidBranch = false;
                if (branches != null) {
                    for (Map<String, Object> b : branches) {
                        String sid = (String) b.get("startNodeId");
                        if (sid != null && !sid.isBlank()) {
                            hasValidBranch = true;
                            // 检查引用的入口节点是否存在
                            if (definition.findNodeById(sid) == null) {
                                warnings.add(String.format("并行节点[%s]的分支入口节点[%s]在工作流中不存在",
                                        node.getName(), sid));
                            }
                            break;
                        }
                    }
                }
                if (!hasValidBranch) {
                    warnings.add(String.format("并行节点[%s]未配置有效分支（branches 为空或缺少入口节点），" +
                            "该节点将被跳过。请在配置面板中添加分支并选择入口节点。", node.getName()));
                }
            }

            // 校验 LOOP 节点：检查是否有 loop-start 出边连接子节点
            if (node.getType() == NodeType.LOOP && node.getChildren() != null
                    && node.getChildren().getNodes() != null && !node.getChildren().getNodes().isEmpty()) {
                boolean hasLoopStartEdge = false;
                for (WorkflowEdge edge : definition.findOutgoingEdges(node.getId())) {
                    if ("loop-start".equals(edge.getSourceHandle())) {
                        hasLoopStartEdge = true;
                        if (definition.findNodeById(edge.getTargetNodeId()) == null) {
                            warnings.add(String.format("循环节点[%s]的 loop-start 边指向的节点[%s]不存在",
                                    node.getName(), edge.getTargetNodeId()));
                        }
                        break;
                    }
                }
                if (!hasLoopStartEdge) {
                    warnings.add(String.format("循环节点[%s]有子节点但缺少 loop-start 连线，循环体将无法执行。" +
                            "请从循环节点的 loop-start 端口连接到循环体内的第一个节点。", node.getName()));
                }
                boolean hasOutputEdge = false;
                for (WorkflowEdge edge : definition.findOutgoingEdges(node.getId())) {
                    if ("output".equals(edge.getSourceHandle())) {
                        hasOutputEdge = true;
                        break;
                    }
                }
                if (!hasOutputEdge) {
                    warnings.add(String.format("循环节点[%s]缺少 output 出边，循环完成后后续节点将不会执行。" +
                            "请从循环节点的 output 端口连接到后续节点。", node.getName()));
                }
            }
        }

        if (!warnings.isEmpty()) {
            for (String w : warnings) {
                log.warn("工作流校验警告: {}", w);
            }
        }
    }

    @Override
    public WorkflowExecutionId executeAsync(Workflow workflow, Map<String, Object> input, UserId userId) {
        if (!workflow.canExecute()) {
            throw new IllegalStateException("工作流未发布，无法执行");
        }

        WorkflowExecution execution = WorkflowExecution.create(workflow, input, userId);
        runningExecutions.put(execution.getId().value(), execution);

        workflowExecutor.submit(() -> {
            try {
                execution.start();

                // 深拷贝并展平定义
                WorkflowDefinition definition = workflow.getDefinition().copy();
                definition.flattenChildren();

                validateDefinition(definition);

                // 设置执行超时截止时间（使用工作流定义的设置）
                long maxTimeMs = definition.getSettings().getMaxExecutionTimeMs();
                if (maxTimeMs > 0) {
                    execution.setDeadlineMs(System.currentTimeMillis() + maxTimeMs);
                }

                initializeVariables(execution, definition, input);

                WorkflowNode startNode = definition.findStartNode();
                if (startNode == null) {
                    throw new IllegalStateException("工作流缺少开始节点");
                }

                executeFromNode(execution, definition, startNode.getId());

                // 仅当执行仍处于 RUNNING 状态才标记为完成
                if (execution.getStatus() == ExecutionStatus.RUNNING) {
                    execution.complete(execution.getVariables());
                    log.info("异步工作流执行完成: executionId={}, duration={}ms",
                            execution.getId().value(), execution.getDurationMs());
                } else {
                    log.info("异步工作流执行结束(非正常完成): executionId={}, status={}, duration={}ms",
                            execution.getId().value(), execution.getStatus(), execution.getDurationMs());
                }
            } catch (Exception e) {
                log.error("异步工作流执行失败: executionId={}", execution.getId().value(), e);
                execution.fail(e.getMessage());
            } finally {
                runningExecutions.remove(execution.getId().value());
                try {
                    executionRepository.save(execution);
                    log.info("异步执行记录已保存: executionId={}, status={}", execution.getId().value(), execution.getStatus());
                } catch (Exception e2) {
                    log.error("保存异步执行记录失败: executionId={}", execution.getId().value(), e2);
                }
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

    /**
     * 核心节点执行循环 — 从指定节点开始沿着出边链路逐节点执行。
     *
     * <p>已从递归改为 while 循环（Fix #9），避免长链路工作流栈溢出。
     * 循环容器迭代体、并行分支和错误处理路径仍保持递归（深度有限且非尾调用）。</p>
     *
     * <p>每次迭代的处理流程：</p>
     * <ol>
     *   <li>检查执行状态、超时、节点执行次数上限、父执行状态</li>
     *   <li>查找节点、检查断点</li>
     *   <li>创建 NodeExecution 记录，记录开始日志</li>
     *   <li>根据节点类型分派执行（LOOP容器 / PARALLEL容器 / 普通节点）</li>
     *   <li>将节点输出写入 execution.variables</li>
     *   <li>根据节点类型路由出边：
     *       - CONDITION/SWITCH: 用 output.branch/matchedBranch 匹配 sourceHandle
     *       - LOOP容器: 走 sourceHandle="output" 的边
     *       - PARALLEL容器: 走普通出边
     *       - 普通节点: 走第一条满足条件的出边
     *   </li>
     *   <li>异常 → handleNodeError() 处理后终止 while 循环</li>
     * </ol>
     *
     * @param execution  当前执行上下文
     * @param definition 展平后的工作流定义
     * @param nodeId     起始节点 ID
     */
    private void executeFromNode(WorkflowExecution execution, WorkflowDefinition definition, String nodeId) {
        executeFromNode(execution, definition, nodeId, null);
    }

    /**
     * 核心节点执行循环（带边界节点支持）。
     * @param stopNodeIds 边界节点集合——到达这些节点时立即停止（用于并行分支在汇合点前停下），null 或空表示不限制
     */
    private void executeFromNode(WorkflowExecution execution, WorkflowDefinition definition, String nodeId, Set<String> stopNodeIds) {
        while (nodeId != null) {
            // 到达边界节点（并行分支汇合点），停止当前链路执行
            if (stopNodeIds != null && stopNodeIds.contains(nodeId)) {
                log.info("到达分支边界节点, 停止当前链路执行: nodeId={}", nodeId);
                return;
            }

            if (execution.getStatus() != ExecutionStatus.RUNNING) {
                return;
            }

            // Fix #4/#5: 检查全局超时和节点执行次数上限
            execution.checkExecutionLimits();

            WorkflowNode node = definition.findNodeById(nodeId);
            if (node == null) {
                log.warn("节点未找到，跳过执行: nodeId={}", nodeId);
                return;
            }
            log.info("开始执行节点: id={}, name={}, type={}", nodeId, node.getName(), node.getType());

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

            // 下一个要执行的节点ID，null 表示链路结束
            String nextNodeId = null;

            try {
                // 记录节点开始日志
                logService.logNodeStart(execution.getId(), execution.getWorkflowId(), 
                        execution.getWorkflowName(), node, execution.getVariables(), execution.getUserId());

                long startTime = System.currentTimeMillis();
                nodeExecution.start(new HashMap<>(execution.getVariables()));

                // ===== 循环容器：特殊处理 =====
                if (node.getType() == NodeType.LOOP && node.getChildren() != null
                        && node.getChildren().getNodes() != null && !node.getChildren().getNodes().isEmpty()) {

                    Map<String, Object> loopOutput = executeLoopContainer(execution, definition, node);
                    long duration = System.currentTimeMillis() - startTime;
                    nodeExecution.complete(loopOutput);

                    if (loopOutput != null) {
                        for (Map.Entry<String, Object> entry : loopOutput.entrySet()) {
                            execution.setVariable(entry.getKey(), entry.getValue());
                        }
                    }

                    logService.logNodeComplete(execution.getId(), execution.getWorkflowId(),
                            execution.getWorkflowName(), node, loopOutput, duration, execution.getUserId());

                    // 走 "output" handle 的边继续后续节点
                    for (WorkflowEdge edge : definition.findOutgoingEdges(nodeId)) {
                        if ("output".equals(edge.getSourceHandle())) {
                            if (evaluateCondition(edge.getCondition(), execution.getVariables())) {
                                nextNodeId = edge.getTargetNodeId();
                                break;
                            }
                        }
                    }
                    if (nextNodeId == null) {
                        log.warn("循环容器[{}]没有匹配的output出边，后续节点不会执行。请检查是否缺少从循环节点引出的连线(sourceHandle=output)", node.getName());
                    }
                    nodeId = nextNodeId;
                    continue;
                }

                // ===== 并行容器：特殊处理 =====
                if (node.getType() == NodeType.PARALLEL) {
                    Map<String, Object> parallelOutput = executeParallelContainer(execution, definition, node);
                    long duration = System.currentTimeMillis() - startTime;
                    nodeExecution.complete(parallelOutput);

                    if (parallelOutput != null) {
                        for (Map.Entry<String, Object> entry : parallelOutput.entrySet()) {
                            if (!entry.getKey().startsWith("_")) {
                                execution.setVariable(entry.getKey(), entry.getValue());
                            }
                        }
                    }

                    logService.logNodeComplete(execution.getId(), execution.getWorkflowId(),
                            execution.getWorkflowName(), node, parallelOutput, duration, execution.getUserId());

                    // 并行完成后，从汇合节点继续执行（汇合节点 = 多个分支共同可达的第一个节点）
                    String parallelConvergenceId = parallelOutput != null ?
                            (String) parallelOutput.get("_parallelConvergenceNodeId") : null;
                    if (parallelConvergenceId != null) {
                        nextNodeId = parallelConvergenceId;
                        log.info("并行容器[{}]完成, 从汇合节点继续: {}", node.getName(), parallelConvergenceId);
                    } else {
                        // 没有汇合节点，尝试走非分支入口的出边
                        Set<String> parallelBranchEntryIds = new HashSet<>();
                        @SuppressWarnings("unchecked")
                        List<Map<String, Object>> pBranches = (List<Map<String, Object>>)
                                (node.getConfig() != null ? node.getConfig() : Map.of()).get("branches");
                        if (pBranches != null) {
                            for (Map<String, Object> pb : pBranches) {
                                String sid = (String) pb.get("startNodeId");
                                if (sid != null && !sid.isBlank()) parallelBranchEntryIds.add(sid);
                            }
                        }
                        for (WorkflowEdge edge : definition.findOutgoingEdges(nodeId)) {
                            if (parallelBranchEntryIds.contains(edge.getTargetNodeId())) continue;
                            if (evaluateCondition(edge.getCondition(), execution.getVariables())) {
                                nextNodeId = edge.getTargetNodeId();
                                break;
                            }
                        }
                        if (nextNodeId == null) {
                            log.info("并行容器[{}]无后续节点", node.getName());
                        }
                    }
                    nodeId = nextNodeId;
                    continue;
                }

                // ===== 普通节点执行 =====
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
                log.info("节点[{}]出边数量: {}, 边列表: {}", node.getName(), outgoingEdges.size(),
                        outgoingEdges.stream().map(e -> e.getId() + "(" + e.getSourceHandle() + "->" + e.getTargetHandle() + " to " + e.getTargetNodeId() + ")").toList());

                // ===== 条件/多路分支/意图识别节点：根据 branch 输出匹配 sourceHandle =====
                if ((node.getType() == NodeType.CONDITION || node.getType() == NodeType.SWITCH || node.getType() == NodeType.INTENT_RECOGNITION) && output != null) {
                    String branch = (String) output.get("branch");           // "true" / "false"
                    String matchedBranch = (String) output.get("matchedBranch"); // 具体分支名 or "default"
                    log.info("条件/多路分支路由: branch={}, matchedBranch={}", branch, matchedBranch);

                    WorkflowEdge matchedEdge = null;
                    WorkflowEdge defaultEdge = null;

                    for (WorkflowEdge edge : outgoingEdges) {
                        if ("loop-end".equals(edge.getTargetHandle()) || "loop-start".equals(edge.getSourceHandle())) {
                            continue;
                        }
                        String sh = edge.getSourceHandle();

                        // 精确匹配: sourceHandle == branch ("true"/"false") 或 matchedBranch (分支名)
                        if (branch != null && branch.equals(sh)) {
                            matchedEdge = edge;
                            break;
                        }
                        if (matchedBranch != null && matchedBranch.equals(sh)) {
                            matchedEdge = edge;
                            break;
                        }
                        // 默认边 (sourceHandle 为空): 当 branch == "true" 时视为 true 分支
                        if (sh == null || sh.isBlank()) {
                            if ("true".equals(branch)) {
                                matchedEdge = edge;
                                break;
                            }
                            defaultEdge = edge; // 保留作为最终 fallback
                        }
                        // "default" handle 用于无匹配分支
                        if ("default".equals(sh)) {
                            defaultEdge = edge;
                        }
                    }

                    // fallback: 如果没有精确匹配的边，走 default 边
                    if (matchedEdge == null) {
                        matchedEdge = defaultEdge;
                    }

                    if (matchedEdge != null) {
                        log.info("条件分支选中边: {} -> {}", matchedEdge.getSourceHandle(), matchedEdge.getTargetNodeId());
                        nextNodeId = matchedEdge.getTargetNodeId();
                    } else {
                        String msg = String.format("条件/多路分支节点[%s]无匹配出边(branch=%s, matchedBranch=%s)，" +
                                "请检查是否缺少默认分支(default)连线", node.getName(), branch, matchedBranch);
                        log.error(msg);
                        throw new IllegalStateException(msg);
                    }
                } else {
                    // ===== 普通节点：按原逻辑遍历 =====
                    for (WorkflowEdge edge : outgoingEdges) {
                        if ("loop-end".equals(edge.getTargetHandle())) {
                            continue;
                        }
                        if ("loop-start".equals(edge.getSourceHandle())) {
                            continue;
                        }
                        if (evaluateCondition(edge.getCondition(), execution.getVariables())) {
                            nextNodeId = edge.getTargetNodeId();
                            break;
                        }
                    }
                }

                nodeId = nextNodeId;

            } catch (Exception e) {
                nodeExecution.fail(e.getMessage());
                logService.logNodeError(execution.getId(), execution.getWorkflowId(),
                        execution.getWorkflowName(), node, e.getMessage(), 
                        getStackTrace(e), execution.getUserId());
                
                // 错误处理（可能递归调用 executeFromNode，但仅限于 FALLBACK 路径，深度有限）
                handleNodeError(execution, definition, node, e);
                return;
            }
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

    /**
     * 循环容器执行器 — 当 LOOP 节点包含子节点时由 executeFromNode() 调用。
     *
     * <p>执行流程：</p>
     * <ol>
     *   <li>读取循环配置（loopType, itemVariable, indexVariable, maxIterations 等）</li>
     *   <li>通过 sourceHandle="loop-start" 的边找到循环体入口节点</li>
     *   <li>根据 loopType 执行迭代：
     *       - FOR_EACH: 遍历数组变量，每次设置 item/index 后执行循环体
     *       - FOR_COUNT: 指定次数循环，每次设置 counter/index
     *       - WHILE: 每次迭代前重新评估条件表达式</li>
     *   <li>每次迭代调用 executeFromNode(入口节点)，循环体内节点走到 LOOP_END 或无出边时结束</li>
     *   <li>支持 _loopBreak 变量提前跳出</li>
     *   <li>迭代失败时记录 loopError 并终止循环（不会抛异常，返回部分结果）</li>
     * </ol>
     *
     * @param execution  当前执行上下文
     * @param definition 展平后的工作流定义
     * @param loopNode   LOOP 容器节点
     * @return 循环执行结果（包含 resultVariable, loopCount, loopCompleted, loopError）
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object> executeLoopContainer(WorkflowExecution execution,
                                                      WorkflowDefinition definition,
                                                      WorkflowNode loopNode) {
        Map<String, Object> config = loopNode.getConfig() != null ? loopNode.getConfig() : new HashMap<>();
        String loopType = (String) config.getOrDefault("loopType", "FOR_EACH");
        if (loopType == null) loopType = "FOR_EACH";
        String itemVariable = (String) config.getOrDefault("itemVariable", "item");
        if (itemVariable == null || itemVariable.isBlank()) itemVariable = "item";
        String indexVariable = (String) config.getOrDefault("indexVariable", "index");
        if (indexVariable == null || indexVariable.isBlank()) indexVariable = "index";
        int maxIterations = getLoopInt(config, "maxIterations", 100);
        String resultVariable = (String) config.getOrDefault("resultVariable", "loopResults");
        if (resultVariable == null || resultVariable.isBlank()) resultVariable = "loopResults";

        // 校验 maxIterations（至少为 1，防止配置错误导致循环被禁用）
        if (maxIterations <= 0) {
            log.warn("循环容器[{}] maxIterations={} 无效，已修正为默认值100", loopNode.getName(), maxIterations);
            maxIterations = 100;
        }

        // 找到内部入口节点（通过 loop-start handle 连线）
        String entryNodeId = null;
        for (WorkflowEdge edge : definition.findOutgoingEdges(loopNode.getId())) {
            if ("loop-start".equals(edge.getSourceHandle())) {
                entryNodeId = edge.getTargetNodeId();
                break;
            }
        }

        if (entryNodeId == null) {
            log.warn("循环容器没有连接子节点: loopNodeId={}", loopNode.getId());
            Map<String, Object> empty = new HashMap<>();
            empty.put(resultVariable, new ArrayList<>());
            empty.put("loopCount", 0);
            empty.put("loopCompleted", true);
            return empty;
        }

        List<Map<String, Object>> results = new ArrayList<>();

        String loopError = null;
        switch (loopType.toUpperCase()) {
            case "FOR_EACH", "FOREACH" -> {
                String iterableVar = (String) config.getOrDefault("iterableVariable",
                        config.getOrDefault("itemsVariable", "items"));
                Object itemsObj = execution.getVariable(iterableVar);
                List<Object> items;
                if (itemsObj instanceof List) {
                    items = (List<Object>) itemsObj;
                } else {
                    items = new ArrayList<>();
                    if (itemsObj != null) {
                        log.warn("FOR_EACH 变量[{}]不是数组类型(实际类型={}), 视为空数组", iterableVar, itemsObj.getClass().getSimpleName());
                    } else {
                        log.warn("FOR_EACH 变量[{}]不存在或为null, 视为空数组", iterableVar);
                    }
                }

                log.info("循环容器(FOR_EACH): 数组变量={}, 元素数={}, 入口节点={}", iterableVar, items.size(), entryNodeId);

                int effectiveCount = Math.min(items.size(), maxIterations);
                if (items.size() > maxIterations) {
                    log.warn("循环容器(FOR_EACH)[{}]: 数组元素数({})超过maxIterations({})，将截断", loopNode.getName(), items.size(), maxIterations);
                }
                for (int i = 0; i < effectiveCount; i++) {
                    // 迭代间检查执行状态（取消/暂停/超时应立即停止）
                    if (execution.getStatus() != ExecutionStatus.RUNNING) {
                        log.info("循环容器(FOR_EACH)迭代中止: 执行状态={}, 已完成{}次迭代", execution.getStatus(), i);
                        break;
                    }
                    try {
                        // ConcurrentHashMap 不允许 null value，null 元素用空字符串替代避免变量被意外移除
                        Object item = items.get(i);
                        execution.setVariable(itemVariable, item != null ? item : "");
                        execution.setVariable(indexVariable, i);
                        executeFromNode(execution, definition, entryNodeId);
                        Map<String, Object> iterResult = new HashMap<>();
                        iterResult.put(itemVariable, item);
                        iterResult.put(indexVariable, i);
                        results.add(iterResult);
                        // Fix #9: 支持循环体内通过 _loopBreak 变量提前跳出
                        if (Boolean.TRUE.equals(execution.getVariable("_loopBreak"))) {
                            log.info("循环(FOR_EACH)收到break信号，在第{}次迭代后跳出", i);
                            execution.setVariable("_loopBreak", false);
                            break;
                        }
                    } catch (Exception e) {
                        log.error("循环迭代[{}]执行失败, 已收集{}个结果: {}", i, results.size(), e.getMessage());
                        loopError = String.format("循环第%d次迭代失败: %s", i, e.getMessage());
                        break;
                    }
                }
            }
            case "FOR_COUNT", "TIMES" -> {
                int loopCount = getLoopInt(config, "loopCount", getLoopInt(config, "times", 1));
                String counterVar = (String) config.getOrDefault("counterVariable", indexVariable);
                if (counterVar == null || counterVar.isBlank()) counterVar = indexVariable;

                if (loopCount <= 0) {
                    log.warn("循环容器(FOR_COUNT)[{}]: loopCount={} 无效，循环不会执行", loopNode.getName(), loopCount);
                }
                log.info("循环容器(FOR_COUNT): 次数={}, 入口节点={}", loopCount, entryNodeId);

                for (int i = 0; i < Math.min(loopCount, maxIterations); i++) {
                    // 迭代间检查执行状态
                    if (execution.getStatus() != ExecutionStatus.RUNNING) {
                        log.info("循环容器(FOR_COUNT)迭代中止: 执行状态={}, 已完成{}次迭代", execution.getStatus(), i);
                        break;
                    }
                    try {
                        execution.setVariable(counterVar, i);
                        execution.setVariable(indexVariable, i);
                        executeFromNode(execution, definition, entryNodeId);
                        Map<String, Object> iterResult = new HashMap<>();
                        iterResult.put(counterVar, i);
                        iterResult.put(indexVariable, i);
                        results.add(iterResult);
                        // Fix #9: 支持循环体内通过 _loopBreak 变量提前跳出
                        if (Boolean.TRUE.equals(execution.getVariable("_loopBreak"))) {
                            log.info("循环(FOR_COUNT)收到break信号，在第{}次迭代后跳出", i);
                            execution.setVariable("_loopBreak", false);
                            break;
                        }
                    } catch (Exception e) {
                        log.error("循环迭代[{}]执行失败, 已收集{}个结果: {}", i, results.size(), e.getMessage());
                        loopError = String.format("循环第%d次迭代失败: %s", i, e.getMessage());
                        break;
                    }
                }
            }
            case "WHILE" -> {
                String whileCondition = (String) config.getOrDefault("whileCondition", "false");
                log.info("循环容器(WHILE): 条件={}, 入口节点={}", whileCondition, entryNodeId);

                // 边界条件：空/null 条件视为 false，避免 evaluateCondition("") 返回 true 导致意外循环
                if (whileCondition == null || whileCondition.isBlank()) {
                    log.warn("循环容器(WHILE)[{}]: 条件为空，循环不会执行", loopNode.getName());
                    break;
                }

                for (int i = 0; i < maxIterations; i++) {
                    // 迭代间检查执行状态
                    if (execution.getStatus() != ExecutionStatus.RUNNING) {
                        log.info("循环容器(WHILE)迭代中止: 执行状态={}, 已完成{}次迭代", execution.getStatus(), i);
                        break;
                    }
                    boolean condResult = evaluateCondition(whileCondition, execution.getVariables());
                    log.debug("WHILE 迭代[{}]: 条件='{}', 结果={}", i, whileCondition, condResult);
                    if (!condResult) break;
                    try {
                        execution.setVariable(indexVariable, i);
                        executeFromNode(execution, definition, entryNodeId);
                        Map<String, Object> iterResult = new HashMap<>();
                        iterResult.put(indexVariable, i);
                        results.add(iterResult);
                        // Fix #9: 支持循环体内通过 _loopBreak 变量提前跳出
                        if (Boolean.TRUE.equals(execution.getVariable("_loopBreak"))) {
                            log.info("循环(WHILE)收到break信号，在第{}次迭代后跳出", i);
                            execution.setVariable("_loopBreak", false);
                            break;
                        }
                    } catch (Exception e) {
                        log.error("WHILE循环迭代[{}]执行失败, 已收集{}个结果: {}", i, results.size(), e.getMessage());
                        loopError = String.format("WHILE循环第%d次迭代失败: %s", i, e.getMessage());
                        break;
                    }
                }
            }
            default -> log.warn("未知的循环类型: {}", loopType);
        }

        // WHILE 循环达到 maxIterations 上限时发出警告
        if ("WHILE".equalsIgnoreCase(loopType) && results.size() >= maxIterations && loopError == null) {
            log.warn("循环容器(WHILE)[{}]: 达到最大迭代次数上限({})，循环被强制终止。如果这不是预期行为，请检查循环条件或增大 maxIterations",
                    loopNode.getName(), maxIterations);
        }

        Map<String, Object> output = new HashMap<>();
        output.put(resultVariable, results);
        output.put("loopCount", results.size());
        output.put("loopCompleted", loopError == null);
        if (loopError != null) {
            output.put("loopError", loopError);
            log.warn("循环容器部分完成: 已收集{}个结果, 错误={}", results.size(), loopError);
        }
        return output;
    }

    /**
     * 并行容器执行器 — 当 executeFromNode() 检测到 PARALLEL 节点时调用。
     *
     * <p>执行流程：</p>
     * <ol>
     *   <li>读取并行配置（branches, waitStrategy, timeout, failFast, mergeStrategy）</li>
     *   <li>为每个分支创建独立的 WorkflowExecution 副本 (forkForBranch)</li>
     *   <li>用 CompletableFuture + 线程池并行执行所有分支</li>
     *   <li>根据 waitStrategy 等待分支完成：
     *       - ALL:    等待所有分支
     *       - ANY:    任一分支完成后取消其余
     *       - N_OF_M: 等待指定数量的分支成功</li>
     *   <li>检查 failFast — 非 optional 分支失败时抛异常</li>
     *   <li>根据 mergeStrategy 合并结果（OBJECT/ARRAY/FIRST/LAST）</li>
     * </ol>
     *
     * <p>取消机制：通过 cancelBranchExecutions() 将分支执行状态标记为 CANCELLED，
     * 分支线程在下次 checkExecutionLimits() 时检测到父执行状态变化而终止。</p>
     *
     * @param execution    父执行上下文
     * @param definition   展平后的工作流定义
     * @param parallelNode PARALLEL 容器节点
     * @return 并行执行结果（包含合并后的分支数据 + parallelCount/parallelErrors/parallelCompleted）
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object> executeParallelContainer(WorkflowExecution execution,
                                                          WorkflowDefinition definition,
                                                          WorkflowNode parallelNode) {
        Map<String, Object> config = parallelNode.getConfig() != null ? parallelNode.getConfig() : new HashMap<>();
        String waitStrategy = (String) config.getOrDefault("waitStrategy", "ALL");
        if (waitStrategy == null) waitStrategy = "ALL";
        long timeout = getConfigLong(config, "timeout", 60000L);
        boolean failFast = Boolean.TRUE.equals(config.get("failFast"));
        String mergeStrategy = (String) config.getOrDefault("mergeStrategy", "OBJECT");
        if (mergeStrategy == null) mergeStrategy = "OBJECT";
        int requiredCount = getLoopInt(config, "requiredCount", 1);
        if (requiredCount <= 0) {
            log.warn("并行容器[{}] requiredCount={} 无效，已修正为1", parallelNode.getName(), requiredCount);
            requiredCount = 1;
        }

        // 收集分支入口：优先用 config.branches[].startNodeId，回退到出边
        List<Map<String, Object>> branchConfigs = (List<Map<String, Object>>) config.get("branches");
        List<String> branchEntryNodeIds = new ArrayList<>();
        List<String> branchNames = new ArrayList<>();
        List<String> branchResultVars = new ArrayList<>();

        List<Boolean> branchOptionals = new ArrayList<>();

        if (branchConfigs != null && !branchConfigs.isEmpty()) {
            for (Map<String, Object> bc : branchConfigs) {
                String startNodeId = (String) bc.get("startNodeId");
                if (startNodeId != null && !startNodeId.isBlank()) {
                    branchEntryNodeIds.add(startNodeId);
                    branchNames.add((String) bc.getOrDefault("name", "分支" + branchEntryNodeIds.size()));
                    branchResultVars.add((String) bc.getOrDefault("resultVariable", ""));
                    branchOptionals.add(Boolean.TRUE.equals(bc.get("optional")));
                }
            }
        }

        // 计算分支汇合节点：所有分支共同可达的节点（如 MERGE），分支在汇合处停止，主线程从汇合处继续
        final Set<String> convergenceStopNodes = computeParallelConvergenceNodes(definition, branchEntryNodeIds);
        final String firstConvergenceNodeId = convergenceStopNodes.isEmpty() ? null :
                findFirstConvergenceNode(definition, branchEntryNodeIds, convergenceStopNodes);
        if (firstConvergenceNodeId != null) {
            log.info("并行容器检测到汇合节点: first={}, all={}", firstConvergenceNodeId, convergenceStopNodes);
        }

        log.info("并行容器开始: nodeId={}, 分支数={}, waitStrategy={}, timeout={}ms, failFast={}",
                parallelNode.getId(), branchEntryNodeIds.size(), waitStrategy, timeout, failFast);

        // 没有配置有效分支 → 跳过并行，直接 pass-through
        if (branchEntryNodeIds.isEmpty()) {
            log.warn("并行容器没有配置有效分支(branches 为空或 startNodeId 未设置): nodeId={}, 跳过并行执行",
                    parallelNode.getId());
            return Map.of("parallelCount", 0, "parallelCompleted", true,
                    "_warning", "PARALLEL 节点未配置有效分支，请在配置面板中添加分支并选择入口节点");
        }

        // 捕获并行前的变量快照，用于差量合并（delta merge）
        final Map<String, Object> preParallelSnapshot = new HashMap<>(execution.getVariables());

        // 为每个分支创建独立的变量快照并执行
        Map<String, Map<String, Object>> branchResults = new ConcurrentHashMap<>();
        Map<String, Exception> branchErrors = new ConcurrentHashMap<>();

        // Fix #8: 为每个分支创建独立的 WorkflowExecution 副本，避免共享变量竞态
        List<CompletableFuture<Void>> futures = new ArrayList<>();
        Map<String, WorkflowExecution> branchExecutions = new ConcurrentHashMap<>();
        for (int i = 0; i < branchEntryNodeIds.size(); i++) {
            final String entryId = branchEntryNodeIds.get(i);
            final String bName = branchNames.get(i);

            // 为分支创建变量快照副本
            WorkflowExecution branchExecution = execution.forkForBranch();
            branchExecutions.put(bName, branchExecution);

            CompletableFuture<Void> future = CompletableFuture.runAsync(() -> {
                try {
                    log.info("并行分支[{}]开始: entryNode={}", bName, entryId);
                    executeFromNode(branchExecution, definition, entryId, convergenceStopNodes);
                    branchResults.put(bName, new HashMap<>(branchExecution.getVariables()));
                    log.info("并行分支[{}]完成", bName);
                } catch (Exception e) {
                    log.error("并行分支[{}]失败: {}", bName, e.getMessage());
                    branchErrors.put(bName, e);
                }
            }, workflowExecutor);

            futures.add(future);
        }

        // 等待策略
        try {
            switch (waitStrategy.toUpperCase()) {
                case "ALL" -> {
                    CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]))
                            .get(timeout, TimeUnit.MILLISECONDS);
                }
                case "ANY" -> {
                    // 等待第一个*成功*完成的分支（失败的分支不计入）
                    CountDownLatch anyLatch = new CountDownLatch(1);
                    // 当所有分支都完成（无论成败）时也应唤醒，避免全部失败时等待完整超时
                    CompletableFuture<Void> allDone = CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]));
                    allDone.thenRun(anyLatch::countDown);
                    for (int fi = 0; fi < futures.size(); fi++) {
                        final String bn = branchNames.get(fi);
                        futures.get(fi).thenRun(() -> {
                            if (!branchErrors.containsKey(bn)) {
                                anyLatch.countDown();
                            }
                        });
                    }
                    if (!anyLatch.await(timeout, TimeUnit.MILLISECONDS)) {
                        log.warn("并行容器 ANY 超时: 成功={}, 失败={}",
                                branchResults.size(), branchErrors.size());
                    }
                    cancelBranchExecutions(futures, branchExecutions);
                }
                case "N_OF_M" -> {
                    CountDownLatch latch = new CountDownLatch(Math.min(requiredCount, futures.size()));
                    // 当所有分支都完成时也应唤醒，避免成功数不足时等待完整超时
                    CompletableFuture<Void> allDoneNM = CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]));
                    allDoneNM.thenRun(() -> { while (latch.getCount() > 0) latch.countDown(); });
                    for (int fi = 0; fi < futures.size(); fi++) {
                        final String bn = branchNames.get(fi);
                        futures.get(fi).thenRun(() -> {
                            // 只有成功完成（无异常）的分支才计数
                            if (!branchErrors.containsKey(bn)) {
                                latch.countDown();
                            }
                        });
                    }
                    if (!latch.await(timeout, TimeUnit.MILLISECONDS)) {
                        log.warn("并行容器 N_OF_M 超时或成功数不足: 需要{}个成功完成, 当前成功={}, 失败={}",
                                requiredCount, branchResults.size(), branchErrors.size());
                    }
                    cancelBranchExecutions(futures, branchExecutions);
                }
                default -> {
                    CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]))
                            .get(timeout, TimeUnit.MILLISECONDS);
                }
            }
        } catch (TimeoutException e) {
            log.warn("并行容器超时: nodeId={}, timeout={}ms", parallelNode.getId(), timeout);
            cancelBranchExecutions(futures, branchExecutions);
        } catch (Exception e) {
            log.error("并行容器等待异常: {}", e.getMessage());
            if (failFast) {
                cancelBranchExecutions(futures, branchExecutions);
                throw new RuntimeException("并行执行失败(failFast): " + e.getMessage(), e);
            }
        }

        // 检查 failFast（可选分支的失败不触发 failFast）
        if (failFast && !branchErrors.isEmpty()) {
            for (Map.Entry<String, Exception> entry : branchErrors.entrySet()) {
                String failedBranch = entry.getKey();
                int idx = branchNames.indexOf(failedBranch);
                boolean isOptional = idx >= 0 && idx < branchOptionals.size() && branchOptionals.get(idx);
                if (!isOptional) {
                    throw new RuntimeException("并行分支[" + failedBranch + "]失败(failFast): " + entry.getValue().getMessage(), entry.getValue());
                }
                log.info("可选分支[{}]失败已忽略(optional=true): {}", failedBranch, entry.getValue().getMessage());
            }
        }

        // 合并结果
        Map<String, Object> output = new HashMap<>();
        switch (mergeStrategy.toUpperCase()) {
            case "OBJECT" -> {
                // 每个分支的 resultVariable 作为 key
                for (int i = 0; i < branchNames.size(); i++) {
                    String bName = branchNames.get(i);
                    String resVar = i < branchResultVars.size() ? branchResultVars.get(i) : "";
                    Map<String, Object> bResult = branchResults.getOrDefault(bName, new HashMap<>());
                    if (resVar != null && !resVar.isBlank()) {
                        output.put(resVar, bResult);
                    } else {
                        output.put(bName, bResult);
                    }
                }
            }
            case "ARRAY" -> {
                List<Map<String, Object>> list = new ArrayList<>();
                for (String bName : branchNames) {
                    list.add(branchResults.getOrDefault(bName, new HashMap<>()));
                }
                output.put("parallelResults", list);
            }
            case "FIRST" -> {
                // 按 branchNames 定义顺序取第一个有结果的分支，避免 ConcurrentHashMap 迭代顺序不确定
                for (String bName : branchNames) {
                    if (branchResults.containsKey(bName)) {
                        output.putAll(branchResults.get(bName));
                        break;
                    }
                }
            }
            case "LAST" -> {
                Map<String, Object> last = null;
                for (String bName : branchNames) {
                    if (branchResults.containsKey(bName)) last = branchResults.get(bName);
                }
                if (last != null) output.putAll(last);
            }
            default -> {
                for (Map<String, Object> bResult : branchResults.values()) {
                    output.putAll(bResult);
                }
            }
        }

        // ===== 差量合并（Delta Merge）：保证并行分支的变量修改累加写回全局上下文 =====
        // 数值类型：累加每个分支的变化量 (branch_value - snapshot_value)
        // 非数值类型：最后一个分支的值生效（last write wins）
        for (String bName : branchNames) {
            Map<String, Object> bResult = branchResults.getOrDefault(bName, new HashMap<>());
            for (Map.Entry<String, Object> e : bResult.entrySet()) {
                String key = e.getKey();
                if (key.startsWith("_")) continue;
                Object branchVal = e.getValue();
                Object snapshotVal = preParallelSnapshot.get(key);

                if (snapshotVal instanceof Number && branchVal instanceof Number) {
                    double delta = ((Number) branchVal).doubleValue() - ((Number) snapshotVal).doubleValue();
                    if (delta != 0.0) {
                        double current = output.containsKey(key) && output.get(key) instanceof Number
                                ? ((Number) output.get(key)).doubleValue()
                                : ((Number) snapshotVal).doubleValue();
                        output.put(key, current + delta);
                    } else if (!output.containsKey(key)) {
                        output.put(key, snapshotVal);
                    }
                } else if (!java.util.Objects.equals(branchVal, snapshotVal)) {
                    // 变量发生了非数值变更，最后分支覆盖
                    output.put(key, branchVal);
                }
            }
        }
        log.info("并行差量合并完成: snapshot.input={}, merged.input={}",
                preParallelSnapshot.get("input"), output.get("input"));

        output.put("parallelCount", branchResults.size());
        output.put("parallelErrors", branchErrors.size());
        output.put("parallelCompleted", branchErrors.isEmpty());
        if (firstConvergenceNodeId != null) {
            output.put("_parallelConvergenceNodeId", firstConvergenceNodeId);
        }

        log.info("并行容器完成: nodeId={}, 成功={}, 失败={}, mergeStrategy={}",
                parallelNode.getId(), branchResults.size(), branchErrors.size(), mergeStrategy);
        return output;
    }

    /**
     * 计算并行分支的汇合节点：从 2 个以上分支入口均可达的节点。
     * 这些节点是分支执行的"边界"——分支到达此处应停止，交由主线程继续。
     */
    private Set<String> computeParallelConvergenceNodes(WorkflowDefinition definition, List<String> branchEntryNodeIds) {
        if (branchEntryNodeIds.size() < 2) return Collections.emptySet();

        Map<String, Integer> reachCount = new HashMap<>();
        for (String entryId : branchEntryNodeIds) {
            Set<String> reachable = new HashSet<>();
            Queue<String> queue = new LinkedList<>();
            queue.add(entryId);
            while (!queue.isEmpty()) {
                String nid = queue.poll();
                if (!reachable.add(nid)) continue;
                for (WorkflowEdge edge : definition.findOutgoingEdges(nid)) {
                    queue.add(edge.getTargetNodeId());
                }
            }
            for (String nid : reachable) {
                reachCount.merge(nid, 1, Integer::sum);
            }
        }

        Set<String> entrySet = new HashSet<>(branchEntryNodeIds);
        Set<String> convergence = new HashSet<>();
        for (Map.Entry<String, Integer> entry : reachCount.entrySet()) {
            if (entry.getValue() >= 2 && !entrySet.contains(entry.getKey())) {
                convergence.add(entry.getKey());
            }
        }
        return convergence;
    }

    /**
     * 在汇合节点集合中找到拓扑序最前的节点（最先被任一分支到达的）。
     * 使用 BFS 从所有分支入口同时出发，第一个命中汇合集合的节点即为结果。
     */
    private String findFirstConvergenceNode(WorkflowDefinition definition, List<String> branchEntryNodeIds, Set<String> convergenceNodes) {
        Queue<String> queue = new LinkedList<>(branchEntryNodeIds);
        Set<String> visited = new HashSet<>(branchEntryNodeIds);
        while (!queue.isEmpty()) {
            String nid = queue.poll();
            for (WorkflowEdge edge : definition.findOutgoingEdges(nid)) {
                String target = edge.getTargetNodeId();
                if (convergenceNodes.contains(target)) {
                    return target;
                }
                if (visited.add(target)) {
                    queue.add(target);
                }
            }
        }
        // fallback: 返回集合中任意一个
        return convergenceNodes.iterator().next();
    }

    /**
     * 取消所有未完成的并行分支：标记分支执行状态为CANCELLED，使分支线程在下次checkExecutionLimits时终止。
     */
    private void cancelBranchExecutions(List<CompletableFuture<Void>> futures,
                                         Map<String, WorkflowExecution> branchExecutions) {
        for (WorkflowExecution branchExec : branchExecutions.values()) {
            if (branchExec.getStatus() == ExecutionStatus.RUNNING) {
                branchExec.cancel();
            }
        }
        futures.forEach(f -> f.cancel(true));
    }

    private long getConfigLong(Map<String, Object> config, String key, long defaultValue) {
        Object val = config.get(key);
        if (val instanceof Number) return ((Number) val).longValue();
        if (val instanceof String) { try { return Long.parseLong((String) val); } catch (NumberFormatException ignored) {} }
        return defaultValue;
    }

    private int getLoopInt(Map<String, Object> config, String key, int defaultValue) {
        Object val = config.get(key);
        if (val instanceof Number) return ((Number) val).intValue();
        if (val instanceof String) {
            try { return Integer.parseInt((String) val); } catch (NumberFormatException ignored) {}
        }
        return defaultValue;
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
            case LOOP_START:
            case LOOP_END:
                return new HashMap<>();
            default:
                log.warn("未找到节点执行器: nodeType={}", node.getType());
                return new HashMap<>();
        }
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> handleVariableSet(WorkflowNode node, WorkflowExecution execution) {
        Map<String, Object> config = node.getConfig();
        if (config == null) return new HashMap<>();

        Map<String, Object> output = new HashMap<>();

        // 新版：支持 variables 数组
        List<Map<String, Object>> variables = (List<Map<String, Object>>) config.get("variables");
        log.debug("VARIABLE_SET config keys: {}, variables count: {}", config.keySet(), 
                variables != null ? variables.size() : 0);
        if (variables != null && !variables.isEmpty()) {
            for (Map<String, Object> varItem : variables) {
                log.debug("varItem: {}", varItem);
                String name = (String) varItem.get("name");
                if (name == null || name.isBlank()) continue;

                String operation = (String) varItem.getOrDefault("operation", "overwrite");
                String sourceType = (String) varItem.getOrDefault("sourceType", "literal");
                Object rawValue = varItem.get("value");

                Object oldValue = execution.getVariable(name);

                // 解析值：算术运算始终用字面值；其他操作根据 sourceType 决定
                boolean isArithmetic = "add".equals(operation) || "subtract".equals(operation)
                        || "multiply".equals(operation) || "divide".equals(operation);
                Object resolvedValue;
                if (isArithmetic) {
                    resolvedValue = rawValue; // 算术操作的 value 总是字面数字
                } else if ("variable".equals(sourceType) && rawValue instanceof String) {
                    resolvedValue = execution.getVariable((String) rawValue);
                } else {
                    resolvedValue = rawValue;
                }

                applyVariableOperation(execution, name, operation, resolvedValue);

                Object newValue = execution.getVariable(name);
                output.put(name, newValue);
                log.info("变量赋值: name={}, operation={}, value={}, oldValue={} -> newValue={}", 
                        name, operation, resolvedValue, oldValue, newValue);
            }
        } else {
            // 旧版兼容：单个 variableName / value
            String varName = (String) config.get("variableName");
            Object varValue = config.get("value");
            if (varName != null) {
                execution.setVariable(varName, varValue);
                output.put(varName, varValue);
            }
        }
        return output;
    }

    private void applyVariableOperation(WorkflowExecution execution, String name, String operation, Object value) {
        switch (operation) {
            case "overwrite" -> execution.setVariable(name, value);
            case "clear" -> execution.setVariable(name, null);
            case "set" -> {
                // 仅在变量不存在时赋值
                if (execution.getVariable(name) == null) {
                    execution.setVariable(name, value);
                }
            }
            case "add" -> {
                double current = toDouble(execution.getVariable(name));
                execution.setVariable(name, current + toDouble(value));
            }
            case "subtract" -> {
                double current = toDouble(execution.getVariable(name));
                execution.setVariable(name, current - toDouble(value));
            }
            case "multiply" -> {
                double current = toDouble(execution.getVariable(name));
                execution.setVariable(name, current * toDouble(value));
            }
            case "divide" -> {
                double current = toDouble(execution.getVariable(name));
                double divisor = toDouble(value);
                execution.setVariable(name, divisor == 0 ? 0.0 : current / divisor);
            }
            default -> execution.setVariable(name, value);
        }
    }

    private double toDouble(Object obj) {
        if (obj instanceof Number) return ((Number) obj).doubleValue();
        if (obj instanceof String) {
            try { return Double.parseDouble((String) obj); } catch (NumberFormatException ignored) {}
        }
        return 0.0;
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

    /**
     * 节点执行错误处理 — 根据节点的错误处理配置决定后续行为。
     *
     * <p>策略：</p>
     * <ul>
     *   <li>STOP     : 标记执行失败，终止工作流</li>
     *   <li>CONTINUE : 跳过当前节点，继续执行下一个节点
     *       - 条件/分支节点优先走 default/false 边
     *       - 普通节点走第一条有效出边（跳过 loop-start/loop-end 边）</li>
     *   <li>FALLBACK : 跳转到指定的 fallbackNodeId（不存在则标记失败）</li>
     * </ul>
     *
     * <p>注意：CONTINUE 和 FALLBACK 中的 executeFromNode() 调用是递归的，
     * 但这是错误处理路径，深度有限（不会无限递归）。</p>
     */
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
                // Fix #6: 条件/多路分支节点出错时走 default 边而非盲目走第一条边
                List<WorkflowEdge> edges = definition.findOutgoingEdges(node.getId());
                if (node.getType() == NodeType.CONDITION || node.getType() == NodeType.SWITCH) {
                    WorkflowEdge defaultEdge = null;
                    for (WorkflowEdge edge : edges) {
                        String sh = edge.getSourceHandle();
                        if ("default".equals(sh) && evaluateCondition(edge.getCondition(), execution.getVariables())) {
                            defaultEdge = edge;
                            break;
                        }
                        if ("false".equals(sh) && evaluateCondition(edge.getCondition(), execution.getVariables())) {
                            defaultEdge = edge;
                            break;
                        }
                        if ((sh == null || sh.isBlank()) && evaluateCondition(edge.getCondition(), execution.getVariables())) {
                            defaultEdge = edge;
                        }
                    }
                    if (defaultEdge != null) {
                        log.warn("条件/分支节点[{}]执行出错，CONTINUE策略走default边: {}", 
                                node.getName(), defaultEdge.getTargetNodeId());
                        executeFromNode(execution, definition, defaultEdge.getTargetNodeId());
                    } else if (!edges.isEmpty()) {
                        log.warn("条件/分支节点[{}]执行出错，无default边，走第一条出边", node.getName());
                        executeFromNode(execution, definition, edges.get(0).getTargetNodeId());
                    }
                } else {
                    if (!edges.isEmpty()) {
                        // 普通节点: 跳过当前节点继续走第一条满足条件的有效出边
                        for (WorkflowEdge edge : edges) {
                            if (!"loop-end".equals(edge.getTargetHandle()) 
                                    && !"loop-start".equals(edge.getSourceHandle())
                                    && evaluateCondition(edge.getCondition(), execution.getVariables())) {
                                executeFromNode(execution, definition, edge.getTargetNodeId());
                                break;
                            }
                        }
                    }
                }
                break;
            case FALLBACK:
                String fallbackNodeId = errorConfig.getFallbackNodeId();
                if (fallbackNodeId != null) {
                    if (definition.findNodeById(fallbackNodeId) != null) {
                        executeFromNode(execution, definition, fallbackNodeId);
                    } else {
                        log.error("FALLBACK节点不存在: fallbackNodeId={}", fallbackNodeId);
                        execution.fail("FALLBACK节点不存在: " + fallbackNodeId);
                    }
                } else {
                    execution.fail(e.getMessage());
                }
                break;
            default:
                execution.fail(e.getMessage());
        }
    }

    private static final java.util.regex.Pattern VAR_REF = java.util.regex.Pattern.compile("\\$\\{([^}]+)}");
    private static final java.util.regex.Pattern EXPR_RE = java.util.regex.Pattern.compile(
            "^\\s*(.+?)\\s*(==|!=|>=|<=|>|<|contains|startsWith|endsWith)\\s*(.+?)\\s*$",
            java.util.regex.Pattern.CASE_INSENSITIVE);

    private boolean evaluateCondition(String condition, Map<String, Object> variables) {
        if (condition == null || condition.isEmpty()) {
            return true;
        }
        try {
            // 0. 预检查：条件中引用的变量是否全部存在（与执行器 evaluateExpression 一致）
            java.util.regex.Matcher preCheck = VAR_REF.matcher(condition);
            while (preCheck.find()) {
                String varPath = preCheck.group(1).trim();
                Object val = variables.get(varPath);
                if (val == null && varPath.contains(".")) {
                    val = variables.get(varPath.substring(varPath.lastIndexOf('.') + 1));
                }
                if (val == null) {
                    log.debug("边条件变量未找到(视为false): variable='{}', condition='{}'", varPath, condition);
                    return false;
                }
            }

            // 1. 替换 ${varName} → 实际值（支持去掉节点名前缀的回退）
            String resolved = condition;
            java.util.regex.Matcher vm = VAR_REF.matcher(condition);
            StringBuffer sb = new StringBuffer();
            while (vm.find()) {
                String varPath = vm.group(1).trim();
                Object val = variables.get(varPath);
                // 回退：去掉节点名前缀 (e.g. "开始.input" → "input")
                if (val == null && varPath.contains(".")) {
                    String lastPart = varPath.substring(varPath.lastIndexOf('.') + 1);
                    val = variables.get(lastPart);
                }
                vm.appendReplacement(sb, java.util.regex.Matcher.quoteReplacement(val != null ? String.valueOf(val) : ""));
            }
            vm.appendTail(sb);
            resolved = sb.toString().trim();

            // 2. 尝试解析为 "left operator right"
            java.util.regex.Matcher em = EXPR_RE.matcher(resolved);
            if (em.matches()) {
                String left = stripQuotes(em.group(1).trim());
                String op = em.group(2).trim();
                String right = stripQuotes(em.group(3).trim());
                return compareForCondition(left, op, right);
            }

            // 3. 布尔字面量
            if ("true".equalsIgnoreCase(resolved)) return true;
            if ("false".equalsIgnoreCase(resolved)) return false;

            // 4. 非零数字为 true
            try { return Double.parseDouble(resolved) != 0; } catch (NumberFormatException ignored) {}

            // 5. 非空字符串为 true（null 变量已被替换为空字符串，无需特殊判断 "null" 字面量）
            return !resolved.isEmpty();
        } catch (Exception e) {
            log.warn("条件评估失败(安全回退到false): condition={}, error={}", condition, e.getMessage());
            return false;
        }
    }

    private String stripQuotes(String s) {
        if (s.length() >= 2 && ((s.startsWith("\"") && s.endsWith("\"")) || (s.startsWith("'") && s.endsWith("'")))) {
            return s.substring(1, s.length() - 1);
        }
        return s;
    }

    private boolean compareForCondition(String left, String op, String right) {
        switch (op.toLowerCase()) {
            case "==" -> { return numEq(left, right) || left.equals(right); }
            case "!=" -> { return !(numEq(left, right) || left.equals(right)); }
            case ">"  -> { return compareNum(left, right) > 0; }
            case ">=" -> { return compareNum(left, right) >= 0; }
            case "<"  -> { return compareNum(left, right) < 0; }
            case "<=" -> { return compareNum(left, right) <= 0; }
            case "contains"   -> { return left.contains(right); }
            case "startswith" -> { return left.startsWith(right); }
            case "endswith"   -> { return left.endsWith(right); }
            default -> { return left.equals(right); }
        }
    }

    private boolean numEq(String a, String b) {
        try { return Double.compare(Double.parseDouble(a), Double.parseDouble(b)) == 0; }
        catch (NumberFormatException e) { return false; }
    }

    private int compareNum(String a, String b) {
        try { return Double.compare(Double.parseDouble(a), Double.parseDouble(b)); }
        catch (NumberFormatException e) { return a.compareTo(b); }
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
