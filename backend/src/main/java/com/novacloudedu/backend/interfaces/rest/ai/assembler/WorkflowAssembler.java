package com.novacloudedu.backend.interfaces.rest.ai.assembler;

import com.novacloudedu.backend.application.service.WorkflowApplicationService;
import com.novacloudedu.backend.interfaces.rest.ai.dto.response.*;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 工作流DTO转换器
 */
@Component
public class WorkflowAssembler {

    /**
     * 将WorkflowVO转换为WorkflowResponse
     */
    public WorkflowResponse toResponse(WorkflowApplicationService.WorkflowVO vo) {
        if (vo == null) {
            return null;
        }
        return WorkflowResponse.builder()
                .id(vo.getId())
                .name(vo.getName())
                .description(vo.getDescription())
                .definition(vo.getDefinition())
                .status(vo.getStatus())
                .version(vo.getVersion())
                .isPublic(vo.isPublic())
                .creatorId(vo.getCreatorId())
                .createTime(vo.getCreateTime())
                .updateTime(vo.getUpdateTime())
                .build();
    }

    /**
     * 批量转换WorkflowVO为WorkflowResponse
     */
    public List<WorkflowResponse> toResponseList(List<WorkflowApplicationService.WorkflowVO> voList) {
        if (voList == null) {
            return List.of();
        }
        return voList.stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    /**
     * 将ExecutionResultVO转换为ExecutionResultResponse
     */
    public ExecutionResultResponse toExecutionResponse(WorkflowApplicationService.ExecutionResultVO vo) {
        if (vo == null) {
            return null;
        }
        // 映射节点执行详情
        java.util.List<ExecutionResultResponse.NodeExecutionDTO> neDTOs = null;
        if (vo.getNodeExecutions() != null) {
            neDTOs = vo.getNodeExecutions().stream().map(ne ->
                ExecutionResultResponse.NodeExecutionDTO.builder()
                    .nodeId(ne.getNodeId())
                    .nodeName(ne.getNodeName())
                    .nodeType(ne.getNodeType())
                    .status(ne.getStatus())
                    .input(ne.getInput())
                    .output(ne.getOutput())
                    .errorMessage(ne.getErrorMessage())
                    .startTime(ne.getStartTime())
                    .endTime(ne.getEndTime())
                    .durationMs(ne.getDurationMs())
                    .build()
            ).collect(java.util.stream.Collectors.toList());
        }

        return ExecutionResultResponse.builder()
                .executionId(vo.getExecutionId())
                .workflowId(vo.getWorkflowId())
                .workflowName(vo.getWorkflowName())
                .workflowVersion(vo.getWorkflowVersion())
                .status(vo.getStatus())
                .input(vo.getInput())
                .output(vo.getOutput())
                .variables(vo.getVariables())
                .currentNodeId(vo.getCurrentNodeId())
                .errorMessage(vo.getErrorMessage())
                .startTime(vo.getStartTime())
                .endTime(vo.getEndTime())
                .durationMs(vo.getDurationMs())
                .nodeExecutions(neDTOs)
                .build();
    }

    /**
     * 将ExecutionLogVO转换为ExecutionLogResponse
     */
    public ExecutionLogResponse toLogResponse(WorkflowApplicationService.ExecutionLogVO vo) {
        if (vo == null) {
            return null;
        }
        return ExecutionLogResponse.builder()
                .executionId(vo.getExecutionId())
                .nodeId(vo.getNodeId())
                .nodeName(vo.getNodeName())
                .nodeType(vo.getNodeType())
                .level(vo.getLevel())
                .message(vo.getMessage())
                .durationMs(vo.getDurationMs())
                .timestamp(vo.getTimestamp())
                .build();
    }

    /**
     * 批量转换ExecutionLogVO为ExecutionLogResponse
     */
    public List<ExecutionLogResponse> toLogResponseList(List<WorkflowApplicationService.ExecutionLogVO> voList) {
        if (voList == null) {
            return List.of();
        }
        return voList.stream()
                .map(this::toLogResponse)
                .collect(Collectors.toList());
    }

    /**
     * 将WorkflowDefinitionVO转换为WorkflowDefinitionResponse
     */
    public WorkflowDefinitionResponse toDefinitionResponse(WorkflowApplicationService.WorkflowDefinitionVO vo) {
        if (vo == null) {
            return null;
        }
        return WorkflowDefinitionResponse.builder()
                .workflowId(vo.getWorkflowId())
                .workflowName(vo.getWorkflowName())
                .version(vo.getVersion())
                .nodes(vo.getNodes() != null ? vo.getNodes().stream().map(this::toNodeResponse).collect(Collectors.toList()) : List.of())
                .edges(vo.getEdges() != null ? vo.getEdges().stream().map(this::toEdgeResponse).collect(Collectors.toList()) : List.of())
                .variables(vo.getVariables() != null ? vo.getVariables().entrySet().stream()
                        .collect(Collectors.toMap(e -> e.getKey(), e -> toVariableResponse(e.getValue()))) : null)
                .settings(vo.getSettings() != null ? toSettingsResponse(vo.getSettings()) : null)
                .build();
    }

    /**
     * 将WorkflowNodeVO转换为WorkflowNodeResponse
     */
    public WorkflowNodeResponse toNodeResponse(WorkflowApplicationService.WorkflowNodeVO vo) {
        if (vo == null) {
            return null;
        }
        return WorkflowNodeResponse.builder()
                .id(vo.getId())
                .type(vo.getType())
                .typeDescription(vo.getTypeDescription())
                .name(vo.getName())
                .position(WorkflowNodeResponse.PositionDTO.builder()
                        .x(vo.getPositionX())
                        .y(vo.getPositionY())
                        .build())
                .config(vo.getConfig())
                .errorHandling(vo.getErrorHandling() != null ? WorkflowNodeResponse.ErrorHandlingConfigDTO.builder()
                        .onError(vo.getErrorHandling().getOnError())
                        .retryCount(vo.getErrorHandling().getRetryCount())
                        .retryDelayMs(vo.getErrorHandling().getRetryDelayMs())
                        .fallbackNodeId(vo.getErrorHandling().getFallbackNodeId())
                        .timeoutMs(vo.getErrorHandling().getTimeoutMs())
                        .build() : null)
                .build();
    }

    /**
     * 批量转换WorkflowNodeVO为WorkflowNodeResponse
     */
    public List<WorkflowNodeResponse> toNodeResponseList(List<WorkflowApplicationService.WorkflowNodeVO> voList) {
        if (voList == null) {
            return List.of();
        }
        return voList.stream()
                .map(this::toNodeResponse)
                .collect(Collectors.toList());
    }

    /**
     * 将WorkflowEdgeVO转换为WorkflowEdgeResponse
     */
    public WorkflowEdgeResponse toEdgeResponse(WorkflowApplicationService.WorkflowEdgeVO vo) {
        if (vo == null) {
            return null;
        }
        return WorkflowEdgeResponse.builder()
                .id(vo.getId())
                .sourceNodeId(vo.getSourceNodeId())
                .targetNodeId(vo.getTargetNodeId())
                .sourceHandle(vo.getSourceHandle())
                .targetHandle(vo.getTargetHandle())
                .condition(vo.getCondition())
                .label(vo.getLabel())
                .build();
    }

    /**
     * 批量转换WorkflowEdgeVO为WorkflowEdgeResponse
     */
    public List<WorkflowEdgeResponse> toEdgeResponseList(List<WorkflowApplicationService.WorkflowEdgeVO> voList) {
        if (voList == null) {
            return List.of();
        }
        return voList.stream()
                .map(this::toEdgeResponse)
                .collect(Collectors.toList());
    }

    /**
     * 将WorkflowVariableVO转换为WorkflowVariableResponse
     */
    public WorkflowVariableResponse toVariableResponse(WorkflowApplicationService.WorkflowVariableVO vo) {
        if (vo == null) {
            return null;
        }
        return WorkflowVariableResponse.builder()
                .name(vo.getName())
                .type(vo.getType())
                .defaultValue(vo.getDefaultValue())
                .description(vo.getDescription())
                .build();
    }

    /**
     * 批量转换WorkflowVariableVO为WorkflowVariableResponse
     */
    public List<WorkflowVariableResponse> toVariableResponseList(List<WorkflowApplicationService.WorkflowVariableVO> voList) {
        if (voList == null) {
            return List.of();
        }
        return voList.stream()
                .map(this::toVariableResponse)
                .collect(Collectors.toList());
    }

    /**
     * 将WorkflowSettingsVO转换为WorkflowSettingsDTO
     */
    public WorkflowDefinitionResponse.WorkflowSettingsDTO toSettingsResponse(WorkflowApplicationService.WorkflowSettingsVO vo) {
        if (vo == null) {
            return null;
        }
        return WorkflowDefinitionResponse.WorkflowSettingsDTO.builder()
                .maxExecutionTimeMs(vo.getMaxExecutionTimeMs())
                .enableLogging(vo.isEnableLogging())
                .logLevel(vo.getLogLevel())
                .enableDebug(vo.isEnableDebug())
                .build();
    }

    /**
     * 将WorkflowValidationVO转换为WorkflowValidationResponse
     */
    public WorkflowValidationResponse toValidationResponse(WorkflowApplicationService.WorkflowValidationVO vo) {
        if (vo == null) {
            return null;
        }
        return WorkflowValidationResponse.builder()
                .valid(vo.isValid())
                .errors(vo.getErrors() != null ? vo.getErrors().stream()
                        .map(e -> WorkflowValidationResponse.ValidationErrorDTO.builder()
                                .code(e.getCode())
                                .message(e.getMessage())
                                .nodeId(e.getNodeId())
                                .edgeId(e.getEdgeId())
                                .build())
                        .collect(Collectors.toList()) : List.of())
                .warnings(vo.getWarnings() != null ? vo.getWarnings().stream()
                        .map(w -> WorkflowValidationResponse.ValidationWarningDTO.builder()
                                .code(w.getCode())
                                .message(w.getMessage())
                                .nodeId(w.getNodeId())
                                .build())
                        .collect(Collectors.toList()) : List.of())
                .build();
    }

    /**
     * 将WorkflowTemplateVO转换为WorkflowTemplateResponse
     */
    public WorkflowTemplateResponse toTemplateResponse(WorkflowApplicationService.WorkflowTemplateVO vo) {
        if (vo == null) {
            return null;
        }
        return WorkflowTemplateResponse.builder()
                .id(vo.getId())
                .name(vo.getName())
                .description(vo.getDescription())
                .category(vo.getCategory())
                .icon(vo.getIcon())
                .definition(vo.getDefinition())
                .tags(vo.getTags())
                .isSystem(vo.isSystem())
                .isPublic(vo.isPublic())
                .creatorId(vo.getCreatorId())
                .usageCount(vo.getUsageCount())
                .createTime(vo.getCreateTime())
                .build();
    }

    /**
     * 将WorkflowTriggerVO转换为WorkflowTriggerResponse
     */
    public WorkflowTriggerResponse toTriggerResponse(WorkflowApplicationService.WorkflowTriggerVO vo) {
        if (vo == null) {
            return null;
        }
        return WorkflowTriggerResponse.builder()
                .id(vo.getId())
                .workflowId(vo.getWorkflowId())
                .type(vo.getType())
                .name(vo.getName())
                .enabled(vo.isEnabled())
                .config(vo.getConfig())
                .lastTriggeredAt(vo.getLastTriggeredAt())
                .triggerCount(vo.getTriggerCount())
                .createTime(vo.getCreateTime())
                .build();
    }

    /**
     * 将WorkflowVersionVO转换为WorkflowVersionResponse
     */
    public WorkflowVersionResponse toVersionResponse(WorkflowApplicationService.WorkflowVersionVO vo) {
        if (vo == null) {
            return null;
        }
        return WorkflowVersionResponse.builder()
                .id(vo.getId())
                .workflowId(vo.getWorkflowId())
                .version(vo.getVersion())
                .name(vo.getName())
                .description(vo.getDescription())
                .definition(vo.getDefinition())
                .publishNote(vo.getPublishNote())
                .publishedBy(vo.getPublishedBy())
                .createTime(vo.getCreateTime())
                .build();
    }
}
