package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.WorkflowTemplate;
import com.novacloudedu.backend.domain.ai.repository.WorkflowTemplateRepository;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowDefinition;
import com.novacloudedu.backend.infrastructure.persistence.mapper.WorkflowTemplateMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowTemplatePO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Repository
@RequiredArgsConstructor
public class WorkflowTemplateRepositoryImpl implements WorkflowTemplateRepository {

    private final WorkflowTemplateMapper mapper;
    private final ObjectMapper objectMapper;

    @Override
    public void save(WorkflowTemplate template) {
        WorkflowTemplatePO po = toPO(template);
        mapper.insert(po);
        template.setId(po.getId());
    }

    @Override
    public void update(WorkflowTemplate template) {
        WorkflowTemplatePO po = toPO(template);
        mapper.updateById(po);
    }

    @Override
    public Optional<WorkflowTemplate> findById(Long id) {
        WorkflowTemplatePO po = mapper.selectById(id);
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public List<WorkflowTemplate> findByCategory(String category) {
        LambdaQueryWrapper<WorkflowTemplatePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowTemplatePO::getCategory, category)
                .eq(WorkflowTemplatePO::getDeleted, 0)
                .orderByDesc(WorkflowTemplatePO::getUsageCount);
        return mapper.selectList(wrapper).stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<WorkflowTemplate> findPublicTemplates(int page, int size) {
        Page<WorkflowTemplatePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<WorkflowTemplatePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowTemplatePO::getIsPublic, 1)
                .eq(WorkflowTemplatePO::getDeleted, 0)
                .orderByDesc(WorkflowTemplatePO::getUsageCount);
        return mapper.selectPage(pageParam, wrapper).getRecords().stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<WorkflowTemplate> findSystemTemplates() {
        LambdaQueryWrapper<WorkflowTemplatePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowTemplatePO::getIsSystem, 1)
                .eq(WorkflowTemplatePO::getDeleted, 0)
                .orderByAsc(WorkflowTemplatePO::getCategory);
        return mapper.selectList(wrapper).stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<WorkflowTemplate> findByCreatorId(Long creatorId) {
        LambdaQueryWrapper<WorkflowTemplatePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowTemplatePO::getCreatorId, creatorId)
                .eq(WorkflowTemplatePO::getDeleted, 0)
                .orderByDesc(WorkflowTemplatePO::getCreateTime);
        return mapper.selectList(wrapper).stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<WorkflowTemplate> search(String keyword, String category, int page, int size) {
        Page<WorkflowTemplatePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<WorkflowTemplatePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowTemplatePO::getDeleted, 0)
                .eq(WorkflowTemplatePO::getIsPublic, 1);
        
        if (keyword != null && !keyword.isBlank()) {
            wrapper.and(w -> w.like(WorkflowTemplatePO::getName, keyword)
                    .or().like(WorkflowTemplatePO::getDescription, keyword));
        }
        if (category != null && !category.isBlank()) {
            wrapper.eq(WorkflowTemplatePO::getCategory, category);
        }
        
        wrapper.orderByDesc(WorkflowTemplatePO::getUsageCount);
        return mapper.selectPage(pageParam, wrapper).getRecords().stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Long id) {
        WorkflowTemplatePO po = new WorkflowTemplatePO();
        po.setId(id);
        po.setDeleted(1);
        mapper.updateById(po);
    }

    @Override
    public long count() {
        LambdaQueryWrapper<WorkflowTemplatePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowTemplatePO::getDeleted, 0);
        return mapper.selectCount(wrapper);
    }

    private WorkflowTemplatePO toPO(WorkflowTemplate template) {
        WorkflowTemplatePO po = new WorkflowTemplatePO();
        po.setId(template.getId());
        po.setName(template.getName());
        po.setDescription(template.getDescription());
        po.setCategory(template.getCategory());
        po.setIcon(template.getIcon());
        po.setIsSystem(template.isSystem() ? 1 : 0);
        po.setIsPublic(template.isPublic() ? 1 : 0);
        po.setCreatorId(template.getCreatorId());
        po.setUsageCount(template.getUsageCount());

        try {
            po.setDefinition(objectMapper.writeValueAsString(template.getDefinition()));
            po.setTags(objectMapper.writeValueAsString(template.getTags()));
        } catch (Exception e) {
            log.error("序列化模板数据失败", e);
        }

        return po;
    }

    private WorkflowTemplate toDomain(WorkflowTemplatePO po) {
        WorkflowDefinition definition = null;
        List<String> tags = null;
        
        try {
            if (po.getDefinition() != null) {
                definition = objectMapper.readValue(po.getDefinition(), WorkflowDefinition.class);
            }
            if (po.getTags() != null) {
                tags = objectMapper.readValue(po.getTags(), new TypeReference<>() {});
            }
        } catch (Exception e) {
            log.error("反序列化模板数据失败", e);
        }

        // 使用反射或工厂方法重建实体
        return reconstructTemplate(po, definition, tags);
    }

    private WorkflowTemplate reconstructTemplate(WorkflowTemplatePO po, WorkflowDefinition definition, List<String> tags) {
        // 由于WorkflowTemplate没有公开的reconstruct方法，这里通过创建后设置的方式
        WorkflowTemplate template;
        if (po.getIsSystem() == 1) {
            template = WorkflowTemplate.createSystemTemplate(
                    po.getName(), po.getDescription(), po.getCategory(),
                    po.getIcon(), definition, tags);
        } else {
            template = WorkflowTemplate.create(
                    po.getName(), po.getDescription(), po.getCategory(),
                    definition, po.getCreatorId());
        }
        template.setId(po.getId());
        if (po.getIsPublic() == 1) {
            template.setPublic(true);
        }
        return template;
    }
}
