package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 文档处理状态枚举
 */
public enum DocumentStatus {
    
    PENDING("待处理"),
    PROCESSING("处理中"),
    COMPLETED("已完成"),
    FAILED("失败");

    private final String description;

    DocumentStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
