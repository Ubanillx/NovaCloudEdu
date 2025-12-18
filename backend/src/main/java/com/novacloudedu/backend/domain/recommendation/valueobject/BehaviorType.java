package com.novacloudedu.backend.domain.recommendation.valueobject;

import lombok.Getter;

@Getter
public enum BehaviorType {
    STUDY("STUDY", "学习", 3.0),
    READ("READ", "阅读", 2.0),
    COLLECT("COLLECT", "收藏", 5.0),
    LIKE("LIKE", "点赞", 4.0),
    SEARCH("SEARCH", "搜索", 1.0);

    private final String code;
    private final String description;
    private final double weight;

    BehaviorType(String code, String description, double weight) {
        this.code = code;
        this.description = description;
        this.weight = weight;
    }

    public static BehaviorType fromCode(String code) {
        for (BehaviorType type : values()) {
            if (type.code.equals(code)) {
                return type;
            }
        }
        throw new IllegalArgumentException("无效的行为类型: " + code);
    }
}
