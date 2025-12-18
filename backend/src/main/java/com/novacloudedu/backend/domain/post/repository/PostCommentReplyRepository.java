package com.novacloudedu.backend.domain.post.repository;

import com.novacloudedu.backend.domain.post.entity.PostCommentReply;
import com.novacloudedu.backend.domain.post.valueobject.CommentId;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.post.valueobject.ReplyId;

import java.util.List;
import java.util.Optional;

/**
 * 帖子评论回复仓储接口
 */
public interface PostCommentReplyRepository {

    /**
     * 保存回复
     */
    PostCommentReply save(PostCommentReply reply);

    /**
     * 根据ID查找回复
     */
    Optional<PostCommentReply> findById(ReplyId id);

    /**
     * 根据评论ID查找回复列表
     */
    List<PostCommentReply> findByCommentId(CommentId commentId);

    /**
     * 分页获取评论回复
     */
    ReplyPage findByCommentId(CommentId commentId, int pageNum, int pageSize);

    /**
     * 删除回复
     */
    void delete(ReplyId id);

    /**
     * 删除评论的所有回复
     */
    void deleteByCommentId(CommentId commentId);

    /**
     * 删除帖子的所有回复
     */
    void deleteByPostId(PostId postId);

    /**
     * 统计评论回复数
     */
    long countByCommentId(CommentId commentId);

    /**
     * 回复分页结果
     */
    record ReplyPage(List<PostCommentReply> replies, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
