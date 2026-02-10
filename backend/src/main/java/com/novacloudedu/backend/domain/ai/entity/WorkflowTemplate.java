package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.WorkflowDefinition;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 工作流模板实体
 */
@Getter
public class WorkflowTemplate {

    private Long id;
    private String name;
    private String description;
    private String category;
    private String icon;
    private WorkflowDefinition definition;
    private List<String> tags;
    private boolean isSystem;
    private boolean isPublic;
    private Long creatorId;
    private int usageCount;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    private WorkflowTemplate() {}

    public static WorkflowTemplate create(String name, String description, String category,
                                          WorkflowDefinition definition, Long creatorId) {
        WorkflowTemplate template = new WorkflowTemplate();
        template.name = name;
        template.description = description;
        template.category = category;
        template.definition = definition;
        template.isSystem = false;
        template.isPublic = false;
        template.creatorId = creatorId;
        template.usageCount = 0;
        template.createTime = LocalDateTime.now();
        template.updateTime = LocalDateTime.now();
        return template;
    }

    public static WorkflowTemplate createSystemTemplate(String name, String description, 
                                                         String category, String icon,
                                                         WorkflowDefinition definition,
                                                         List<String> tags) {
        WorkflowTemplate template = new WorkflowTemplate();
        template.name = name;
        template.description = description;
        template.category = category;
        template.icon = icon;
        template.definition = definition;
        template.tags = tags;
        template.isSystem = true;
        template.isPublic = true;
        template.usageCount = 0;
        template.createTime = LocalDateTime.now();
        template.updateTime = LocalDateTime.now();
        return template;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void incrementUsage() {
        this.usageCount++;
    }

    public void setPublic(boolean isPublic) {
        this.isPublic = isPublic;
        this.updateTime = LocalDateTime.now();
    }

    public void update(String name, String description, String category, List<String> tags) {
        if (name != null) this.name = name;
        if (description != null) this.description = description;
        if (category != null) this.category = category;
        if (tags != null) this.tags = tags;
        this.updateTime = LocalDateTime.now();
    }

    public void updateDefinition(WorkflowDefinition definition) {
        this.definition = definition;
        this.updateTime = LocalDateTime.now();
    }

    public void setIcon(String icon) {
        this.icon = icon;
        this.updateTime = LocalDateTime.now();
    }

    public void setTags(List<String> tags) {
        this.tags = tags;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 从模板创建工作流
     */
    public Workflow createWorkflow(String workflowName, String workflowDescription, 
                                    com.novacloudedu.backend.domain.user.valueobject.UserId userId) {
        if (this.definition == null) {
            throw new IllegalStateException("模板定义为空，无法创建工作流");
        }
        Workflow workflow = Workflow.create(
                workflowName != null ? workflowName : this.name,
                workflowDescription != null ? workflowDescription : this.description,
                userId
        );
        workflow.updateDefinition(this.definition.copy());
        this.incrementUsage();
        return workflow;
    }
}
