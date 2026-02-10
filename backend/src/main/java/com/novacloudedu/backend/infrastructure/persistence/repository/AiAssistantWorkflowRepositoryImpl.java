package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.novacloudedu.backend.domain.ai.repository.AiAssistantWorkflowRepository;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AiAssistantWorkflowMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiAssistantWorkflowPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Repository
@RequiredArgsConstructor
public class AiAssistantWorkflowRepositoryImpl implements AiAssistantWorkflowRepository {

    private final AiAssistantWorkflowMapper mapper;

    @Override
    public void bindWorkflow(Long assistantId, Long workflowId) {
        if (mapper.existsByAssistantIdAndWorkflowId(assistantId, workflowId)) {
            return;
        }
        AiAssistantWorkflowPO po = new AiAssistantWorkflowPO();
        po.setAssistantId(assistantId);
        po.setWorkflowId(workflowId);
        po.setCreateTime(LocalDateTime.now());
        po.setUpdateTime(LocalDateTime.now());
        mapper.insert(po);
    }

    @Override
    public void unbindWorkflow(Long assistantId, Long workflowId) {
        mapper.deleteByAssistantIdAndWorkflowId(assistantId, workflowId);
    }

    @Override
    public void unbindAllByAssistantId(Long assistantId) {
        mapper.deleteByAssistantId(assistantId);
    }

    @Override
    public void unbindAllByWorkflowId(Long workflowId) {
        mapper.deleteByWorkflowId(workflowId);
    }

    @Override
    public List<Long> findWorkflowIdsByAssistantId(Long assistantId) {
        return mapper.findWorkflowIdsByAssistantId(assistantId);
    }

    @Override
    public List<Long> findAssistantIdsByWorkflowId(Long workflowId) {
        return mapper.findAssistantIdsByWorkflowId(workflowId);
    }

    @Override
    public boolean exists(Long assistantId, Long workflowId) {
        return mapper.existsByAssistantIdAndWorkflowId(assistantId, workflowId);
    }
}
