package com.novacloudedu.backend.domain.post.repository;

import com.novacloudedu.backend.domain.post.entity.PostComment;
import com.novacloudedu.backend.domain.post.valueobject.CommentId;
import com.novacloudedu.backend.domain.post.valueobject.PostId;

import java.util.List;
import java.util.Optional;

/**
 * 帖子评论仓储接口
 */
public interface PostCommentRepository {

    /**
     * 保存评论
     */
    PostComment save(PostComment comment);

    /**
     * 根据ID查找评论
     */
    Optional<PostComment> findById(CommentId id);

    /**
     * 根据帖子ID查找评论列表
     */
    List<PostComment> findByPostId(PostId postId);

    /**
     * 分页获取帖子评论
     */
    CommentPage findByPostId(PostId postId, int pageNum, int pageSize);

    /**
     * 删除评论
     */
    void delete(CommentId id);

    /**
     * 删除帖子的所有评论
     */
    void deleteByPostId(PostId postId);

    /**
     * 统计帖子评论数
     */
    long countByPostId(PostId postId);

    /**
     * 评论分页结果
     */
    record CommentPage(List<PostComment> comments, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
