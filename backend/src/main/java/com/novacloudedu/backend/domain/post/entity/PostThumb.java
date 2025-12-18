package com.novacloudedu.backend.domain.post.entity;

import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 帖子点赞实体
 */
@Getter
public class PostThumb {

    private Long id;
    private PostId postId;
    private UserId userId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    private PostThumb() {}

    /**
     * 创建点赞
     */
    public static PostThumb create(PostId postId, UserId userId) {
        PostThumb thumb = new PostThumb();
        thumb.postId = postId;
        thumb.userId = userId;
        thumb.createTime = LocalDateTime.now();
        thumb.updateTime = LocalDateTime.now();
        return thumb;
    }

    /**
     * 重建点赞（从数据库恢复）
     */
    public static PostThumb reconstruct(Long id, PostId postId, UserId userId,
                                        LocalDateTime createTime, LocalDateTime updateTime) {
        PostThumb thumb = new PostThumb();
        thumb.id = id;
        thumb.postId = postId;
        thumb.userId = userId;
        thumb.createTime = createTime;
        thumb.updateTime = updateTime;
        return thumb;
    }

    /**
     * 分配ID
     */
    public void assignId(Long id) {
        this.id = id;
    }
}
