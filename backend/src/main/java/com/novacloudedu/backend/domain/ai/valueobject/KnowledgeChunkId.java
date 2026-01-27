package com.novacloudedu.backend.domain.ai.valueobject;

import java.util.Objects;

/**
 * 知识库分块ID值对象
 */
public record KnowledgeChunkId(Long value) {

    public KnowledgeChunkId {
        Objects.requireNonNull(value, "分块ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("分块ID必须为正数");
        }
    }

    public static KnowledgeChunkId of(Long value) {
        return new KnowledgeChunkId(value);
    }
}
