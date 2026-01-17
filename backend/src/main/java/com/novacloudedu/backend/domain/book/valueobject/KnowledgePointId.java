package com.novacloudedu.backend.domain.book.valueobject;

import lombok.AccessLevel;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class KnowledgePointId {
    private Long value;

    private KnowledgePointId(Long value) {
        this.value = value;
    }

    public static KnowledgePointId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("知识点ID必须大于0");
        }
        return new KnowledgePointId(value);
    }
}
