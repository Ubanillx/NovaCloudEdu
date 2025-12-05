package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.social.entity.FriendRequest;
import com.novacloudedu.backend.domain.social.valueobject.FriendRequestId;
import com.novacloudedu.backend.domain.social.valueobject.FriendRequestStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.FriendRequestPO;
import org.springframework.stereotype.Component;

/**
 * 好友申请转换器
 */
@Component
public class FriendRequestConverter {

    /**
     * PO转领域对象
     */
    public FriendRequest toDomain(FriendRequestPO po) {
        if (po == null) {
            return null;
        }
        return FriendRequest.reconstruct(
                FriendRequestId.of(po.getId()),
                UserId.of(po.getSenderId()),
                UserId.of(po.getReceiverId()),
                FriendRequestStatus.fromValue(po.getStatus()),
                po.getMessage(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * 领域对象转PO
     */
    public FriendRequestPO toPO(FriendRequest request) {
        if (request == null) {
            return null;
        }
        FriendRequestPO po = new FriendRequestPO();
        if (request.getId() != null) {
            po.setId(request.getId().value());
        }
        po.setSenderId(request.getSenderId().value());
        po.setReceiverId(request.getReceiverId().value());
        po.setStatus(request.getStatus().getValue());
        po.setMessage(request.getMessage());
        po.setCreateTime(request.getCreateTime());
        po.setUpdateTime(request.getUpdateTime());
        return po;
    }
}
