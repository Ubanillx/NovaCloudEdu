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

    // ==================== 工作流定义编辑方法 ====================

    /**
     * 获取工作流定义详情
     */
    public WorkflowDefinitionVO getDefinition(Long id) {
        Workflow workflow = workflowRepository.findById(WorkflowId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + id));
        return toDefinitionVO(workflow);
    }

    /**
     * 获取可用的节点类型列表
     */
    public List<com.novacloudedu.backend.interfaces.rest.ai.dto.response.NodeTypeResponse> getAvailableNodeTypes() {
        return java.util.Arrays.stream(NodeType.values())
                .map(type -> com.novacloudedu.backend.interfaces.rest.ai.dto.response.NodeTypeResponse.builder()
                        .type(type.name())
                        .description(type.getDescription())
                        .category(getNodeCategory(type))
                        .build())
                .collect(Collectors.toList());
    }

    private String getNodeCategory(NodeType type) {
        return switch (type) {
            case START, WEBHOOK, SCHEDULE -> "触发节点";
            case LLM, KNOWLEDGE_RETRIEVAL, TEXT_EMBEDDING, INTENT_RECOGNITION, ENTITY_EXTRACTION -> "AI节点";
            case CONDITION, SWITCH, LOOP, PARALLEL, MERGE -> "逻辑节点";
            case VARIABLE_SET, VARIABLE_GET, JSON_PARSE, TEMPLATE, CODE -> "数据处理节点";
            case HTTP_REQUEST, DATABASE_QUERY, FILE_READ, FILE_WRITE -> "集成节点";
            case RESPONSE, END -> "输出节点";
        };
    }

    /**
     * 添加节点
     */
    @Transactional
    public WorkflowNodeVO addNode(Long workflowId, com.novacloudedu.backend.interfaces.rest.ai.dto.request.AddNodeRequest request) {
        log.info("添加节点: workflowId={}, nodeId={}", workflowId, request.getNodeId());
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowNode node = WorkflowNode.builder()
                .id(request.getNodeId())
                .type(request.getType())
                .name(request.getName())
                .position(WorkflowNode.Position.builder()
                        .x(request.getPositionX())
                        .y(request.getPositionY())
                        .build())
                .config(request.getConfig())
                .build();
        
        workflow.getDefinition().getNodes().add(node);
        workflowRepository.save(workflow);
        
        return toNodeVO(node);
    }

    /**
     * 获取工作流所有节点
     */
    public List<WorkflowNodeVO> getNodes(Long workflowId) {
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        return workflow.getDefinition().getNodes().stream()
                .map(this::toNodeVO)
                .collect(Collectors.toList());
    }

    /**
     * 获取单个节点
     */
    public WorkflowNodeVO getNode(Long workflowId, String nodeId) {
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowNode node = workflow.getDefinition().findNodeById(nodeId);
        if (node == null) {
            throw new IllegalArgumentException("节点不存在: " + nodeId);
        }
        return toNodeVO(node);
    }

    /**
     * 更新节点
     */
    @Transactional
    public WorkflowNodeVO updateNode(Long workflowId, String nodeId, 
            com.novacloudedu.backend.interfaces.rest.ai.dto.request.UpdateNodeRequest request) {
        log.info("更新节点: workflowId={}, nodeId={}", workflowId, nodeId);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowNode node = workflow.getDefinition().findNodeById(nodeId);
        if (node == null) {
            throw new IllegalArgumentException("节点不存在: " + nodeId);
        }
        
        if (request.getType() != null) node.setType(request.getType());
        if (request.getName() != null) node.setName(request.getName());
        if (request.getPositionX() != null) node.getPosition().setX(request.getPositionX());
        if (request.getPositionY() != null) node.getPosition().setY(request.getPositionY());
        if (request.getConfig() != null) node.setConfig(request.getConfig());
        
        workflowRepository.save(workflow);
        return toNodeVO(node);
    }

    /**
     * 更新节点配置
     */
    @Transactional
    public WorkflowNodeVO updateNodeConfig(Long workflowId, String nodeId, Map<String, Object> config) {
        log.info("更新节点配置: workflowId={}, nodeId={}", workflowId, nodeId);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowNode node = workflow.getDefinition().findNodeById(nodeId);
        if (node == null) {
            throw new IllegalArgumentException("节点不存在: " + nodeId);
        }
        
        node.setConfig(config);
        workflowRepository.save(workflow);
        return toNodeVO(node);
    }

    /**
     * 删除节点
     */
    @Transactional
    public void deleteNode(Long workflowId, String nodeId) {
        log.info("删除节点: workflowId={}, nodeId={}", workflowId, nodeId);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        workflow.getDefinition().getNodes().removeIf(n -> n.getId().equals(nodeId));
        workflow.getDefinition().getEdges().removeIf(e -> 
                e.getSourceNodeId().equals(nodeId) || e.getTargetNodeId().equals(nodeId));
        
        workflowRepository.save(workflow);
    }

    /**
     * 添加连接线
     */
    @Transactional
    public WorkflowEdgeVO addEdge(Long workflowId, 
            com.novacloudedu.backend.interfaces.rest.ai.dto.request.AddEdgeRequest request) {
        log.info("添加连接线: workflowId={}, edgeId={}", workflowId, request.getEdgeId());
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowEdge edge = WorkflowEdge.builder()
                .id(request.getEdgeId())
                .sourceNodeId(request.getSourceNodeId())
                .targetNodeId(request.getTargetNodeId())
                .sourceHandle(request.getSourceHandle())
                .targetHandle(request.getTargetHandle())
                .condition(request.getCondition())
                .label(request.getLabel())
                .build();
        
        workflow.getDefinition().getEdges().add(edge);
        workflowRepository.save(workflow);
        
        return toEdgeVO(edge);
    }

    /**
     * 获取工作流所有连接线
     */
    public List<WorkflowEdgeVO> getEdges(Long workflowId) {
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        return workflow.getDefinition().getEdges().stream()
                .map(this::toEdgeVO)
                .collect(Collectors.toList());
    }

    /**
     * 更新连接线
     */
    @Transactional
    public WorkflowEdgeVO updateEdge(Long workflowId, String edgeId, 
            com.novacloudedu.backend.interfaces.rest.ai.dto.request.UpdateEdgeRequest request) {
        log.info("更新连接线: workflowId={}, edgeId={}", workflowId, edgeId);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowEdge edge = workflow.getDefinition().getEdges().stream()
                .filter(e -> e.getId().equals(edgeId))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("连接线不存在: " + edgeId));
        
        if (request.getSourceNodeId() != null) edge.setSourceNodeId(request.getSourceNodeId());
        if (request.getTargetNodeId() != null) edge.setTargetNodeId(request.getTargetNodeId());
        if (request.getSourceHandle() != null) edge.setSourceHandle(request.getSourceHandle());
        if (request.getTargetHandle() != null) edge.setTargetHandle(request.getTargetHandle());
        if (request.getCondition() != null) edge.setCondition(request.getCondition());
        if (request.getLabel() != null) edge.setLabel(request.getLabel());
        
        workflowRepository.save(workflow);
        return toEdgeVO(edge);
    }

    /**
     * 删除连接线
     */
    @Transactional
    public void deleteEdge(Long workflowId, String edgeId) {
        log.info("删除连接线: workflowId={}, edgeId={}", workflowId, edgeId);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        workflow.getDefinition().getEdges().removeIf(e -> e.getId().equals(edgeId));
        workflowRepository.save(workflow);
    }

    /**
     * 添加变量
     */
    @Transactional
    public WorkflowVariableVO addVariable(Long workflowId, 
            com.novacloudedu.backend.interfaces.rest.ai.dto.request.AddVariableRequest request) {
        log.info("添加变量: workflowId={}, name={}", workflowId, request.getName());
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowDefinition.VariableDefinition variable = WorkflowDefinition.VariableDefinition.builder()
                .name(request.getName())
                .type(request.getType())
                .defaultValue(request.getDefaultValue())
                .description(request.getDescription())
                .build();
        
        workflow.getDefinition().getVariables().put(request.getName(), variable);
        workflowRepository.save(workflow);
        
        return toVariableVO(variable);
    }

    /**
     * 获取工作流所有变量
     */
    public List<WorkflowVariableVO> getVariables(Long workflowId) {
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        return workflow.getDefinition().getVariables().values().stream()
                .map(this::toVariableVO)
                .collect(Collectors.toList());
    }

    /**
     * 更新变量
     */
    @Transactional
    public WorkflowVariableVO updateVariable(Long workflowId, String variableName, 
            com.novacloudedu.backend.interfaces.rest.ai.dto.request.UpdateVariableRequest request) {
        log.info("更新变量: workflowId={}, name={}", workflowId, variableName);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowDefinition.VariableDefinition variable = workflow.getDefinition().getVariables().get(variableName);
        if (variable == null) {
            throw new IllegalArgumentException("变量不存在: " + variableName);
        }
        
        if (request.getType() != null) variable.setType(request.getType());
        if (request.getDefaultValue() != null) variable.setDefaultValue(request.getDefaultValue());
        if (request.getDescription() != null) variable.setDescription(request.getDescription());
        
        workflowRepository.save(workflow);
        return toVariableVO(variable);
    }

    /**
     * 删除变量
     */
    @Transactional
    public void deleteVariable(Long workflowId, String variableName) {
        log.info("删除变量: workflowId={}, name={}", workflowId, variableName);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        workflow.getDefinition().getVariables().remove(variableName);
        workflowRepository.save(workflow);
    }

    /**
     * 更新工作流设置
     */
    @Transactional
    public WorkflowSettingsVO updateSettings(Long workflowId, 
            com.novacloudedu.backend.interfaces.rest.ai.dto.request.UpdateWorkflowSettingsRequest request) {
        log.info("更新工作流设置: workflowId={}", workflowId);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowDefinition.WorkflowSettings settings = workflow.getDefinition().getSettings();
        if (request.getMaxExecutionTimeMs() != null) settings.setMaxExecutionTimeMs(request.getMaxExecutionTimeMs());
        if (request.getEnableLogging() != null) settings.setEnableLogging(request.getEnableLogging());
        if (request.getLogLevel() != null) settings.setLogLevel(LogLevel.valueOf(request.getLogLevel()));
        if (request.getEnableDebug() != null) settings.setEnableDebug(request.getEnableDebug());
        
        workflowRepository.save(workflow);
        return toSettingsVO(settings);
    }

    /**
     * 批量更新节点和连接线
     */
    @Transactional
    public WorkflowDefinitionVO batchUpdate(Long workflowId, 
            com.novacloudedu.backend.interfaces.rest.ai.dto.request.BatchUpdateNodesRequest request) {
        log.info("批量更新: workflowId={}", workflowId);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        // 删除指定的节点
        if (request.getDeleteNodeIds() != null) {
            for (String nodeId : request.getDeleteNodeIds()) {
                workflow.getDefinition().getNodes().removeIf(n -> n.getId().equals(nodeId));
                workflow.getDefinition().getEdges().removeIf(e -> 
                        e.getSourceNodeId().equals(nodeId) || e.getTargetNodeId().equals(nodeId));
            }
        }
        
        // 删除指定的连接线
        if (request.getDeleteEdgeIds() != null) {
            for (String edgeId : request.getDeleteEdgeIds()) {
                workflow.getDefinition().getEdges().removeIf(e -> e.getId().equals(edgeId));
            }
        }
        
        // 添加或更新节点
        if (request.getNodes() != null) {
            for (var nodeReq : request.getNodes()) {
                WorkflowNode existingNode = workflow.getDefinition().findNodeById(nodeReq.getNodeId());
                if (existingNode != null) {
                    existingNode.setType(nodeReq.getType());
                    existingNode.setName(nodeReq.getName());
                    existingNode.getPosition().setX(nodeReq.getPositionX());
                    existingNode.getPosition().setY(nodeReq.getPositionY());
                    existingNode.setConfig(nodeReq.getConfig());
                } else {
                    WorkflowNode node = WorkflowNode.builder()
                            .id(nodeReq.getNodeId())
                            .type(nodeReq.getType())
                            .name(nodeReq.getName())
                            .position(WorkflowNode.Position.builder()
                                    .x(nodeReq.getPositionX())
                                    .y(nodeReq.getPositionY())
                                    .build())
                            .config(nodeReq.getConfig())
                            .build();
                    workflow.getDefinition().getNodes().add(node);
                }
            }
        }
        
        // 添加或更新连接线
        if (request.getEdges() != null) {
            for (var edgeReq : request.getEdges()) {
                workflow.getDefinition().getEdges().removeIf(e -> e.getId().equals(edgeReq.getEdgeId()));
                WorkflowEdge edge = WorkflowEdge.builder()
                        .id(edgeReq.getEdgeId())
                        .sourceNodeId(edgeReq.getSourceNodeId())
                        .targetNodeId(edgeReq.getTargetNodeId())
                        .sourceHandle(edgeReq.getSourceHandle())
                        .targetHandle(edgeReq.getTargetHandle())
                        .condition(edgeReq.getCondition())
                        .label(edgeReq.getLabel())
                        .build();
                workflow.getDefinition().getEdges().add(edge);
            }
        }
        
        workflowRepository.save(workflow);
        return toDefinitionVO(workflow);
    }

    /**
     * 验证工作流定义
     */
    public WorkflowValidationVO validate(Long workflowId) {
        log.info("验证工作流: workflowId={}", workflowId);
        
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        WorkflowValidationVO result = new WorkflowValidationVO();
        result.setValid(true);
        result.setErrors(new java.util.ArrayList<>());
        result.setWarnings(new java.util.ArrayList<>());
        
        WorkflowDefinition def = workflow.getDefinition();
        
        // 检查是否有开始节点
        if (def.findStartNode() == null) {
            ValidationErrorVO error = new ValidationErrorVO();
            error.setCode("NO_START_NODE");
            error.setMessage("工作流缺少开始节点");
            result.getErrors().add(error);
            result.setValid(false);
        }
        
        // 检查是否有结束节点
        boolean hasEndNode = def.getNodes().stream().anyMatch(n -> n.getType() == NodeType.END);
        if (!hasEndNode) {
            ValidationErrorVO error = new ValidationErrorVO();
            error.setCode("NO_END_NODE");
            error.setMessage("工作流缺少结束节点");
            result.getErrors().add(error);
            result.setValid(false);
        }
        
        // 检查孤立节点
        for (WorkflowNode node : def.getNodes()) {
            if (node.getType() != NodeType.START) {
                boolean hasIncoming = def.getEdges().stream()
                        .anyMatch(e -> e.getTargetNodeId().equals(node.getId()));
                if (!hasIncoming) {
                    ValidationWarningVO warning = new ValidationWarningVO();
                    warning.setCode("UNREACHABLE_NODE");
                    warning.setMessage("节点 " + node.getName() + " 不可达");
                    warning.setNodeId(node.getId());
                    result.getWarnings().add(warning);
                }
            }
        }
        
        return result;
    }

    /**
     * 复制工作流
     */
    @Transactional
    public WorkflowVO copy(Long workflowId, String newName, Long userId) {
        log.info("复制工作流: workflowId={}, newName={}, userId={}", workflowId, newName, userId);
        
        Workflow source = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        Workflow copy = Workflow.create(newName, source.getDescription(), UserId.of(userId));
        copy.updateDefinition(source.getDefinition());
        copy = workflowRepository.save(copy);
        
        return toVO(copy);
    }

    // ==================== 私有转换方法 ====================

    private WorkflowDefinitionVO toDefinitionVO(Workflow workflow) {
        WorkflowDefinitionVO vo = new WorkflowDefinitionVO();
        vo.setWorkflowId(workflow.getId().value());
        vo.setWorkflowName(workflow.getName());
        vo.setVersion(workflow.getDefinition().getVersion());
        vo.setNodes(workflow.getDefinition().getNodes().stream()
                .map(this::toNodeVO)
                .collect(Collectors.toList()));
        vo.setEdges(workflow.getDefinition().getEdges().stream()
                .map(this::toEdgeVO)
                .collect(Collectors.toList()));
        vo.setVariables(workflow.getDefinition().getVariables().entrySet().stream()
                .collect(Collectors.toMap(Map.Entry::getKey, e -> toVariableVO(e.getValue()))));
        vo.setSettings(toSettingsVO(workflow.getDefinition().getSettings()));
        return vo;
    }

    private WorkflowNodeVO toNodeVO(WorkflowNode node) {
        WorkflowNodeVO vo = new WorkflowNodeVO();
        vo.setId(node.getId());
        vo.setType(node.getType().name());
        vo.setTypeDescription(node.getType().getDescription());
        vo.setName(node.getName());
        vo.setPositionX(node.getPosition() != null ? node.getPosition().getX() : 0);
        vo.setPositionY(node.getPosition() != null ? node.getPosition().getY() : 0);
        vo.setConfig(node.getConfig());
        if (node.getErrorHandling() != null) {
            ErrorHandlingConfigVO ehVO = new ErrorHandlingConfigVO();
            ehVO.setOnError(node.getErrorHandling().getOnError() != null ? 
                    node.getErrorHandling().getOnError().name() : null);
            ehVO.setRetryCount(node.getErrorHandling().getRetryCount());
            ehVO.setRetryDelayMs(node.getErrorHandling().getRetryDelayMs());
            ehVO.setFallbackNodeId(node.getErrorHandling().getFallbackNodeId());
            ehVO.setTimeoutMs(node.getErrorHandling().getTimeoutMs());
            vo.setErrorHandling(ehVO);
        }
        return vo;
    }

    private WorkflowEdgeVO toEdgeVO(WorkflowEdge edge) {
        WorkflowEdgeVO vo = new WorkflowEdgeVO();
        vo.setId(edge.getId());
        vo.setSourceNodeId(edge.getSourceNodeId());
        vo.setTargetNodeId(edge.getTargetNodeId());
        vo.setSourceHandle(edge.getSourceHandle());
        vo.setTargetHandle(edge.getTargetHandle());
        vo.setCondition(edge.getCondition());
        vo.setLabel(edge.getLabel());
        return vo;
    }

    private WorkflowVariableVO toVariableVO(WorkflowDefinition.VariableDefinition variable) {
        WorkflowVariableVO vo = new WorkflowVariableVO();
        vo.setName(variable.getName());
        vo.setType(variable.getType());
        vo.setDefaultValue(variable.getDefaultValue());
        vo.setDescription(variable.getDescription());
        return vo;
    }

    private WorkflowSettingsVO toSettingsVO(WorkflowDefinition.WorkflowSettings settings) {
        WorkflowSettingsVO vo = new WorkflowSettingsVO();
        vo.setMaxExecutionTimeMs(settings.getMaxExecutionTimeMs());
        vo.setEnableLogging(settings.isEnableLogging());
        vo.setLogLevel(settings.getLogLevel() != null ? settings.getLogLevel().name() : "INFO");
        vo.setEnableDebug(settings.isEnableDebug());
        return vo;
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

    @lombok.Data
    public static class WorkflowDefinitionVO {
        private Long workflowId;
        private String workflowName;
        private String version;
        private List<WorkflowNodeVO> nodes;
        private List<WorkflowEdgeVO> edges;
        private Map<String, WorkflowVariableVO> variables;
        private WorkflowSettingsVO settings;
    }

    @lombok.Data
    public static class WorkflowNodeVO {
        private String id;
        private String type;
        private String typeDescription;
        private String name;
        private int positionX;
        private int positionY;
        private Map<String, Object> config;
        private ErrorHandlingConfigVO errorHandling;
    }

    @lombok.Data
    public static class ErrorHandlingConfigVO {
        private String onError;
        private int retryCount;
        private long retryDelayMs;
        private String fallbackNodeId;
        private long timeoutMs;
    }

    @lombok.Data
    public static class WorkflowEdgeVO {
        private String id;
        private String sourceNodeId;
        private String targetNodeId;
        private String sourceHandle;
        private String targetHandle;
        private String condition;
        private String label;
    }

    @lombok.Data
    public static class WorkflowVariableVO {
        private String name;
        private String type;
        private Object defaultValue;
        private String description;
    }

    @lombok.Data
    public static class WorkflowSettingsVO {
        private long maxExecutionTimeMs;
        private boolean enableLogging;
        private String logLevel;
        private boolean enableDebug;
    }

    @lombok.Data
    public static class WorkflowValidationVO {
        private boolean valid;
        private List<ValidationErrorVO> errors;
        private List<ValidationWarningVO> warnings;
    }

    @lombok.Data
    public static class ValidationErrorVO {
        private String code;
        private String message;
        private String nodeId;
        private String edgeId;
    }

    @lombok.Data
    public static class ValidationWarningVO {
        private String code;
        private String message;
        private String nodeId;
    }
}
