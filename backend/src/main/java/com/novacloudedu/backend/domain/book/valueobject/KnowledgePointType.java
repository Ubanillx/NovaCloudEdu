package com.novacloudedu.backend.domain.book.valueobject;

/**
 * 知识点类型枚举
 */
public enum KnowledgePointType {
    CONCEPT("概念"),
    TERM("术语"),
    FORMULA("公式"),
    PRINCIPLE("原理"),
    METHOD("方法");

    private final String description;

    KnowledgePointType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
