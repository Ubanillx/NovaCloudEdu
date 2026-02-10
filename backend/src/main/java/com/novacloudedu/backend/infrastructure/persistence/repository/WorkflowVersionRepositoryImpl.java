package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.WorkflowVersion;
import com.novacloudedu.backend.domain.ai.repository.WorkflowVersionRepository;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowDefinition;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.WorkflowVersionMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowVersionPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Repository
@RequiredArgsConstructor
public class WorkflowVersionRepositoryImpl implements WorkflowVersionRepository {

    private final WorkflowVersionMapper mapper;
    private final ObjectMapper objectMapper;

    @Override
    public void save(WorkflowVersion version) {
        WorkflowVersionPO po = toPO(version);
        mapper.insert(po);
        version.setId(po.getId());
    }

    @Override
    public Optional<WorkflowVersion> findById(Long id) {
        WorkflowVersionPO po = mapper.selectById(id);
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public Optional<WorkflowVersion> findByWorkflowIdAndVersion(WorkflowId workflowId, int version) {
        LambdaQueryWrapper<WorkflowVersionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowVersionPO::getWorkflowId, workflowId.value())
                .eq(WorkflowVersionPO::getVersion, version);
        WorkflowVersionPO po = mapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public List<WorkflowVersion> findByWorkflowId(WorkflowId workflowId) {
        LambdaQueryWrapper<WorkflowVersionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowVersionPO::getWorkflowId, workflowId.value())
                .orderByDesc(WorkflowVersionPO::getVersion);
        return mapper.selectList(wrapper).stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<WorkflowVersion> findLatestByWorkflowId(WorkflowId workflowId) {
        LambdaQueryWrapper<WorkflowVersionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowVersionPO::getWorkflowId, workflowId.value())
                .orderByDesc(WorkflowVersionPO::getVersion)
                .last("LIMIT 1");
        WorkflowVersionPO po = mapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public void deleteByWorkflowId(WorkflowId workflowId) {
        LambdaQueryWrapper<WorkflowVersionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowVersionPO::getWorkflowId, workflowId.value());
        mapper.delete(wrapper);
    }

    private WorkflowVersionPO toPO(WorkflowVersion version) {
        WorkflowVersionPO po = new WorkflowVersionPO();
        po.setId(version.getId());
        po.setWorkflowId(version.getWorkflowId().value());
        po.setVersion(version.getVersion());
        po.setName(version.getName());
        po.setDescription(version.getDescription());
        po.setPublishNote(version.getPublishNote());
        po.setPublishedBy(version.getPublishedBy().value());

        try {
            po.setDefinition(objectMapper.writeValueAsString(version.getDefinition()));
        } catch (Exception e) {
            log.error("序列化版本定义失败", e);
        }

        return po;
    }

    private WorkflowVersion toDomain(WorkflowVersionPO po) {
        WorkflowDefinition definition = null;
        try {
            if (po.getDefinition() != null) {
                definition = objectMapper.readValue(po.getDefinition(), WorkflowDefinition.class);
                definition.flattenChildren();
            }
        } catch (Exception e) {
            log.error("反序列化版本定义失败", e);
        }

        return WorkflowVersion.reconstruct(
                po.getId(),
                WorkflowId.of(po.getWorkflowId()),
                po.getVersion(),
                po.getName(),
                po.getDescription(),
                definition,
                po.getPublishNote(),
                UserId.of(po.getPublishedBy()),
                po.getCreateTime()
        );
    }
}
