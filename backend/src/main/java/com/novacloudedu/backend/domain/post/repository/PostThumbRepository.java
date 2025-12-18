package com.novacloudedu.backend.domain.post.repository;

import com.novacloudedu.backend.domain.post.entity.PostThumb;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.Optional;

/**
 * 帖子点赞仓储接口
 */
public interface PostThumbRepository {

    /**
     * 保存点赞
     */
    PostThumb save(PostThumb thumb);

    /**
     * 删除点赞
     */
    void delete(PostId postId, UserId userId);

    /**
     * 查找点赞记录
     */
    Optional<PostThumb> findByPostIdAndUserId(PostId postId, UserId userId);

    /**
     * 检查是否已点赞
     */
    boolean existsByPostIdAndUserId(PostId postId, UserId userId);

    /**
     * 统计帖子点赞数
     */
    long countByPostId(PostId postId);
}
