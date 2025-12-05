package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.social.entity.PrivateMessage;
import com.novacloudedu.backend.domain.social.valueobject.MessageId;
import com.novacloudedu.backend.domain.social.valueobject.MessageType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.PrivateMessagePO;
import org.springframework.stereotype.Component;

/**
 * 私聊消息转换器
 */
@Component
public class PrivateMessageConverter {

    /**
     * 领域对象转持久化对象
     */
    public PrivateMessagePO toPO(PrivateMessage message) {
        PrivateMessagePO po = new PrivateMessagePO();
        if (message.getId() != null) {
            po.setId(message.getId().value());
        }
        po.setSenderId(message.getSenderId().value());
        po.setReceiverId(message.getReceiverId().value());
        po.setContent(message.getContent());
        po.setType(message.getType().getValue());
        po.setIsRead(message.isRead() ? 1 : 0);
        po.setCreateTime(message.getCreateTime());
        po.setIsDelete(message.isDelete() ? 1 : 0);
        return po;
    }

    /**
     * 持久化对象转领域对象
     */
    public PrivateMessage toDomain(PrivateMessagePO po) {
        return PrivateMessage.reconstruct(
                MessageId.of(po.getId()),
                UserId.of(po.getSenderId()),
                UserId.of(po.getReceiverId()),
                po.getContent(),
                MessageType.fromValue(po.getType()),
                po.getIsRead() == 1,
                po.getCreateTime(),
                po.getIsDelete() == 1
        );
    }
}
