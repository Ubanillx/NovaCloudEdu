package com.novacloudedu.backend.domain.ai.valueobject;

import java.util.Objects;

/**
 * 知识库ID值对象
 */
public record KnowledgeBaseId(Long value) {

    public KnowledgeBaseId {
        Objects.requireNonNull(value, "知识库ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("知识库ID必须为正数");
        }
    }

    public static KnowledgeBaseId of(Long value) {
        return new KnowledgeBaseId(value);
    }
}
