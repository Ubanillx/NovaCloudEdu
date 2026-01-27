package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 工作流实体
 */
@Getter
public class Workflow {
    
    private WorkflowId id;
    private String name;
    private String description;
    private WorkflowDefinition definition;
    private WorkflowStatus status;
    private int version;
    private boolean isPublic;
    private UserId creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    
    private Workflow() {}
    
    public static Workflow create(String name, String description, UserId creatorId) {
        Workflow workflow = new Workflow();
        workflow.name = name;
        workflow.description = description;
        workflow.definition = WorkflowDefinition.builder()
                .version("1.0")
                .build();
        workflow.status = WorkflowStatus.DRAFT;
        workflow.version = 1;
        workflow.isPublic = false;
        workflow.creatorId = creatorId;
        workflow.createTime = LocalDateTime.now();
        workflow.updateTime = LocalDateTime.now();
        return workflow;
    }
    
    public static Workflow reconstruct(
            WorkflowId id,
            String name,
            String description,
            WorkflowDefinition definition,
            WorkflowStatus status,
            int version,
            boolean isPublic,
            UserId creatorId,
            LocalDateTime createTime,
            LocalDateTime updateTime) {
        Workflow workflow = new Workflow();
        workflow.id = id;
        workflow.name = name;
        workflow.description = description;
        workflow.definition = definition;
        workflow.status = status;
        workflow.version = version;
        workflow.isPublic = isPublic;
        workflow.creatorId = creatorId;
        workflow.createTime = createTime;
        workflow.updateTime = updateTime;
        return workflow;
    }
    
    public void updateBasicInfo(String name, String description) {
        if (name != null) {
            this.name = name;
        }
        if (description != null) {
            this.description = description;
        }
        this.updateTime = LocalDateTime.now();
    }
    
    public void updateDefinition(WorkflowDefinition definition) {
        this.definition = definition;
        this.version++;
        this.updateTime = LocalDateTime.now();
    }
    
    public void publish() {
        if (this.status == WorkflowStatus.ARCHIVED) {
            throw new IllegalStateException("已归档的工作流无法发布");
        }
        this.status = WorkflowStatus.PUBLISHED;
        this.updateTime = LocalDateTime.now();
    }
    
    public void archive() {
        this.status = WorkflowStatus.ARCHIVED;
        this.updateTime = LocalDateTime.now();
    }
    
    public void setPublic(boolean isPublic) {
        this.isPublic = isPublic;
        this.updateTime = LocalDateTime.now();
    }
    
    public void setId(WorkflowId id) {
        this.id = id;
    }
    
    public boolean canExecute() {
        return this.status == WorkflowStatus.PUBLISHED;
    }
}
