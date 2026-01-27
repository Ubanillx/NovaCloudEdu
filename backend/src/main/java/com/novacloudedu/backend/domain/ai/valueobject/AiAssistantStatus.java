package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * AI助手状态枚举
 */
public enum AiAssistantStatus {
    
    DRAFT("草稿"),
    PUBLISHED("已发布"),
    ARCHIVED("已归档");

    private final String description;

    AiAssistantStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
