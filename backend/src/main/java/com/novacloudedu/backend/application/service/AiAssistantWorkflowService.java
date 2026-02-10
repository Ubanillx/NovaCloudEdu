package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.repository.WorkflowRepository;
import com.novacloudedu.backend.domain.ai.service.WorkflowEngine;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowDefinition;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AiAssistantWorkflowMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiAssistantWorkflowPO;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * AI助手工作流绑定服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AiAssistantWorkflowService {

    private final AiAssistantWorkflowMapper mapper;
    private final WorkflowRepository workflowRepository;
    private final WorkflowEngine workflowEngine;

    /**
     * 绑定工作流到AI助手
     */
    @Transactional
    public void bindWorkflow(Long assistantId, Long workflowId) {
        log.info("绑定工作流到AI助手: assistantId={}, workflowId={}", assistantId, workflowId);
        
        if (mapper.existsByAssistantIdAndWorkflowId(assistantId, workflowId)) {
            log.info("工作流已绑定，跳过");
            return;
        }
        
        AiAssistantWorkflowPO po = new AiAssistantWorkflowPO();
        po.setAssistantId(assistantId);
        po.setWorkflowId(workflowId);
        po.setCreateTime(LocalDateTime.now());
        po.setUpdateTime(LocalDateTime.now());
        
        mapper.insert(po);
    }

    /**
     * 解绑工作流
     */
    @Transactional
    public void unbindWorkflow(Long assistantId, Long workflowId) {
        log.info("解绑工作流: assistantId={}, workflowId={}", assistantId, workflowId);
        mapper.deleteByAssistantIdAndWorkflowId(assistantId, workflowId);
    }

    /**
     * 获取AI助手绑定的工作流ID列表
     */
    public List<Long> getWorkflowIds(Long assistantId) {
        return mapper.findWorkflowIdsByAssistantId(assistantId);
    }

    /**
     * 获取使用某工作流的AI助手ID列表
     */
    public List<Long> getAssistantIds(Long workflowId) {
        return mapper.findAssistantIdsByWorkflowId(workflowId);
    }

    /**
     * 替换AI助手的所有工作流绑定
     */
    @Transactional
    public void replaceWorkflows(Long assistantId, List<Long> workflowIds) {
        log.info("替换AI助手工作流绑定: assistantId={}, workflowIds={}", assistantId, workflowIds);
        
        // 删除现有绑定
        mapper.deleteByAssistantId(assistantId);
        
        // 添加新绑定
        for (Long workflowId : workflowIds) {
            AiAssistantWorkflowPO po = new AiAssistantWorkflowPO();
            po.setAssistantId(assistantId);
            po.setWorkflowId(workflowId);
            po.setCreateTime(LocalDateTime.now());
            po.setUpdateTime(LocalDateTime.now());
            mapper.insert(po);
        }
    }

    /**
     * 执行AI助手绑定的工作流
     */
    public Map<String, Object> executeWorkflow(Long assistantId, Long workflowId, 
                                                Map<String, Object> input, Long userId) {
        log.info("执行AI助手工作流: assistantId={}, workflowId={}, userId={}", 
                assistantId, workflowId, userId);
        
        // 验证绑定关系
        if (!mapper.existsByAssistantIdAndWorkflowId(assistantId, workflowId)) {
            throw new IllegalArgumentException("工作流未绑定到该AI助手");
        }
        
        // 获取工作流
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        // 执行工作流
        var execution = workflowEngine.execute(workflow, input, UserId.of(userId));
        
        return execution.getOutput();
    }

    /**
     * 异步执行AI助手绑定的工作流
     */
    public String executeWorkflowAsync(Long assistantId, Long workflowId, 
                                       Map<String, Object> input, Long userId) {
        log.info("异步执行AI助手工作流: assistantId={}, workflowId={}, userId={}", 
                assistantId, workflowId, userId);
        
        // 验证绑定关系
        if (!mapper.existsByAssistantIdAndWorkflowId(assistantId, workflowId)) {
            throw new IllegalArgumentException("工作流未绑定到该AI助手");
        }
        
        // 获取工作流
        Workflow workflow = workflowRepository.findById(WorkflowId.of(workflowId))
                .orElseThrow(() -> new IllegalArgumentException("工作流不存在: " + workflowId));
        
        // 异步执行工作流
        var executionId = workflowEngine.executeAsync(workflow, input, UserId.of(userId));
        
        return executionId.value();
    }

    // ==================== 工作流技能（Skill）====================

    /**
     * 获取 AI 助手绑定的工作流技能列表（含描述、输入参数、输出参数）。
     * 从每个工作流的 definition 中提取 START 节点的 inputParameters 和 END 节点的 outputVariables。
     */
    public List<WorkflowSkillVO> getWorkflowSkills(Long assistantId) {
        List<Long> workflowIds = mapper.findWorkflowIdsByAssistantId(assistantId);
        if (workflowIds == null || workflowIds.isEmpty()) {
            return Collections.emptyList();
        }

        List<WorkflowSkillVO> skills = new ArrayList<>();
        for (Long wfId : workflowIds) {
            workflowRepository.findById(WorkflowId.of(wfId)).ifPresent(workflow -> {
                WorkflowSkillVO skill = buildSkillVO(workflow);
                if (skill != null) {
                    skills.add(skill);
                }
            });
        }
        return skills;
    }

    /**
     * 从 Workflow 实体构建技能 VO
     */
    @SuppressWarnings("unchecked")
    private WorkflowSkillVO buildSkillVO(Workflow workflow) {
        WorkflowSkillVO vo = new WorkflowSkillVO();
        vo.setWorkflowId(workflow.getId().value());
        vo.setName(workflow.getName());
        vo.setDescription(workflow.getDescription());
        vo.setStatus(workflow.getStatus().name());

        WorkflowDefinition def = workflow.getDefinition();
        if (def == null || def.getNodes() == null) {
            vo.setInputParameters(Collections.emptyList());
            vo.setOutputVariables(Collections.emptyList());
            return vo;
        }

        // 提取 START 节点的 inputParameters
        List<SkillParamVO> inputParams = new ArrayList<>();
        WorkflowNode startNode = def.getNodes().stream()
                .filter(n -> n.getType() == NodeType.START)
                .findFirst().orElse(null);
        if (startNode != null && startNode.getConfig() != null) {
            Object raw = startNode.getConfig().get("inputParameters");
            if (raw instanceof List<?> list) {
                for (Object item : list) {
                    if (item instanceof Map<?, ?> m) {
                        SkillParamVO p = new SkillParamVO();
                        p.setName((String) m.get("name"));
                        p.setType((String) m.get("type"));
                        p.setDescription((String) m.get("description"));
                        p.setRequired(Boolean.TRUE.equals(m.get("required")));
                        p.setDefaultValue(m.get("defaultValue") != null ? String.valueOf(m.get("defaultValue")) : null);
                        inputParams.add(p);
                    }
                }
            }
        }
        vo.setInputParameters(inputParams);

        // 提取 END 节点的 outputVariables
        List<SkillOutputVO> outputVars = new ArrayList<>();
        WorkflowNode endNode = def.getNodes().stream()
                .filter(n -> n.getType() == NodeType.END)
                .findFirst().orElse(null);
        if (endNode != null && endNode.getConfig() != null) {
            Object raw = endNode.getConfig().get("outputVariables");
            if (raw instanceof List<?> list) {
                for (Object item : list) {
                    if (item instanceof Map<?, ?> m) {
                        SkillOutputVO o = new SkillOutputVO();
                        o.setName((String) m.get("name"));
                        o.setSourceVariable((String) m.get("sourceVariable"));
                        outputVars.add(o);
                    }
                }
            }
        }
        vo.setOutputVariables(outputVars);

        return vo;
    }

    /**
     * 将工作流技能列表构建为 LLM system prompt 片段，
     * 供 AI 助手对话时注入，使 LLM 知道可用的工作流技能。
     */
    public String buildSkillsPrompt(List<WorkflowSkillVO> skills) {
        if (skills == null || skills.isEmpty()) return null;

        StringBuilder sb = new StringBuilder();
        sb.append("\n\n## 可用工作流技能\n");
        sb.append("你拥有以下工作流技能，当用户请求与某个技能的描述匹配时，");
        sb.append("请使用 JSON 标记调用该技能。格式：\n");
        sb.append("```\n[CALL_WORKFLOW:{\"workflowId\":工作流ID, \"params\":{参数名:参数值}}]\n```\n");
        sb.append("调用后系统会自动执行并返回结果。每次回复中最多调用一个技能。\n\n");

        for (WorkflowSkillVO skill : skills) {
            sb.append("### 技能: ").append(skill.getName()).append("\n");
            if (skill.getDescription() != null && !skill.getDescription().isBlank()) {
                sb.append("描述: ").append(skill.getDescription()).append("\n");
            }
            sb.append("工作流ID: ").append(skill.getWorkflowId()).append("\n");

            if (!skill.getInputParameters().isEmpty()) {
                sb.append("输入参数:\n");
                for (SkillParamVO p : skill.getInputParameters()) {
                    sb.append("  - ").append(p.getName())
                      .append(" (").append(p.getType() != null ? p.getType() : "STRING").append(")")
                      .append(p.isRequired() ? " [必填]" : " [可选]");
                    if (p.getDescription() != null && !p.getDescription().isBlank()) {
                        sb.append(": ").append(p.getDescription());
                    }
                    if (p.getDefaultValue() != null && !p.getDefaultValue().isBlank()) {
                        sb.append(", 默认: ").append(p.getDefaultValue());
                    }
                    sb.append("\n");
                }
            }

            if (!skill.getOutputVariables().isEmpty()) {
                sb.append("输出:\n");
                for (SkillOutputVO o : skill.getOutputVariables()) {
                    sb.append("  - ").append(o.getName());
                    if (o.getSourceVariable() != null) {
                        sb.append(" (来源: ").append(o.getSourceVariable()).append(")");
                    }
                    sb.append("\n");
                }
            }
            sb.append("\n");
        }
        return sb.toString();
    }

    // ==================== VO 定义 ====================

    @Data
    public static class WorkflowSkillVO {
        private Long workflowId;
        private String name;
        private String description;
        private String status;
        private List<SkillParamVO> inputParameters;
        private List<SkillOutputVO> outputVariables;
    }

    @Data
    public static class SkillParamVO {
        private String name;
        private String type;
        private String description;
        private boolean required;
        private String defaultValue;
    }

    @Data
    public static class SkillOutputVO {
        private String name;
        private String sourceVariable;
    }
}
