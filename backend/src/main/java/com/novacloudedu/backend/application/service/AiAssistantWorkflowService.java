package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.repository.WorkflowRepository;
import com.novacloudedu.backend.domain.ai.service.WorkflowEngine;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AiAssistantWorkflowMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiAssistantWorkflowPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
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
}
