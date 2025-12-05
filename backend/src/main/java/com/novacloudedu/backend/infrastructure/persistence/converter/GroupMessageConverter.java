package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.social.entity.GroupMessage;
import com.novacloudedu.backend.domain.social.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.GroupMessagePO;
import org.springframework.stereotype.Component;

/**
 * 群消息转换器
 */
@Component
public class GroupMessageConverter {

    public GroupMessage toDomain(GroupMessagePO po) {
        if (po == null) {
            return null;
        }
        return GroupMessage.reconstruct(
                GroupMessageId.of(po.getId()),
                GroupId.of(po.getGroupId()),
                SenderType.fromCode(po.getSenderType()),
                po.getSenderId() != null ? UserId.of(po.getSenderId()) : null,
                po.getAiRoleId(),
                po.getContent(),
                MessageType.fromValue(po.getType()),
                po.getReplyTo() != null ? GroupMessageId.of(po.getReplyTo()) : null,
                po.getCreateTime(),
                po.getIsDelete() == 1
        );
    }

    public GroupMessagePO toPO(GroupMessage domain) {
        if (domain == null) {
            return null;
        }
        GroupMessagePO po = new GroupMessagePO();
        if (domain.getId() != null) {
            po.setId(domain.getId().value());
        }
        po.setGroupId(domain.getGroupId().value());
        po.setSenderType(domain.getSenderType().getCode());
        if (domain.getSenderId() != null) {
            po.setSenderId(domain.getSenderId().value());
        }
        po.setAiRoleId(domain.getAiRoleId());
        po.setContent(domain.getContent());
        po.setType(domain.getType().getValue());
        if (domain.getReplyTo() != null) {
            po.setReplyTo(domain.getReplyTo().value());
        }
        po.setCreateTime(domain.getCreateTime());
        po.setIsDelete(domain.isDelete() ? 1 : 0);
        return po;
    }
}
