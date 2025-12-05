package com.novacloudedu.backend.domain.social.valueobject;

import lombok.Getter;

/**
 * 好友关系状态枚举
 */
@Getter
public enum FriendRelationshipStatus {
    
    PENDING("pending", "待确认"),
    ACCEPTED("accepted", "已接受"),
    BLOCKED("blocked", "已拉黑");

    private final String value;
    private final String description;

    FriendRelationshipStatus(String value, String description) {
        this.value = value;
        this.description = description;
    }

    public static FriendRelationshipStatus fromValue(String value) {
        for (FriendRelationshipStatus status : values()) {
            if (status.value.equals(value)) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的好友关系状态: " + value);
    }
}
