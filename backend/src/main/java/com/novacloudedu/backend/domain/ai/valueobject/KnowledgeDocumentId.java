package com.novacloudedu.backend.domain.ai.valueobject;

import java.util.Objects;

/**
 * 知识库文档ID值对象
 */
public record KnowledgeDocumentId(Long value) {

    public KnowledgeDocumentId {
        Objects.requireNonNull(value, "文档ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("文档ID必须为正数");
        }
    }

    public static KnowledgeDocumentId of(Long value) {
        return new KnowledgeDocumentId(value);
    }
}
