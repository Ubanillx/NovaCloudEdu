package com.novacloudedu.backend.domain.post.repository;

import com.novacloudedu.backend.domain.post.entity.Post;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.post.valueobject.PostType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

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
     * 帖子分页结果
     */
    record PostPage(List<Post> posts, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
