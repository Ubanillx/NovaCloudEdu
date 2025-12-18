package com.novacloudedu.backend.interfaces.rest.post.dto.response;

import com.novacloudedu.backend.domain.post.entity.PostComment;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 评论响应
 */
@Data
public class CommentResponse {

    private Long id;
    private Long postId;
    private Long userId;
    private String content;
    private String ipAddress;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static CommentResponse from(PostComment comment) {
        if (comment == null) {
            return null;
        }
        CommentResponse response = new CommentResponse();
        response.setId(comment.getId().value());
        response.setPostId(comment.getPostId().value());
        response.setUserId(comment.getUserId().value());
        response.setContent(comment.getContent());
        response.setIpAddress(comment.getIpAddress());
        response.setCreateTime(comment.getCreateTime());
        response.setUpdateTime(comment.getUpdateTime());
        return response;
    }
}
