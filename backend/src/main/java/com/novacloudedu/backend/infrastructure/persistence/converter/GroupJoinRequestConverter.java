package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.social.entity.GroupJoinRequest;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.JoinRequestStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.GroupJoinRequestPO;
import org.springframework.stereotype.Component;

/**
 * 群申请转换器
 */
@Component
public class GroupJoinRequestConverter {

    public GroupJoinRequest toDomain(GroupJoinRequestPO po) {
        if (po == null) {
            return null;
        }
        return GroupJoinRequest.reconstruct(
                po.getId(),
                GroupId.of(po.getGroupId()),
                UserId.of(po.getUserId()),
                po.getMessage(),
                JoinRequestStatus.fromCode(po.getStatus()),
                po.getHandlerId() != null ? UserId.of(po.getHandlerId()) : null,
                po.getHandleTime(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    public GroupJoinRequestPO toPO(GroupJoinRequest domain) {
        if (domain == null) {
            return null;
        }
        GroupJoinRequestPO po = new GroupJoinRequestPO();
        po.setId(domain.getId());
        po.setGroupId(domain.getGroupId().value());
        po.setUserId(domain.getUserId().value());
        po.setMessage(domain.getMessage());
        po.setStatus(domain.getStatus().getCode());
        if (domain.getHandlerId() != null) {
            po.setHandlerId(domain.getHandlerId().value());
        }
        po.setHandleTime(domain.getHandleTime());
        po.setCreateTime(domain.getCreateTime());
        po.setUpdateTime(domain.getUpdateTime());
        return po;
    }
}
