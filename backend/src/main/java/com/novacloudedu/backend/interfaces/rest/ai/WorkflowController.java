package com.novacloudedu.backend.interfaces.rest.ai;

import com.novacloudedu.backend.application.service.WorkflowApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.interfaces.rest.ai.assembler.WorkflowAssembler;
import com.novacloudedu.backend.interfaces.rest.ai.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.ai.dto.response.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
            return (BaseResponse<WorkflowResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<List<WorkflowResponse>>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<List<WorkflowResponse>>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<ExecutionResultResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<AsyncExecutionResponse>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<ExecutionResultResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/executions/{executionId}/logs")
    @Operation(summary = "获取执行日志")
    public BaseResponse<List<ExecutionLogResponse>> getExecutionLogs(
            @Parameter(description = "执行ID") @PathVariable String executionId) {
        try {
            List<WorkflowApplicationService.ExecutionLogVO> logs = workflowService.getExecutionLogs(executionId);
            return ResultUtils.success(assembler.toLogResponseList(logs));
        } catch (Exception e) {
            log.error("获取执行日志失败", e);
            return (BaseResponse<List<ExecutionLogResponse>>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowDefinitionResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<List<NodeTypeResponse>>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowNodeResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<List<WorkflowNodeResponse>>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowNodeResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowNodeResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowNodeResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowEdgeResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<List<WorkflowEdgeResponse>>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowEdgeResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowVariableResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<List<WorkflowVariableResponse>>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowVariableResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowDefinitionResponse.WorkflowSettingsDTO>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowDefinitionResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowValidationResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
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
            return (BaseResponse<WorkflowResponse>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }
}
