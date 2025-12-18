package com.novacloudedu.backend.domain.feedback.entity;

import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackId;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 用户反馈聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserFeedback {

    private FeedbackId id;
    private UserId userId;
    private String feedbackType;
    private String title;
    private String content;
    private String attachment;
    private FeedbackStatus status;
    private UserId adminId;
    private LocalDateTime processTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新反馈
     */
    public static UserFeedback create(UserId userId, String feedbackType, String title,
                                       String content, String attachment) {
        UserFeedback feedback = new UserFeedback();
        feedback.userId = userId;
        feedback.feedbackType = feedbackType;
        feedback.title = title;
        feedback.content = content;
        feedback.attachment = attachment;
        feedback.status = FeedbackStatus.PENDING;
        feedback.createTime = LocalDateTime.now();
        feedback.updateTime = LocalDateTime.now();
        return feedback;
    }

    /**
     * 从持久化数据重建
     */
    public static UserFeedback reconstruct(FeedbackId id, UserId userId, String feedbackType,
                                            String title, String content, String attachment,
                                            FeedbackStatus status, UserId adminId,
                                            LocalDateTime processTime, LocalDateTime createTime,
                                            LocalDateTime updateTime) {
        UserFeedback feedback = new UserFeedback();
        feedback.id = id;
        feedback.userId = userId;
        feedback.feedbackType = feedbackType;
        feedback.title = title;
        feedback.content = content;
        feedback.attachment = attachment;
        feedback.status = status;
        feedback.adminId = adminId;
        feedback.processTime = processTime;
        feedback.createTime = createTime;
        feedback.updateTime = updateTime;
        return feedback;
    }

    /**
     * 分配ID
     */
    public void assignId(FeedbackId id) {
        if (this.id != null) {
            throw new IllegalStateException("反馈ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 开始处理反馈
     */
    public void startProcessing(UserId adminId) {
        if (this.status != FeedbackStatus.PENDING) {
            throw new IllegalStateException("只有待处理的反馈才能开始处理");
        }
        this.status = FeedbackStatus.PROCESSING;
        this.adminId = adminId;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 完成处理反馈
     */
    public void completeProcessing(UserId adminId) {
        if (this.status == FeedbackStatus.PROCESSED) {
            throw new IllegalStateException("反馈已处理完成");
        }
        this.status = FeedbackStatus.PROCESSED;
        this.adminId = adminId;
        this.processTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新反馈状态
     */
    public void updateStatus(FeedbackStatus newStatus, UserId adminId) {
        this.status = newStatus;
        this.adminId = adminId;
        if (newStatus == FeedbackStatus.PROCESSED) {
            this.processTime = LocalDateTime.now();
        }
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 检查是否为反馈所有者
     */
    public boolean isOwner(UserId userId) {
        return this.userId.value().equals(userId.value());
    }
}
