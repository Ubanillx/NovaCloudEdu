package com.novacloudedu.backend.domain.post.valueobject;

/**
 * 回复ID值对象
 */
public record ReplyId(Long value) {
    public static ReplyId of(Long value) {
        return new ReplyId(value);
    }
}
