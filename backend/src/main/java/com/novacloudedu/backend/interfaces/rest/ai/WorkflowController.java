package com.novacloudedu.backend.interfaces.rest.ai;

import com.novacloudedu.backend.application.service.WorkflowApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowDefinition;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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

    @PostMapping
    @Operation(summary = "创建工作流")
    public BaseResponse<WorkflowApplicationService.WorkflowVO> create(
            @RequestParam Long userId,
            @RequestBody Map<String, String> request) {
        try {
            String name = request.get("name");
            String description = request.get("description");
            WorkflowApplicationService.WorkflowVO vo = workflowService.create(userId, name, description);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("创建工作流失败", e);
            return (BaseResponse<WorkflowApplicationService.WorkflowVO>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取工作流详情")
    public BaseResponse<WorkflowApplicationService.WorkflowVO> getById(@PathVariable Long id) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.getById(id);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("获取工作流失败", e);
            return (BaseResponse<WorkflowApplicationService.WorkflowVO>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新工作流基本信息")
    public BaseResponse<WorkflowApplicationService.WorkflowVO> update(
            @PathVariable Long id,
            @RequestBody Map<String, String> request) {
        try {
            String name = request.get("name");
            String description = request.get("description");
            WorkflowApplicationService.WorkflowVO vo = workflowService.updateBasicInfo(id, name, description);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("更新工作流失败", e);
            return (BaseResponse<WorkflowApplicationService.WorkflowVO>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PutMapping("/{id}/definition")
    @Operation(summary = "更新工作流定义")
    public BaseResponse<WorkflowApplicationService.WorkflowVO> updateDefinition(
            @PathVariable Long id,
            @RequestBody WorkflowDefinition definition) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.updateDefinition(id, definition);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("更新工作流定义失败", e);
            return (BaseResponse<WorkflowApplicationService.WorkflowVO>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping
    @Operation(summary = "获取用户的工作流列表")
    public BaseResponse<List<WorkflowApplicationService.WorkflowVO>> listByUser(
            @RequestParam Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        try {
            List<WorkflowApplicationService.WorkflowVO> list = workflowService.listByUser(userId, page, size);
            return ResultUtils.success(list);
        } catch (Exception e) {
            log.error("获取工作流列表失败", e);
            return (BaseResponse<List<WorkflowApplicationService.WorkflowVO>>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/public")
    @Operation(summary = "获取公开的工作流列表")
    public BaseResponse<List<WorkflowApplicationService.WorkflowVO>> listPublic(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        try {
            List<WorkflowApplicationService.WorkflowVO> list = workflowService.listPublic(page, size);
            return ResultUtils.success(list);
        } catch (Exception e) {
            log.error("获取公开工作流列表失败", e);
            return (BaseResponse<List<WorkflowApplicationService.WorkflowVO>>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/publish")
    @Operation(summary = "发布工作流")
    public BaseResponse<WorkflowApplicationService.WorkflowVO> publish(@PathVariable Long id) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.publish(id);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("发布工作流失败", e);
            return (BaseResponse<WorkflowApplicationService.WorkflowVO>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/archive")
    @Operation(summary = "归档工作流")
    public BaseResponse<WorkflowApplicationService.WorkflowVO> archive(@PathVariable Long id) {
        try {
            WorkflowApplicationService.WorkflowVO vo = workflowService.archive(id);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("归档工作流失败", e);
            return (BaseResponse<WorkflowApplicationService.WorkflowVO>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除工作流")
    public BaseResponse<Void> delete(@PathVariable Long id) {
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
    public BaseResponse<WorkflowApplicationService.ExecutionResultVO> execute(
            @PathVariable Long id,
            @RequestParam Long userId,
            @RequestBody(required = false) Map<String, Object> input) {
        try {
            WorkflowApplicationService.ExecutionResultVO result = workflowService.execute(id, input, userId);
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("执行工作流失败", e);
            return (BaseResponse<WorkflowApplicationService.ExecutionResultVO>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/execute-async")
    @Operation(summary = "异步执行工作流")
    public BaseResponse<String> executeAsync(
            @PathVariable Long id,
            @RequestParam Long userId,
            @RequestBody(required = false) Map<String, Object> input) {
        try {
            String executionId = workflowService.executeAsync(id, input, userId);
            return ResultUtils.success(executionId);
        } catch (Exception e) {
            log.error("异步执行工作流失败", e);
            return (BaseResponse<String>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/executions/{executionId}")
    @Operation(summary = "获取执行状态")
    public BaseResponse<WorkflowApplicationService.ExecutionResultVO> getExecutionStatus(
            @PathVariable String executionId) {
        try {
            WorkflowApplicationService.ExecutionResultVO result = workflowService.getExecutionStatus(executionId);
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("获取执行状态失败", e);
            return (BaseResponse<WorkflowApplicationService.ExecutionResultVO>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/executions/{executionId}/cancel")
    @Operation(summary = "取消执行")
    public BaseResponse<Void> cancelExecution(@PathVariable String executionId) {
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
    public BaseResponse<List<WorkflowApplicationService.ExecutionLogVO>> getExecutionLogs(
            @PathVariable String executionId) {
        try {
            List<WorkflowApplicationService.ExecutionLogVO> logs = workflowService.getExecutionLogs(executionId);
            return ResultUtils.success(logs);
        } catch (Exception e) {
            log.error("获取执行日志失败", e);
            return (BaseResponse<List<WorkflowApplicationService.ExecutionLogVO>>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }
}
