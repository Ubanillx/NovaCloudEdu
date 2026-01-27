package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 工作流仓储接口
 */
public interface WorkflowRepository {

    Workflow save(Workflow workflow);

    Optional<Workflow> findById(WorkflowId id);

    List<Workflow> findByCreatorId(UserId creatorId, int page, int size);

    List<Workflow> findByStatus(WorkflowStatus status, int page, int size);

    List<Workflow> findPublicWorkflows(int page, int size);

    long countByCreatorId(UserId creatorId);

    void delete(WorkflowId id);
}
