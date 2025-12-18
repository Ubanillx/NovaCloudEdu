package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.feedback.entity.UserFeedback;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackId;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserFeedbackPO;
import org.springframework.stereotype.Component;

/**
 * 用户反馈转换器
 */
@Component
public class UserFeedbackConverter {

    /**
     * PO -> Domain Entity
     */
    public UserFeedback toDomain(UserFeedbackPO po) {
        if (po == null) {
            return null;
        }
        return UserFeedback.reconstruct(
                FeedbackId.of(po.getId()),
                UserId.of(po.getUserId()),
                po.getFeedbackType(),
                po.getTitle(),
                po.getContent(),
                po.getAttachment(),
                FeedbackStatus.fromCode(po.getStatus()),
                po.getAdminId() != null ? UserId.of(po.getAdminId()) : null,
                po.getProcessTime(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * Domain Entity -> PO
     */
    public UserFeedbackPO toPO(UserFeedback feedback) {
        if (feedback == null) {
            return null;
        }
        UserFeedbackPO po = new UserFeedbackPO();
        if (feedback.getId() != null) {
            po.setId(feedback.getId().value());
        }
        po.setUserId(feedback.getUserId().value());
        po.setFeedbackType(feedback.getFeedbackType());
        po.setTitle(feedback.getTitle());
        po.setContent(feedback.getContent());
        po.setAttachment(feedback.getAttachment());
        po.setStatus(feedback.getStatus().getCode());
        if (feedback.getAdminId() != null) {
            po.setAdminId(feedback.getAdminId().value());
        }
        po.setProcessTime(feedback.getProcessTime());
        po.setCreateTime(feedback.getCreateTime());
        po.setUpdateTime(feedback.getUpdateTime());
        return po;
    }
}
