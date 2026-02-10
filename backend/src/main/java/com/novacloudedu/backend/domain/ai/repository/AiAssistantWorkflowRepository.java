package com.novacloudedu.backend.domain.ai.repository;

import java.util.List;

/**
 * AI助手工作流关联仓储接口
 */
public interface AiAssistantWorkflowRepository {

    void bindWorkflow(Long assistantId, Long workflowId);

    void unbindWorkflow(Long assistantId, Long workflowId);

    void unbindAllByAssistantId(Long assistantId);

    void unbindAllByWorkflowId(Long workflowId);

    List<Long> findWorkflowIdsByAssistantId(Long assistantId);

    List<Long> findAssistantIdsByWorkflowId(Long workflowId);

    boolean exists(Long assistantId, Long workflowId);
}
