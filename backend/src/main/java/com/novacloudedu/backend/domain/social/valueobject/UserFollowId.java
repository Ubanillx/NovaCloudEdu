package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 用户关注ID值对象
 */
public record UserFollowId(Long value) {
    public UserFollowId {
        if (value != null && value <= 0) {
            throw new IllegalArgumentException("用户关注ID必须为正数");
        }
    }
}
