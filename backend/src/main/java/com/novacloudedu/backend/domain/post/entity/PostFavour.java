package com.novacloudedu.backend.domain.post.entity;

import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 帖子收藏实体
 */
@Getter
public class PostFavour {

    private Long id;
    private PostId postId;
    private UserId userId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    private PostFavour() {}

    /**
     * 创建收藏
     */
    public static PostFavour create(PostId postId, UserId userId) {
        PostFavour favour = new PostFavour();
        favour.postId = postId;
        favour.userId = userId;
        favour.createTime = LocalDateTime.now();
        favour.updateTime = LocalDateTime.now();
        return favour;
    }

    /**
     * 重建收藏（从数据库恢复）
     */
    public static PostFavour reconstruct(Long id, PostId postId, UserId userId,
                                         LocalDateTime createTime, LocalDateTime updateTime) {
        PostFavour favour = new PostFavour();
        favour.id = id;
        favour.postId = postId;
        favour.userId = userId;
        favour.createTime = createTime;
        favour.updateTime = updateTime;
        return favour;
    }

    /**
     * 分配ID
     */
    public void assignId(Long id) {
        this.id = id;
    }
}
