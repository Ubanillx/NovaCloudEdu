package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.social.entity.PrivateChatSession;
import com.novacloudedu.backend.domain.social.valueobject.SessionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.PrivateChatSessionPO;
import org.springframework.stereotype.Component;

/**
 * 私聊会话转换器
 */
@Component
public class PrivateChatSessionConverter {

    /**
     * 领域对象转持久化对象
     */
    public PrivateChatSessionPO toPO(PrivateChatSession session) {
        PrivateChatSessionPO po = new PrivateChatSessionPO();
        if (session.getId() != null) {
            po.setId(session.getId().value());
        }
        po.setUserId1(session.getUserId1().value());
        po.setUserId2(session.getUserId2().value());
        po.setLastMessageTime(session.getLastMessageTime());
        po.setCreateTime(session.getCreateTime());
        po.setUpdateTime(session.getUpdateTime());
        po.setIsDelete(session.isDelete() ? 1 : 0);
        return po;
    }

    /**
     * 持久化对象转领域对象
     */
    public PrivateChatSession toDomain(PrivateChatSessionPO po) {
        return PrivateChatSession.reconstruct(
                SessionId.of(po.getId()),
                UserId.of(po.getUserId1()),
                UserId.of(po.getUserId2()),
                po.getLastMessageTime(),
                po.getCreateTime(),
                po.getUpdateTime(),
                po.getIsDelete() == 1
        );
    }
}
