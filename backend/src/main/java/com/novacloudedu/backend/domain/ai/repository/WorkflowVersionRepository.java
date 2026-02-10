package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.WorkflowVersion;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;

import java.util.List;
import java.util.Optional;

/**
 * 工作流版本历史仓储接口
 */
public interface WorkflowVersionRepository {

    void save(WorkflowVersion version);

    Optional<WorkflowVersion> findById(Long id);

    Optional<WorkflowVersion> findByWorkflowIdAndVersion(WorkflowId workflowId, int version);

    List<WorkflowVersion> findByWorkflowId(WorkflowId workflowId);

    Optional<WorkflowVersion> findLatestByWorkflowId(WorkflowId workflowId);

    void deleteByWorkflowId(WorkflowId workflowId);
}
