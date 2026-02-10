package com.novacloudedu.backend.interfaces.rest.ai;

import com.novacloudedu.backend.application.service.WorkflowApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import com.novacloudedu.backend.interfaces.rest.ai.assembler.WorkflowAssembler;
import com.novacloudedu.backend.interfaces.rest.ai.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.ai.dto.response.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 工作流控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/workflows")
@RequiredArgsConstructor
@Tag(name = "工作流管理", description = "AI工作流CRUD和执行接口")
public class WorkflowController {

    private final WorkflowApplicationService workflowService;
    private final WorkflowAssembler assembler;
    private final LangchainChatService langchainChatService;
    private final com.novacloudedu.backend.infrastructure.workflow.DatabaseMetadataService databaseMetadataService;

    @PostMapping
    @Operation(summary = "创建工作流")
    public BaseResponse<WorkflowResponse> create(
            @Valid @RequestBody CreateWorkflowRequest request) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.create(
                    request.getUserId(), request.getName(), request.getDescription());
            return ResultUtils.success(assembler.toResponse(vo));
        } catch (Exception e) {
            log.error("创建工作流失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取工作流详情")
    public BaseResponse<WorkflowResponse> getById(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.getById(id);
            return ResultUtils.success(assembler.toResponse(vo));
        } catch (Exception e) {
            log.error("获取工作流失败", e);
            return errorResponse(e);
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新工作流基本信息")
    public BaseResponse<WorkflowResponse> update(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Valid @RequestBody UpdateWorkflowRequest request) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.updateBasicInfo(
                    id, request.getName(), request.getDescription());
            return ResultUtils.success(assembler.toResponse(vo));
        } catch (Exception e) {
            log.error("更新工作流失败", e);
            return errorResponse(e);
        }
    }

    @PutMapping("/{id}/definition")
    @Operation(summary = "更新工作流定义")
    public BaseResponse<WorkflowResponse> updateDefinition(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Valid @RequestBody UpdateWorkflowDefinitionRequest request) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.updateDefinition(id, request.getDefinition());
            return ResultUtils.success(assembler.toResponse(vo));
        } catch (Exception e) {
            log.error("更新工作流定义失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping
    @Operation(summary = "获取用户的工作流列表")
    public BaseResponse<List<WorkflowResponse>> listByUser(
            @Parameter(description = "用户ID") @RequestParam Long userId,
            @Parameter(description = "页码，从0开始") @RequestParam(defaultValue = "0") int page,
            @Parameter(description = "每页数量") @RequestParam(defaultValue = "20") int size) {
        try {
            List<WorkflowApplicationService.WorkflowVO> list = workflowService.listByUser(userId, page, size);
            return ResultUtils.success(assembler.toResponseList(list));
        } catch (Exception e) {
            log.error("获取工作流列表失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/public")
    @Operation(summary = "获取公开的工作流列表")
    public BaseResponse<List<WorkflowResponse>> listPublic(
            @Parameter(description = "页码，从0开始") @RequestParam(defaultValue = "0") int page,
            @Parameter(description = "每页数量") @RequestParam(defaultValue = "20") int size) {
        try {
            List<WorkflowApplicationService.WorkflowVO> list = workflowService.listPublic(page, size);
            return ResultUtils.success(assembler.toResponseList(list));
        } catch (Exception e) {
            log.error("获取公开工作流列表失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/{id}/publish")
    @Operation(summary = "发布工作流")
    public BaseResponse<WorkflowResponse> publish(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.publish(id);
            return ResultUtils.success(assembler.toResponse(vo));
        } catch (Exception e) {
            log.error("发布工作流失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/{id}/archive")
    @Operation(summary = "归档工作流")
    public BaseResponse<WorkflowResponse> archive(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.archive(id);
            return ResultUtils.success(assembler.toResponse(vo));
        } catch (Exception e) {
            log.error("归档工作流失败", e);
            return errorResponse(e);
        }
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除工作流")
    public BaseResponse<Void> delete(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            workflowService.delete(id);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("删除工作流失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/{id}/execute")
    @Operation(summary = "执行工作流")
    public BaseResponse<ExecutionResultResponse> execute(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Valid @RequestBody ExecuteWorkflowRequest request) {
        try {
            WorkflowApplicationService.ExecutionResultVO result = workflowService.execute(
                    id, request.getInput(), request.getUserId());
            return ResultUtils.success(assembler.toExecutionResponse(result));
        } catch (Exception e) {
            log.error("执行工作流失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/{id}/execute-async")
    @Operation(summary = "异步执行工作流")
    public BaseResponse<AsyncExecutionResponse> executeAsync(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Valid @RequestBody ExecuteWorkflowRequest request) {
        try {
            String executionId = workflowService.executeAsync(id, request.getInput(), request.getUserId());
            return ResultUtils.success(AsyncExecutionResponse.builder()
                    .executionId(executionId)
                    .message("工作流已开始异步执行")
                    .build());
        } catch (Exception e) {
            log.error("异步执行工作流失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/executions/{executionId}")
    @Operation(summary = "获取执行状态")
    public BaseResponse<ExecutionResultResponse> getExecutionStatus(
            @Parameter(description = "执行ID") @PathVariable String executionId) {
        try {
            WorkflowApplicationService.ExecutionResultVO result = workflowService.getExecutionStatus(executionId);
            return ResultUtils.success(assembler.toExecutionResponse(result));
        } catch (Exception e) {
            log.error("获取执行状态失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/executions/{executionId}/cancel")
    @Operation(summary = "取消执行")
    public BaseResponse<Void> cancelExecution(
            @Parameter(description = "执行ID") @PathVariable String executionId) {
        try {
            workflowService.cancelExecution(executionId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("取消执行失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/executions/{executionId}/logs")
    @Operation(summary = "获取执行日志")
    public BaseResponse<List<ExecutionLogResponse>> getExecutionLogs(
            @Parameter(description = "执行ID") @PathVariable String executionId,
            @Parameter(description = "日志级别过滤（可选）：DEBUG/INFO/WARN/ERROR") @RequestParam(required = false) String level) {
        try {
            List<WorkflowApplicationService.ExecutionLogVO> logs;
            if (level != null && !level.isBlank()) {
                logs = workflowService.getExecutionLogsByLevel(executionId, level);
            } else {
                logs = workflowService.getExecutionLogs(executionId);
            }
            return ResultUtils.success(assembler.toLogResponseList(logs));
        } catch (Exception e) {
            log.error("获取执行日志失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/{id}/executions")
    @Operation(summary = "获取工作流执行历史列表")
    public BaseResponse<List<ExecutionResultResponse>> listExecutions(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "页码，从0开始") @RequestParam(defaultValue = "0") int page,
            @Parameter(description = "每页数量") @RequestParam(defaultValue = "20") int size) {
        try {
            List<WorkflowApplicationService.ExecutionResultVO> list = workflowService.listExecutions(id, page, size);
            return ResultUtils.success(list.stream().map(assembler::toExecutionResponse).toList());
        } catch (Exception e) {
            log.error("获取执行历史失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/{id}/execution-statistics")
    @Operation(summary = "获取工作流执行统计")
    public BaseResponse<ExecutionStatisticsResponse> getExecutionStatistics(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            WorkflowApplicationService.ExecutionStatisticsVO stats = workflowService.getExecutionStatistics(id);
            return ResultUtils.success(ExecutionStatisticsResponse.builder()
                    .totalCount(stats.getTotalCount())
                    .successCount(stats.getSuccessCount())
                    .failedCount(stats.getFailedCount())
                    .cancelledCount(stats.getCancelledCount())
                    .avgDurationMs(stats.getAvgDurationMs())
                    .successRate(stats.getSuccessRate())
                    .build());
        } catch (Exception e) {
            log.error("获取执行统计失败", e);
            return errorResponse(e);
        }
    }

    // ==================== 工作流定义编辑接口 ====================

    @GetMapping("/{id}/definition")
    @Operation(summary = "获取工作流定义详情")
    public BaseResponse<WorkflowDefinitionResponse> getDefinition(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            WorkflowApplicationService.WorkflowDefinitionVO vo = workflowService.getDefinition(id);
            return ResultUtils.success(assembler.toDefinitionResponse(vo));
        } catch (Exception e) {
            log.error("获取工作流定义失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/node-types")
    @Operation(summary = "获取所有可用的节点类型")
    public BaseResponse<List<NodeTypeResponse>> getNodeTypes() {
        try {
            List<NodeTypeResponse> types = workflowService.getAvailableNodeTypes();
            return ResultUtils.success(types);
        } catch (Exception e) {
            log.error("获取节点类型失败", e);
            return errorResponse(e);
        }
    }

    // ==================== 节点操作接口 ====================

    @PostMapping("/{id}/nodes")
    @Operation(summary = "添加节点")
    public BaseResponse<WorkflowNodeResponse> addNode(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Valid @RequestBody AddNodeRequest request) {
        try {
            WorkflowApplicationService.WorkflowNodeVO vo = workflowService.addNode(id, request);
            return ResultUtils.success(assembler.toNodeResponse(vo));
        } catch (Exception e) {
            log.error("添加节点失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/{id}/nodes")
    @Operation(summary = "获取工作流所有节点")
    public BaseResponse<List<WorkflowNodeResponse>> getNodes(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            List<WorkflowApplicationService.WorkflowNodeVO> nodes = workflowService.getNodes(id);
            return ResultUtils.success(assembler.toNodeResponseList(nodes));
        } catch (Exception e) {
            log.error("获取节点列表失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/{id}/nodes/{nodeId}")
    @Operation(summary = "获取单个节点详情")
    public BaseResponse<WorkflowNodeResponse> getNode(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "节点ID") @PathVariable String nodeId) {
        try {
            WorkflowApplicationService.WorkflowNodeVO vo = workflowService.getNode(id, nodeId);
            return ResultUtils.success(assembler.toNodeResponse(vo));
        } catch (Exception e) {
            log.error("获取节点失败", e);
            return errorResponse(e);
        }
    }

    @PutMapping("/{id}/nodes/{nodeId}")
    @Operation(summary = "更新节点")
    public BaseResponse<WorkflowNodeResponse> updateNode(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "节点ID") @PathVariable String nodeId,
            @Valid @RequestBody UpdateNodeRequest request) {
        try {
            WorkflowApplicationService.WorkflowNodeVO vo = workflowService.updateNode(id, nodeId, request);
            return ResultUtils.success(assembler.toNodeResponse(vo));
        } catch (Exception e) {
            log.error("更新节点失败", e);
            return errorResponse(e);
        }
    }

    @PutMapping("/{id}/nodes/{nodeId}/config")
    @Operation(summary = "更新节点配置")
    public BaseResponse<WorkflowNodeResponse> updateNodeConfig(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "节点ID") @PathVariable String nodeId,
            @Valid @RequestBody UpdateNodeConfigRequest request) {
        try {
            WorkflowApplicationService.WorkflowNodeVO vo = workflowService.updateNodeConfig(id, nodeId, request.getConfig());
            return ResultUtils.success(assembler.toNodeResponse(vo));
        } catch (Exception e) {
            log.error("更新节点配置失败", e);
            return errorResponse(e);
        }
    }

    @DeleteMapping("/{id}/nodes/{nodeId}")
    @Operation(summary = "删除节点")
    public BaseResponse<Void> deleteNode(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "节点ID") @PathVariable String nodeId) {
        try {
            workflowService.deleteNode(id, nodeId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("删除节点失败", e);
            return errorResponse(e);
        }
    }

    // ==================== 连接线操作接口 ====================

    @PostMapping("/{id}/edges")
    @Operation(summary = "添加连接线")
    public BaseResponse<WorkflowEdgeResponse> addEdge(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Valid @RequestBody AddEdgeRequest request) {
        try {
            WorkflowApplicationService.WorkflowEdgeVO vo = workflowService.addEdge(id, request);
            return ResultUtils.success(assembler.toEdgeResponse(vo));
        } catch (Exception e) {
            log.error("添加连接线失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/{id}/edges")
    @Operation(summary = "获取工作流所有连接线")
    public BaseResponse<List<WorkflowEdgeResponse>> getEdges(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            List<WorkflowApplicationService.WorkflowEdgeVO> edges = workflowService.getEdges(id);
            return ResultUtils.success(assembler.toEdgeResponseList(edges));
        } catch (Exception e) {
            log.error("获取连接线列表失败", e);
            return errorResponse(e);
        }
    }

    @PutMapping("/{id}/edges/{edgeId}")
    @Operation(summary = "更新连接线")
    public BaseResponse<WorkflowEdgeResponse> updateEdge(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "连接线ID") @PathVariable String edgeId,
            @Valid @RequestBody UpdateEdgeRequest request) {
        try {
            WorkflowApplicationService.WorkflowEdgeVO vo = workflowService.updateEdge(id, edgeId, request);
            return ResultUtils.success(assembler.toEdgeResponse(vo));
        } catch (Exception e) {
            log.error("更新连接线失败", e);
            return errorResponse(e);
        }
    }

    @DeleteMapping("/{id}/edges/{edgeId}")
    @Operation(summary = "删除连接线")
    public BaseResponse<Void> deleteEdge(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "连接线ID") @PathVariable String edgeId) {
        try {
            workflowService.deleteEdge(id, edgeId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("删除连接线失败", e);
            return errorResponse(e);
        }
    }

    // ==================== 变量操作接口 ====================

    @PostMapping("/{id}/variables")
    @Operation(summary = "添加变量")
    public BaseResponse<WorkflowVariableResponse> addVariable(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Valid @RequestBody AddVariableRequest request) {
        try {
            WorkflowApplicationService.WorkflowVariableVO vo = workflowService.addVariable(id, request);
            return ResultUtils.success(assembler.toVariableResponse(vo));
        } catch (Exception e) {
            log.error("添加变量失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/{id}/variables")
    @Operation(summary = "获取工作流所有变量")
    public BaseResponse<List<WorkflowVariableResponse>> getVariables(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            List<WorkflowApplicationService.WorkflowVariableVO> variables = workflowService.getVariables(id);
            return ResultUtils.success(assembler.toVariableResponseList(variables));
        } catch (Exception e) {
            log.error("获取变量列表失败", e);
            return errorResponse(e);
        }
    }

    @PutMapping("/{id}/variables/{variableName}")
    @Operation(summary = "更新变量")
    public BaseResponse<WorkflowVariableResponse> updateVariable(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "变量名称") @PathVariable String variableName,
            @Valid @RequestBody UpdateVariableRequest request) {
        try {
            WorkflowApplicationService.WorkflowVariableVO vo = workflowService.updateVariable(id, variableName, request);
            return ResultUtils.success(assembler.toVariableResponse(vo));
        } catch (Exception e) {
            log.error("更新变量失败", e);
            return errorResponse(e);
        }
    }

    @DeleteMapping("/{id}/variables/{variableName}")
    @Operation(summary = "删除变量")
    public BaseResponse<Void> deleteVariable(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "变量名称") @PathVariable String variableName) {
        try {
            workflowService.deleteVariable(id, variableName);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("删除变量失败", e);
            return errorResponse(e);
        }
    }

    // ==================== 工作流设置接口 ====================

    @PutMapping("/{id}/settings")
    @Operation(summary = "更新工作流设置")
    public BaseResponse<WorkflowDefinitionResponse.WorkflowSettingsDTO> updateSettings(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Valid @RequestBody UpdateWorkflowSettingsRequest request) {
        try {
            WorkflowApplicationService.WorkflowSettingsVO vo = workflowService.updateSettings(id, request);
            return ResultUtils.success(assembler.toSettingsResponse(vo));
        } catch (Exception e) {
            log.error("更新工作流设置失败", e);
            return errorResponse(e);
        }
    }

    // ==================== 批量操作接口 ====================

    @PostMapping("/{id}/batch-update")
    @Operation(summary = "批量更新节点和连接线")
    public BaseResponse<WorkflowDefinitionResponse> batchUpdate(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Valid @RequestBody BatchUpdateNodesRequest request) {
        try {
            WorkflowApplicationService.WorkflowDefinitionVO vo = workflowService.batchUpdate(id, request);
            return ResultUtils.success(assembler.toDefinitionResponse(vo));
        } catch (Exception e) {
            log.error("批量更新失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/{id}/validate")
    @Operation(summary = "验证工作流定义")
    public BaseResponse<WorkflowValidationResponse> validate(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            WorkflowApplicationService.WorkflowValidationVO vo = workflowService.validate(id);
            return ResultUtils.success(assembler.toValidationResponse(vo));
        } catch (Exception e) {
            log.error("验证工作流失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/{id}/copy")
    @Operation(summary = "复制工作流")
    public BaseResponse<WorkflowResponse> copy(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "新工作流名称") @RequestParam String newName,
            @Parameter(description = "用户ID") @RequestParam Long userId) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.copy(id, newName, userId);
            return ResultUtils.success(assembler.toResponse(vo));
        } catch (Exception e) {
            log.error("复制工作流失败", e);
            return errorResponse(e);
        }
    }

    // ==================== 工作流模板接口 ====================

    @GetMapping("/templates")
    @Operation(summary = "搜索工作流模板", description = "返回公开模板 + 当前用户自己创建的私有模板")
    public BaseResponse<List<WorkflowTemplateResponse>> searchTemplates(
            @Parameter(description = "关键词") @RequestParam(required = false) String keyword,
            @Parameter(description = "分类") @RequestParam(required = false) String category,
            @Parameter(description = "页码") @RequestParam(defaultValue = "0") int page,
            @Parameter(description = "每页数量") @RequestParam(defaultValue = "20") int size,
            Authentication authentication) {
        try {
            Long currentUserId = authentication != null ? Long.parseLong(authentication.getName()) : null;
            List<WorkflowApplicationService.WorkflowTemplateVO> list = workflowService.searchTemplates(keyword, category, currentUserId, page, size);
            return ResultUtils.success(list.stream().map(assembler::toTemplateResponse).toList());
        } catch (Exception e) {
            log.error("搜索模板失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/templates/system")
    @Operation(summary = "获取系统预置模板")
    public BaseResponse<List<WorkflowTemplateResponse>> listSystemTemplates() {
        try {
            List<WorkflowApplicationService.WorkflowTemplateVO> list = workflowService.listSystemTemplates();
            return ResultUtils.success(list.stream().map(assembler::toTemplateResponse).toList());
        } catch (Exception e) {
            log.error("获取系统模板失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/templates/{templateId}")
    @Operation(summary = "获取模板详情")
    public BaseResponse<WorkflowTemplateResponse> getTemplate(
            @Parameter(description = "模板ID") @PathVariable Long templateId) {
        try {
            WorkflowApplicationService.WorkflowTemplateVO vo = workflowService.getTemplate(templateId);
            return ResultUtils.success(assembler.toTemplateResponse(vo));
        } catch (Exception e) {
            log.error("获取模板详情失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/templates/from-workflow/{workflowId}")
    @Operation(summary = "从工作流创建模板")
    public BaseResponse<WorkflowTemplateResponse> createTemplate(
            @Parameter(description = "工作流ID") @PathVariable Long workflowId,
            @RequestParam String name,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) String category,
            @RequestParam Long userId) {
        try {
            WorkflowApplicationService.WorkflowTemplateVO vo = workflowService.createTemplate(name, description, category, workflowId, userId);
            return ResultUtils.success(assembler.toTemplateResponse(vo));
        } catch (Exception e) {
            log.error("创建模板失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/templates/{templateId}/create-workflow")
    @Operation(summary = "从模板创建工作流")
    public BaseResponse<WorkflowResponse> createFromTemplate(
            @Parameter(description = "模板ID") @PathVariable Long templateId,
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String description,
            @RequestParam Long userId) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.createFromTemplate(templateId, name, description, userId);
            return ResultUtils.success(assembler.toResponse(vo));
        } catch (Exception e) {
            log.error("从模板创建工作流失败", e);
            return errorResponse(e);
        }
    }

    @DeleteMapping("/templates/{templateId}")
    @Operation(summary = "删除模板")
    public BaseResponse<Void> deleteTemplate(
            @Parameter(description = "模板ID") @PathVariable Long templateId) {
        try {
            workflowService.deleteTemplate(templateId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("删除模板失败", e);
            return errorResponse(e);
        }
    }

    // ==================== 工作流触发器接口 ====================

    @GetMapping("/{id}/triggers")
    @Operation(summary = "获取工作流触发器列表")
    public BaseResponse<List<WorkflowTriggerResponse>> listTriggers(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            List<WorkflowApplicationService.WorkflowTriggerVO> list = workflowService.listTriggers(id);
            return ResultUtils.success(list.stream().map(assembler::toTriggerResponse).toList());
        } catch (Exception e) {
            log.error("获取触发器列表失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/{id}/triggers/schedule")
    @Operation(summary = "创建定时触发器")
    public BaseResponse<WorkflowTriggerResponse> createScheduleTrigger(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @RequestParam String name,
            @RequestParam String cronExpression,
            @RequestParam(required = false) String timezone) {
        try {
            WorkflowApplicationService.WorkflowTriggerVO vo = workflowService.createScheduleTrigger(id, name, cronExpression, timezone);
            return ResultUtils.success(assembler.toTriggerResponse(vo));
        } catch (Exception e) {
            log.error("创建定时触发器失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/{id}/triggers/webhook")
    @Operation(summary = "创建Webhook触发器")
    public BaseResponse<WorkflowTriggerResponse> createWebhookTrigger(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @RequestParam String name,
            @RequestParam(required = false) String secret,
            @RequestParam(defaultValue = "false") boolean validateSignature) {
        try {
            WorkflowApplicationService.WorkflowTriggerVO vo = workflowService.createWebhookTrigger(id, name, secret, validateSignature);
            return ResultUtils.success(assembler.toTriggerResponse(vo));
        } catch (Exception e) {
            log.error("创建Webhook触发器失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/triggers/{triggerId}/enable")
    @Operation(summary = "启用触发器")
    public BaseResponse<WorkflowTriggerResponse> enableTrigger(
            @Parameter(description = "触发器ID") @PathVariable Long triggerId) {
        try {
            WorkflowApplicationService.WorkflowTriggerVO vo = workflowService.enableTrigger(triggerId);
            return ResultUtils.success(assembler.toTriggerResponse(vo));
        } catch (Exception e) {
            log.error("启用触发器失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/triggers/{triggerId}/disable")
    @Operation(summary = "禁用触发器")
    public BaseResponse<WorkflowTriggerResponse> disableTrigger(
            @Parameter(description = "触发器ID") @PathVariable Long triggerId) {
        try {
            WorkflowApplicationService.WorkflowTriggerVO vo = workflowService.disableTrigger(triggerId);
            return ResultUtils.success(assembler.toTriggerResponse(vo));
        } catch (Exception e) {
            log.error("禁用触发器失败", e);
            return errorResponse(e);
        }
    }

    @DeleteMapping("/triggers/{triggerId}")
    @Operation(summary = "删除触发器")
    public BaseResponse<Void> deleteTrigger(
            @Parameter(description = "触发器ID") @PathVariable Long triggerId) {
        try {
            workflowService.deleteTrigger(triggerId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("删除触发器失败", e);
            return errorResponse(e);
        }
    }

    // ==================== 工作流版本历史接口 ====================

    @GetMapping("/{id}/versions")
    @Operation(summary = "获取工作流版本列表")
    public BaseResponse<List<WorkflowVersionResponse>> listVersions(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            List<WorkflowApplicationService.WorkflowVersionVO> list = workflowService.listVersions(id);
            return ResultUtils.success(list.stream().map(assembler::toVersionResponse).toList());
        } catch (Exception e) {
            log.error("获取版本列表失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/{id}/versions/{versionNumber}")
    @Operation(summary = "获取指定版本详情")
    public BaseResponse<WorkflowVersionResponse> getVersion(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "版本号") @PathVariable int versionNumber) {
        try {
            WorkflowApplicationService.WorkflowVersionVO vo = workflowService.getVersionByNumber(id, versionNumber);
            return ResultUtils.success(assembler.toVersionResponse(vo));
        } catch (Exception e) {
            log.error("获取版本详情失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/{id}/versions")
    @Operation(summary = "创建版本快照（发布时）")
    public BaseResponse<WorkflowVersionResponse> createVersionSnapshot(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @RequestParam(required = false) String publishNote,
            @RequestParam Long userId) {
        try {
            WorkflowApplicationService.WorkflowVersionVO vo = workflowService.createVersionSnapshot(id, publishNote, userId);
            return ResultUtils.success(assembler.toVersionResponse(vo));
        } catch (Exception e) {
            log.error("创建版本快照失败", e);
            return errorResponse(e);
        }
    }

    @PostMapping("/{id}/versions/{versionNumber}/rollback")
    @Operation(summary = "回滚到指定版本")
    public BaseResponse<WorkflowResponse> rollbackToVersion(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "版本号") @PathVariable int versionNumber) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.rollbackToVersion(id, versionNumber);
            return ResultUtils.success(assembler.toResponse(vo));
        } catch (Exception e) {
            log.error("版本回滚失败", e);
            return errorResponse(e);
        }
    }

    // ==================== AI助手工作流关联接口 ====================

    @PostMapping("/{id}/assistants/{assistantId}")
    @Operation(summary = "绑定工作流到AI助手")
    public BaseResponse<Void> bindToAssistant(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "AI助手ID") @PathVariable Long assistantId) {
        try {
            workflowService.bindWorkflowToAssistant(assistantId, id);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("绑定工作流失败", e);
            return errorResponse(e);
        }
    }

    @DeleteMapping("/{id}/assistants/{assistantId}")
    @Operation(summary = "解绑工作流与AI助手")
    public BaseResponse<Void> unbindFromAssistant(
            @Parameter(description = "工作流ID") @PathVariable Long id,
            @Parameter(description = "AI助手ID") @PathVariable Long assistantId) {
        try {
            workflowService.unbindWorkflowFromAssistant(assistantId, id);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("解绑工作流失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/{id}/assistants")
    @Operation(summary = "获取使用该工作流的AI助手ID列表")
    public BaseResponse<List<Long>> getWorkflowAssistants(
            @Parameter(description = "工作流ID") @PathVariable Long id) {
        try {
            return ResultUtils.success(workflowService.getWorkflowAssistantIds(id));
        } catch (Exception e) {
            log.error("获取关联助手失败", e);
            return errorResponse(e);
        }
    }

    // ==================== 数据库查询节点元数据接口 ====================

    @GetMapping("/database/tables")
    @Operation(summary = "获取可查询的数据库表列表", description = "返回工作流数据库查询节点允许访问的安全表名及字段信息")
    public BaseResponse<List<Map<String, Object>>> listAllowedTables() {
        try {
            var tables = databaseMetadataService.getAllAllowedTablesWithColumns();
            List<Map<String, Object>> result = tables.stream().map(t -> {
                Map<String, Object> map = new java.util.LinkedHashMap<>();
                map.put("name", t.getName());
                map.put("comment", t.getComment());
                map.put("columns", t.getColumns().stream().map(c -> {
                    Map<String, Object> col = new java.util.LinkedHashMap<>();
                    col.put("name", c.getName());
                    col.put("dataType", c.getDataType());
                    col.put("nullable", c.isNullable());
                    col.put("comment", c.getComment());
                    col.put("maxLength", c.getMaxLength());
                    return col;
                }).toList());
                return map;
            }).toList();
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("获取可查询表列表失败", e);
            return errorResponse(e);
        }
    }

    @GetMapping("/database/tables/{tableName}/columns")
    @Operation(summary = "获取指定表的字段信息", description = "返回白名单内指定表的字段名、类型等元数据")
    public BaseResponse<List<Map<String, Object>>> getTableColumns(
            @Parameter(description = "表名") @PathVariable String tableName) {
        try {
            var columns = databaseMetadataService.getTableColumns(tableName);
            List<Map<String, Object>> result = columns.stream().map(c -> {
                Map<String, Object> col = new java.util.LinkedHashMap<>();
                col.put("name", c.getName());
                col.put("dataType", c.getDataType());
                col.put("nullable", c.isNullable());
                col.put("defaultValue", c.getDefaultValue());
                col.put("comment", c.getComment());
                col.put("maxLength", c.getMaxLength());
                return col;
            }).toList();
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("获取表字段信息失败: table={}", tableName, e);
            return errorResponse(e);
        }
    }

    // ==================== 模型管理 ====================

    @GetMapping("/models")
    @Operation(summary = "获取可用模型列表", description = "返回所有已启用的AI模型，供工作流LLM节点选择")
    public BaseResponse<List<Map<String, Object>>> listAvailableModels() {
        try {
            return ResultUtils.success(langchainChatService.listAvailableModels());
        } catch (Exception e) {
            log.error("获取可用模型列表失败", e);
            return errorResponse(e);
        }
    }

    /**
     * 根据异常类型返回不同的错误码，便于前端区分：
     * <ul>
     *   <li>40000 — 参数/业务校验错误（IllegalArgumentException）</li>
     *   <li>40900 — 状态冲突（IllegalStateException）</li>
     *   <li>50000 — 服务器内部错误（其他异常）</li>
     * </ul>
     */
    @SuppressWarnings("unchecked")
    static <T> BaseResponse<T> errorResponse(Exception e) {
        int code;
        if (e instanceof IllegalArgumentException) {
            code = 40000;
        } else if (e instanceof IllegalStateException) {
            code = 40900;
        } else {
            code = 50000;
        }
        return (BaseResponse<T>) (BaseResponse<?>) ResultUtils.error(code, e.getMessage());
    }
}
