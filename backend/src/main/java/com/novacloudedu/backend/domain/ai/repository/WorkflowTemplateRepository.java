package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.WorkflowTemplate;

import java.util.List;
import java.util.Optional;

/**
 * 工作流模板仓储接口
 */
public interface WorkflowTemplateRepository {

    void save(WorkflowTemplate template);

    void update(WorkflowTemplate template);

    Optional<WorkflowTemplate> findById(Long id);

    List<WorkflowTemplate> findByCategory(String category);

    List<WorkflowTemplate> findPublicTemplates(int page, int size);

    List<WorkflowTemplate> findSystemTemplates();

    List<WorkflowTemplate> findByCreatorId(Long creatorId);

    List<WorkflowTemplate> search(String keyword, String category, int page, int size);

    void delete(Long id);

    long count();
}
