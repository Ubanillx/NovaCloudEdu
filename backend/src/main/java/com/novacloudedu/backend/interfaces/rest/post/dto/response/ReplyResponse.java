package com.novacloudedu.backend.interfaces.rest.post.dto.response;

import com.novacloudedu.backend.domain.post.entity.PostCommentReply;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 回复响应
 */
@Data
public class ReplyResponse {

    private Long id;
    private Long postId;
    private Long commentId;
    private Long userId;
    private String content;
    private String ipAddress;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static ReplyResponse from(PostCommentReply reply) {
        if (reply == null) {
            return null;
        }
        ReplyResponse response = new ReplyResponse();
        response.setId(reply.getId().value());
        response.setPostId(reply.getPostId().value());
        response.setCommentId(reply.getCommentId().value());
        response.setUserId(reply.getUserId().value());
        response.setContent(reply.getContent());
        response.setIpAddress(reply.getIpAddress());
        response.setCreateTime(reply.getCreateTime());
        response.setUpdateTime(reply.getUpdateTime());
        return response;
    }
}
