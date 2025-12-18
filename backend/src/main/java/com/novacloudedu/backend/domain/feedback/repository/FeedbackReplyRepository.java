package com.novacloudedu.backend.domain.feedback.repository;

import com.novacloudedu.backend.domain.feedback.entity.FeedbackReply;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackId;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackReplyId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 反馈回复仓储接口
 */
public interface FeedbackReplyRepository {

    /**
     * 保存回复
     */
    FeedbackReply save(FeedbackReply reply);

    /**
     * 根据ID查找回复
     */
    Optional<FeedbackReply> findById(FeedbackReplyId id);

    /**
     * 根据反馈ID查询所有回复
     */
    List<FeedbackReply> findByFeedbackId(FeedbackId feedbackId);

    /**
     * 根据反馈ID分页查询回复
     */
    ReplyPage findByFeedbackIdPaged(FeedbackId feedbackId, int pageNum, int pageSize);

    /**
     * 标记反馈的所有回复为已读
     */
    void markAllAsRead(FeedbackId feedbackId, UserId readerId);

    /**
     * 统计未读回复数量
     */
    long countUnreadByFeedbackId(FeedbackId feedbackId, UserId userId);

    /**
     * 删除回复（逻辑删除）
     */
    void delete(FeedbackReplyId id);

    /**
     * 根据反馈ID删除所有回复（逻辑删除）
     */
    void deleteByFeedbackId(FeedbackId feedbackId);

    /**
     * 回复分页结果
     */
    record ReplyPage(List<FeedbackReply> replies, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
