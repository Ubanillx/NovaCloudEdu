package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.WorkflowTrigger;
import com.novacloudedu.backend.domain.ai.repository.WorkflowTriggerRepository;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.WorkflowTriggerMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowTriggerPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Repository
@RequiredArgsConstructor
public class WorkflowTriggerRepositoryImpl implements WorkflowTriggerRepository {

    private final WorkflowTriggerMapper mapper;
    private final ObjectMapper objectMapper;

    @Override
    public void save(WorkflowTrigger trigger) {
        WorkflowTriggerPO po = toPO(trigger);
        mapper.insert(po);
        trigger.setId(po.getId());
    }

    @Override
    public void update(WorkflowTrigger trigger) {
        WorkflowTriggerPO po = toPO(trigger);
        mapper.updateById(po);
    }

    @Override
    public Optional<WorkflowTrigger> findById(Long id) {
        WorkflowTriggerPO po = mapper.selectById(id);
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public List<WorkflowTrigger> findByWorkflowId(WorkflowId workflowId) {
        LambdaQueryWrapper<WorkflowTriggerPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowTriggerPO::getWorkflowId, workflowId.value())
                .eq(WorkflowTriggerPO::getDeleted, 0);
        return mapper.selectList(wrapper).stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<WorkflowTrigger> findEnabledScheduleTriggers() {
        LambdaQueryWrapper<WorkflowTriggerPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowTriggerPO::getType, "SCHEDULE")
                .eq(WorkflowTriggerPO::getEnabled, 1)
                .eq(WorkflowTriggerPO::getDeleted, 0);
        return mapper.selectList(wrapper).stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<WorkflowTrigger> findByWebhookPath(String webhookPath) {
        LambdaQueryWrapper<WorkflowTriggerPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowTriggerPO::getType, "WEBHOOK")
                .eq(WorkflowTriggerPO::getDeleted, 0)
                .like(WorkflowTriggerPO::getConfig, webhookPath);
        
        List<WorkflowTriggerPO> list = mapper.selectList(wrapper);
        for (WorkflowTriggerPO po : list) {
            WorkflowTrigger trigger = toDomain(po);
            if (webhookPath.equals(trigger.getWebhookPath())) {
                return Optional.of(trigger);
            }
        }
        return Optional.empty();
    }

    @Override
    public void delete(Long id) {
        WorkflowTriggerPO po = new WorkflowTriggerPO();
        po.setId(id);
        po.setDeleted(1);
        mapper.updateById(po);
    }

    @Override
    public void deleteByWorkflowId(WorkflowId workflowId) {
        LambdaQueryWrapper<WorkflowTriggerPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowTriggerPO::getWorkflowId, workflowId.value());
        
        WorkflowTriggerPO update = new WorkflowTriggerPO();
        update.setDeleted(1);
        mapper.update(update, wrapper);
    }

    private WorkflowTriggerPO toPO(WorkflowTrigger trigger) {
        WorkflowTriggerPO po = new WorkflowTriggerPO();
        po.setId(trigger.getId());
        po.setWorkflowId(trigger.getWorkflowId().value());
        po.setType(trigger.getType().name());
        po.setName(trigger.getName());
        po.setEnabled(trigger.isEnabled() ? 1 : 0);
        po.setLastTriggeredAt(trigger.getLastTriggeredAt());
        po.setTriggerCount(trigger.getTriggerCount());

        try {
            po.setConfig(objectMapper.writeValueAsString(trigger.getConfig()));
        } catch (Exception e) {
            log.error("序列化触发器配置失败", e);
        }

        return po;
    }

    private WorkflowTrigger toDomain(WorkflowTriggerPO po) {
        Map<String, Object> config = null;
        try {
            if (po.getConfig() != null) {
                config = objectMapper.readValue(po.getConfig(), new TypeReference<>() {});
            }
        } catch (Exception e) {
            log.error("反序列化触发器配置失败", e);
        }

        WorkflowTrigger.TriggerType type = WorkflowTrigger.TriggerType.valueOf(po.getType());
        WorkflowId workflowId = WorkflowId.of(po.getWorkflowId());

        // 根据类型创建触发器
        WorkflowTrigger trigger;
        switch (type) {
            case SCHEDULE -> {
                String cron = config != null ? (String) config.get("cronExpression") : "";
                String timezone = config != null ? (String) config.get("timezone") : "Asia/Shanghai";
                trigger = WorkflowTrigger.createScheduleTrigger(workflowId, po.getName(), cron, timezone);
            }
            case WEBHOOK -> {
                String secret = config != null ? (String) config.get("secret") : "";
                Boolean validate = config != null ? (Boolean) config.getOrDefault("validateSignature", false) : false;
                trigger = WorkflowTrigger.createWebhookTrigger(workflowId, po.getName(), secret, validate);
            }
            case EVENT -> {
                String eventType = config != null ? (String) config.get("eventType") : "";
                @SuppressWarnings("unchecked")
                Map<String, Object> filter = config != null ? (Map<String, Object>) config.get("filter") : null;
                trigger = WorkflowTrigger.createEventTrigger(workflowId, po.getName(), eventType, filter);
            }
            default -> throw new IllegalArgumentException("未知的触发器类型: " + type);
        }

        // 设置ID和状态
        trigger.setId(po.getId());
        if (po.getEnabled() == 1) {
            trigger.enable();
        }
        
        // 通过反射设置触发次数和最后触发时间
        setFieldValue(trigger, "triggerCount", po.getTriggerCount());
        setFieldValue(trigger, "lastTriggeredAt", po.getLastTriggeredAt());
        setFieldValue(trigger, "config", config);

        return trigger;
    }

    private void setFieldValue(Object obj, String fieldName, Object value) {
        try {
            Field field = obj.getClass().getDeclaredField(fieldName);
            field.setAccessible(true);
            field.set(obj, value);
        } catch (Exception e) {
            log.warn("设置字段值失败: field={}, error={}", fieldName, e.getMessage());
        }
    }
}
