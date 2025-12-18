package com.novacloudedu.backend.domain.post.valueobject;

/**
 * 评论ID值对象
 */
public record CommentId(Long value) {
    public static CommentId of(Long value) {
        return new CommentId(value);
    }
}
