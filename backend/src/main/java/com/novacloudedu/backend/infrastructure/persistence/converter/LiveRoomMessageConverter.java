package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.livestream.entity.LiveRoomMessage;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveMessageType;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomId;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomMessageId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.LiveRoomMessagePO;
import org.springframework.stereotype.Component;

/**
 * 直播间消息转换器
 */
@Component
public class LiveRoomMessageConverter {

    public LiveRoomMessage toDomain(LiveRoomMessagePO po) {
        if (po == null) {
            return null;
        }
        return LiveRoomMessage.reconstruct(
                LiveRoomMessageId.of(po.getId()),
                LiveRoomId.of(po.getRoomId()),
                po.getSenderId() != null ? UserId.of(po.getSenderId()) : null,
                po.getContent(),
                LiveMessageType.fromValue(po.getMessageType()),
                po.getCreateTime(),
                po.getIsDelete() != null && po.getIsDelete() == 1
        );
    }

    public LiveRoomMessagePO toPO(LiveRoomMessage domain) {
        if (domain == null) {
            return null;
        }
        LiveRoomMessagePO po = new LiveRoomMessagePO();
        if (domain.getId() != null) {
            po.setId(domain.getId().value());
        }
        po.setRoomId(domain.getRoomId().value());
        po.setSenderId(domain.getSenderId() != null ? domain.getSenderId().value() : null);
        po.setContent(domain.getContent());
        po.setMessageType(domain.getMessageType().getValue());
        po.setCreateTime(domain.getCreateTime());
        po.setIsDelete(domain.isDelete() ? 1 : 0);
        return po;
    }
}
