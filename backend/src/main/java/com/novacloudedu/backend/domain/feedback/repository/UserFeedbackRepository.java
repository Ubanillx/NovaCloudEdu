package com.novacloudedu.backend.domain.feedback.repository;

import com.novacloudedu.backend.domain.feedback.entity.UserFeedback;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackId;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 用户反馈仓储接口
 */
public interface UserFeedbackRepository {

    /**
     * 保存反馈
     */
    UserFeedback save(UserFeedback feedback);

    /**
     * 根据ID查找反馈
     */
    Optional<UserFeedback> findById(FeedbackId id);

    /**
     * 根据用户ID分页查询反馈
     */
    FeedbackPage findByUserId(UserId userId, int pageNum, int pageSize);

    /**
     * 分页查询反馈（管理员）
     */
    FeedbackPage findByCondition(FeedbackQueryCondition condition);

    /**
     * 删除反馈（逻辑删除）
     */
    void delete(FeedbackId id);

    /**
     * 反馈查询条件
     */
    record FeedbackQueryCondition(
            Long userId,
            String feedbackType,
            FeedbackStatus status,
            int pageNum,
            int pageSize
    ) {
        public static FeedbackQueryCondition of(Long userId, String feedbackType, FeedbackStatus status,
                                                 int pageNum, int pageSize) {
            return new FeedbackQueryCondition(userId, feedbackType, status,
                    Math.max(1, pageNum), Math.max(1, Math.min(100, pageSize)));
        }
    }

    /**
     * 反馈分页结果
     */
    record FeedbackPage(List<UserFeedback> feedbacks, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
