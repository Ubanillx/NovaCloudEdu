package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 好友关系ID值对象
 */
public record FriendRelationshipId(Long value) {

    public static FriendRelationshipId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("好友关系ID必须为正整数");
        }
        return new FriendRelationshipId(value);
    }
}
