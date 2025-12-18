package com.novacloudedu.backend.domain.post.repository;

import com.novacloudedu.backend.domain.post.entity.PostFavour;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 帖子收藏仓储接口
 */
public interface PostFavourRepository {

    /**
     * 保存收藏
     */
    PostFavour save(PostFavour favour);

    /**
     * 删除收藏
     */
    void delete(PostId postId, UserId userId);

    /**
     * 查找收藏记录
     */
    Optional<PostFavour> findByPostIdAndUserId(PostId postId, UserId userId);

    /**
     * 检查是否已收藏
     */
    boolean existsByPostIdAndUserId(PostId postId, UserId userId);

    /**
     * 统计帖子收藏数
     */
    long countByPostId(PostId postId);

    /**
     * 获取用户收藏的帖子ID列表
     */
    List<PostId> findPostIdsByUserId(UserId userId, int pageNum, int pageSize);

    /**
     * 统计用户收藏数
     */
    long countByUserId(UserId userId);
}
