package com.novacloudedu.backend.domain.social.valueobject;

import lombok.Getter;

/**
 * 好友申请状态枚举
 */
@Getter
public enum FriendRequestStatus {
    
    PENDING("pending", "待处理"),
    ACCEPTED("accepted", "已接受"),
    REJECTED("rejected", "已拒绝");

    private final String value;
    private final String description;

    FriendRequestStatus(String value, String description) {
        this.value = value;
        this.description = description;
    }

    public static FriendRequestStatus fromValue(String value) {
        for (FriendRequestStatus status : values()) {
            if (status.value.equals(value)) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的好友申请状态: " + value);
    }
}
