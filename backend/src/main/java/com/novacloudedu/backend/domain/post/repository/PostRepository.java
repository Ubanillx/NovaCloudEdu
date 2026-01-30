package com.novacloudedu.backend.domain.post.repository;

import com.novacloudedu.backend.domain.post.entity.Post;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.post.valueobject.PostType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * 帖子仓储接口
 */
public interface PostRepository {

    /**
     * 保存帖子
     */
    Post save(Post post);

    /**
     * 更新帖子
     */
    void update(Post post);

    /**
     * 根据ID查找帖子
     */
    Optional<Post> findById(PostId id);

    /**
     * 根据用户ID查找帖子列表
     */
    List<Post> findByUserId(UserId userId);

    /**
     * 分页获取帖子列表
     */
    PostPage findAll(int pageNum, int pageSize);

    /**
     * 根据类型分页获取帖子
     */
    PostPage findByType(PostType postType, int pageNum, int pageSize);

    /**
     * 根据标签搜索帖子
     */
    PostPage searchByTag(String tag, int pageNum, int pageSize);

    /**
     * 根据关键词搜索帖子（标题和内容）
     */
    PostPage searchByKeyword(String keyword, int pageNum, int pageSize);

    /**
     * 获取用户收藏的帖子
     */
    PostPage findFavouritesByUserId(UserId userId, int pageNum, int pageSize);

    /**
     * 删除帖子（逻辑删除）
     */
    void delete(PostId id);

    /**
     * 统计用户帖子获赞总数
     */
    long countTotalLikesByUserId(UserId userId);

    /**
     * 获取关注用户的帖子列表（分页）
     */
    PostPage findByUserIds(List<UserId> userIds, int pageNum, int pageSize);

    /**
     * 获取点赞排行榜（支持时间筛选）
     * @param startTime 开始时间（可为null，表示不限制）
     * @param endTime 结束时间（可为null，表示不限制）
     * @param pageNum 页码
     * @param pageSize 每页数量
     * @return 按点赞数降序排列的帖子分页结果
     */
    PostPage findTopByThumbNum(LocalDateTime startTime, LocalDateTime endTime, int pageNum, int pageSize);

    /**
     * 帖子分页结果
     */
    record PostPage(List<Post> posts, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
