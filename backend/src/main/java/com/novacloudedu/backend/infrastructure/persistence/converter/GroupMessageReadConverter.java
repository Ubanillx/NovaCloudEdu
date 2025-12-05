package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.social.entity.GroupMessageRead;
import com.novacloudedu.backend.domain.social.valueobject.GroupMessageId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.GroupMessageReadPO;
import org.springframework.stereotype.Component;

/**
 * 群消息已读记录转换器
 */
@Component
public class GroupMessageReadConverter {

    public GroupMessageRead toDomain(GroupMessageReadPO po) {
        if (po == null) {
            return null;
        }
        return GroupMessageRead.reconstruct(
                po.getId(),
                GroupMessageId.of(po.getMessageId()),
                UserId.of(po.getUserId()),
                po.getReadTime()
        );
    }

    public GroupMessageReadPO toPO(GroupMessageRead domain) {
        if (domain == null) {
            return null;
        }
        GroupMessageReadPO po = new GroupMessageReadPO();
        po.setId(domain.getId());
        po.setMessageId(domain.getMessageId().value());
        po.setUserId(domain.getUserId().value());
        po.setReadTime(domain.getReadTime());
        return po;
    }
}
