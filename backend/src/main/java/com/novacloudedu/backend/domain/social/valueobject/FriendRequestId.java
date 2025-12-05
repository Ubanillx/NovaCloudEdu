package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 好友申请ID值对象
 */
public record FriendRequestId(Long value) {

    public static FriendRequestId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("好友申请ID必须为正整数");
        }
        return new FriendRequestId(value);
    }
}
