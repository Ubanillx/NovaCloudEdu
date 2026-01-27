package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.repository.WorkflowRepository;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.WorkflowMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 工作流仓储实现
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class WorkflowRepositoryImpl implements WorkflowRepository {

    private final WorkflowMapper mapper;
    private final ObjectMapper objectMapper;

    @Override
    public Workflow save(Workflow workflow) {
        WorkflowPO po = toPO(workflow);
        
        if (po.getId() == null) {
            po.setCreateTime(LocalDateTime.now());
            po.setUpdateTime(LocalDateTime.now());
            po.setIsDelete(0);
            mapper.insert(po);
        } else {
            po.setUpdateTime(LocalDateTime.now());
            mapper.updateById(po);
        }
        
        workflow.setId(WorkflowId.of(po.getId()));
        return workflow;
    }

    @Override
    public Optional<Workflow> findById(WorkflowId id) {
        WorkflowPO po = mapper.selectById(id.value());
        if (po == null || po.getIsDelete() == 1) {
            return Optional.empty();
        }
        return Optional.of(toDomain(po));
    }

    @Override
    public List<Workflow> findByCreatorId(UserId creatorId, int page, int size) {
        int offset = page * size;
        List<WorkflowPO> pos = mapper.findByCreatorId(creatorId.value(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<Workflow> findByStatus(WorkflowStatus status, int page, int size) {
        int offset = page * size;
        List<WorkflowPO> pos = mapper.findByStatus(status.name(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<Workflow> findPublicWorkflows(int page, int size) {
        int offset = page * size;
        List<WorkflowPO> pos = mapper.findPublicWorkflows(offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public long countByCreatorId(UserId creatorId) {
        return mapper.countByCreatorId(creatorId.value());
    }

    @Override
    public void delete(WorkflowId id) {
        mapper.softDelete(id.value());
    }

    private WorkflowPO toPO(Workflow workflow) {
        WorkflowPO po = new WorkflowPO();
        if (workflow.getId() != null) {
            po.setId(workflow.getId().value());
        }
        po.setName(workflow.getName());
        po.setDescription(workflow.getDescription());
        po.setStatus(workflow.getStatus().name());
        po.setVersion(workflow.getVersion());
        po.setIsPublic(workflow.isPublic() ? 1 : 0);
        po.setCreatorId(workflow.getCreatorId().value());
        
        // 序列化工作流定义
        try {
            po.setFlowData(objectMapper.writeValueAsString(workflow.getDefinition()));
        } catch (Exception e) {
            log.error("序列化工作流定义失败", e);
            po.setFlowData("{}");
        }
        
        return po;
    }

    private Workflow toDomain(WorkflowPO po) {
        WorkflowDefinition definition;
        try {
            definition = objectMapper.readValue(po.getFlowData(), WorkflowDefinition.class);
        } catch (Exception e) {
            log.error("反序列化工作流定义失败", e);
            definition = new WorkflowDefinition();
        }
        
        return Workflow.reconstruct(
                WorkflowId.of(po.getId()),
                po.getName(),
                po.getDescription(),
                definition,
                WorkflowStatus.valueOf(po.getStatus()),
                po.getVersion(),
                po.getIsPublic() == 1,
                UserId.of(po.getCreatorId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
