package com.novacloudedu.backend.domain.post.entity;

import com.novacloudedu.backend.domain.post.valueobject.CommentId;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 帖子评论实体
 */
@Getter
public class PostComment {

    private CommentId id;
    private PostId postId;
    private UserId userId;
    private String content;
    private String ipAddress;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    private PostComment() {}

    /**
     * 创建评论
     */
    public static PostComment create(PostId postId, UserId userId, String content) {
        PostComment comment = new PostComment();
        comment.postId = postId;
        comment.userId = userId;
        comment.content = content;
        comment.createTime = LocalDateTime.now();
        comment.updateTime = LocalDateTime.now();
        return comment;
    }

    /**
     * 重建评论（从数据库恢复）
     */
    public static PostComment reconstruct(CommentId id, PostId postId, UserId userId,
                                          String content, String ipAddress,
                                          LocalDateTime createTime, LocalDateTime updateTime) {
        PostComment comment = new PostComment();
        comment.id = id;
        comment.postId = postId;
        comment.userId = userId;
        comment.content = content;
        comment.ipAddress = ipAddress;
        comment.createTime = createTime;
        comment.updateTime = updateTime;
        return comment;
    }

    /**
     * 分配ID
     */
    public void assignId(CommentId id) {
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
