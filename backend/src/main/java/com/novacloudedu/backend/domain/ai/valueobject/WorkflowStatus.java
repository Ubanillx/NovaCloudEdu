package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 工作流状态
 */
public enum WorkflowStatus {
    DRAFT("草稿"),
    PUBLISHED("已发布"),
    ARCHIVED("已归档");
    
    private final String description;
    
    WorkflowStatus(String description) {
        this.description = description;
    }
    
    public String getDescription() {
        return description;
    }
}
