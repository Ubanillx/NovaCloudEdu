package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.WorkflowTrigger;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;

import java.util.List;
import java.util.Optional;

/**
 * 工作流触发器仓储接口
 */
public interface WorkflowTriggerRepository {

    void save(WorkflowTrigger trigger);

    void update(WorkflowTrigger trigger);

    Optional<WorkflowTrigger> findById(Long id);

    List<WorkflowTrigger> findByWorkflowId(WorkflowId workflowId);

    List<WorkflowTrigger> findEnabledScheduleTriggers();

    Optional<WorkflowTrigger> findByWebhookPath(String webhookPath);

    void delete(Long id);

    void deleteByWorkflowId(WorkflowId workflowId);
}
