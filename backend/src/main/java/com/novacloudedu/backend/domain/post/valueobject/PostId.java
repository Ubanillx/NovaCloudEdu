package com.novacloudedu.backend.domain.post.valueobject;

/**
 * 帖子ID值对象
 */
public record PostId(Long value) {
    public static PostId of(Long value) {
        return new PostId(value);
    }
}
