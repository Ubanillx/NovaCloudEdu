package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.feedback.entity.FeedbackReply;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackId;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackReplyId;
import com.novacloudedu.backend.domain.feedback.valueobject.SenderRole;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.FeedbackReplyPO;
import org.springframework.stereotype.Component;

/**
 * 反馈回复转换器
 */
@Component
public class FeedbackReplyConverter {

    /**
     * PO -> Domain Entity
     */
    public FeedbackReply toDomain(FeedbackReplyPO po) {
        if (po == null) {
            return null;
        }
        return FeedbackReply.reconstruct(
                FeedbackReplyId.of(po.getId()),
                FeedbackId.of(po.getFeedbackId()),
                UserId.of(po.getSenderId()),
                SenderRole.fromCode(po.getSenderRole()),
                po.getContent(),
                po.getAttachment(),
                po.getIsRead() != null && po.getIsRead() == 1,
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * Domain Entity -> PO
     */
    public FeedbackReplyPO toPO(FeedbackReply reply) {
        if (reply == null) {
            return null;
        }
        FeedbackReplyPO po = new FeedbackReplyPO();
        if (reply.getId() != null) {
            po.setId(reply.getId().value());
        }
        po.setFeedbackId(reply.getFeedbackId().value());
        po.setSenderId(reply.getSenderId().value());
        po.setSenderRole(reply.getSenderRole().getCode());
        po.setContent(reply.getContent());
        po.setAttachment(reply.getAttachment());
        po.setIsRead(reply.isRead() ? 1 : 0);
        po.setCreateTime(reply.getCreateTime());
        po.setUpdateTime(reply.getUpdateTime());
        return po;
    }
}
