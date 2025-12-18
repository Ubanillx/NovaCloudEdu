package com.novacloudedu.backend.domain.feedback.entity;

import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackId;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackReplyId;
import com.novacloudedu.backend.domain.feedback.valueobject.SenderRole;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 反馈回复实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class FeedbackReply {

    private FeedbackReplyId id;
    private FeedbackId feedbackId;
    private UserId senderId;
    private SenderRole senderRole;
    private String content;
    private String attachment;
    private boolean isRead;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新回复
     */
    public static FeedbackReply create(FeedbackId feedbackId, UserId senderId,
                                        SenderRole senderRole, String content, String attachment) {
        FeedbackReply reply = new FeedbackReply();
        reply.feedbackId = feedbackId;
        reply.senderId = senderId;
        reply.senderRole = senderRole;
        reply.content = content;
        reply.attachment = attachment;
        reply.isRead = false;
        reply.createTime = LocalDateTime.now();
        reply.updateTime = LocalDateTime.now();
        return reply;
    }

    /**
     * 从持久化数据重建
     */
    public static FeedbackReply reconstruct(FeedbackReplyId id, FeedbackId feedbackId,
                                             UserId senderId, SenderRole senderRole,
                                             String content, String attachment, boolean isRead,
                                             LocalDateTime createTime, LocalDateTime updateTime) {
        FeedbackReply reply = new FeedbackReply();
        reply.id = id;
        reply.feedbackId = feedbackId;
        reply.senderId = senderId;
        reply.senderRole = senderRole;
        reply.content = content;
        reply.attachment = attachment;
        reply.isRead = isRead;
        reply.createTime = createTime;
        reply.updateTime = updateTime;
        return reply;
    }

    /**
     * 分配ID
     */
    public void assignId(FeedbackReplyId id) {
        if (this.id != null) {
            throw new IllegalStateException("回复ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 标记为已读
     */
    public void markAsRead() {
        if (!this.isRead) {
            this.isRead = true;
            this.updateTime = LocalDateTime.now();
        }
    }

    /**
     * 检查是否为发送者
     */
    public boolean isSender(UserId userId) {
        return this.senderId.value().equals(userId.value());
    }
}
