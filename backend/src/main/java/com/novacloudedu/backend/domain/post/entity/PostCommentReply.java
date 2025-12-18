package com.novacloudedu.backend.domain.post.entity;

import com.novacloudedu.backend.domain.post.valueobject.CommentId;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.post.valueobject.ReplyId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 帖子评论回复实体
 */
@Getter
public class PostCommentReply {

    private ReplyId id;
    private PostId postId;
    private CommentId commentId;
    private UserId userId;
    private String content;
    private String ipAddress;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    private PostCommentReply() {}

    /**
     * 创建回复
     */
    public static PostCommentReply create(PostId postId, CommentId commentId, UserId userId, String content) {
        PostCommentReply reply = new PostCommentReply();
        reply.postId = postId;
        reply.commentId = commentId;
        reply.userId = userId;
        reply.content = content;
        reply.createTime = LocalDateTime.now();
        reply.updateTime = LocalDateTime.now();
        return reply;
    }

    /**
     * 重建回复（从数据库恢复）
     */
    public static PostCommentReply reconstruct(ReplyId id, PostId postId, CommentId commentId,
                                               UserId userId, String content, String ipAddress,
                                               LocalDateTime createTime, LocalDateTime updateTime) {
        PostCommentReply reply = new PostCommentReply();
        reply.id = id;
        reply.postId = postId;
        reply.commentId = commentId;
        reply.userId = userId;
        reply.content = content;
        reply.ipAddress = ipAddress;
        reply.createTime = createTime;
        reply.updateTime = updateTime;
        return reply;
    }

    /**
     * 分配ID
     */
    public void assignId(ReplyId id) {
        this.id = id;
    }

    /**
     * 设置IP地址
     */
    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    /**
     * 检查是否是作者
     */
    public boolean isAuthor(UserId userId) {
        return this.userId.equals(userId);
    }
}
