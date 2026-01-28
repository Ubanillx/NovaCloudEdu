package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * 工作流触发器实体
 */
@Getter
public class WorkflowTrigger {

    private Long id;
    private WorkflowId workflowId;
    private TriggerType type;
    private String name;
    private boolean enabled;
    private Map<String, Object> config;
    private LocalDateTime lastTriggeredAt;
    private int triggerCount;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public enum TriggerType {
        SCHEDULE,   // 定时触发
        WEBHOOK,    // Webhook触发
        EVENT       // 事件触发
    }

    private WorkflowTrigger() {}

    /**
     * 创建定时触发器
     */
    public static WorkflowTrigger createScheduleTrigger(WorkflowId workflowId, String name,
                                                         String cronExpression, String timezone) {
        WorkflowTrigger trigger = new WorkflowTrigger();
        trigger.workflowId = workflowId;
        trigger.type = TriggerType.SCHEDULE;
        trigger.name = name;
        trigger.enabled = false;
        trigger.config = Map.of(
                "cronExpression", cronExpression,
                "timezone", timezone != null ? timezone : "Asia/Shanghai"
        );
        trigger.triggerCount = 0;
        trigger.createTime = LocalDateTime.now();
        trigger.updateTime = LocalDateTime.now();
        return trigger;
    }

    /**
     * 创建Webhook触发器
     */
    public static WorkflowTrigger createWebhookTrigger(WorkflowId workflowId, String name,
                                                        String secret, boolean validateSignature) {
        WorkflowTrigger trigger = new WorkflowTrigger();
        trigger.workflowId = workflowId;
        trigger.type = TriggerType.WEBHOOK;
        trigger.name = name;
        trigger.enabled = false;
        trigger.config = Map.of(
                "secret", secret != null ? secret : generateSecret(),
                "validateSignature", validateSignature,
                "webhookPath", "/api/v1/webhook/workflow/" + java.util.UUID.randomUUID()
        );
        trigger.triggerCount = 0;
        trigger.createTime = LocalDateTime.now();
        trigger.updateTime = LocalDateTime.now();
        return trigger;
    }

    /**
     * 创建事件触发器
     */
    public static WorkflowTrigger createEventTrigger(WorkflowId workflowId, String name,
                                                      String eventType, Map<String, Object> filter) {
        WorkflowTrigger trigger = new WorkflowTrigger();
        trigger.workflowId = workflowId;
        trigger.type = TriggerType.EVENT;
        trigger.name = name;
        trigger.enabled = false;
        trigger.config = Map.of(
                "eventType", eventType,
                "filter", filter != null ? filter : Map.of()
        );
        trigger.triggerCount = 0;
        trigger.createTime = LocalDateTime.now();
        trigger.updateTime = LocalDateTime.now();
        return trigger;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void enable() {
        this.enabled = true;
        this.updateTime = LocalDateTime.now();
    }

    public void disable() {
        this.enabled = false;
        this.updateTime = LocalDateTime.now();
    }

    public void recordTrigger() {
        this.lastTriggeredAt = LocalDateTime.now();
        this.triggerCount++;
    }

    public void updateConfig(Map<String, Object> config) {
        this.config = config;
        this.updateTime = LocalDateTime.now();
    }

    public String getCronExpression() {
        if (type != TriggerType.SCHEDULE) return null;
        return (String) config.get("cronExpression");
    }

    public String getWebhookPath() {
        if (type != TriggerType.WEBHOOK) return null;
        return (String) config.get("webhookPath");
    }

    public String getWebhookSecret() {
        if (type != TriggerType.WEBHOOK) return null;
        return (String) config.get("secret");
    }

    private static String generateSecret() {
        return java.util.UUID.randomUUID().toString().replace("-", "");
    }
}
