package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.social.entity.FriendRelationship;
import com.novacloudedu.backend.domain.social.valueobject.FriendRelationshipId;
import com.novacloudedu.backend.domain.social.valueobject.FriendRelationshipStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.FriendRelationshipPO;
import org.springframework.stereotype.Component;

/**
 * 好友关系转换器
 */
@Component
public class FriendRelationshipConverter {

    /**
     * PO转领域对象
     */
    public FriendRelationship toDomain(FriendRelationshipPO po) {
        if (po == null) {
            return null;
        }
        return FriendRelationship.reconstruct(
                FriendRelationshipId.of(po.getId()),
                UserId.of(po.getUserId1()),
                UserId.of(po.getUserId2()),
                FriendRelationshipStatus.fromValue(po.getStatus()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * 领域对象转PO
     */
    public FriendRelationshipPO toPO(FriendRelationship relationship) {
        if (relationship == null) {
            return null;
        }
        FriendRelationshipPO po = new FriendRelationshipPO();
        if (relationship.getId() != null) {
            po.setId(relationship.getId().value());
        }
        po.setUserId1(relationship.getUserId1().value());
        po.setUserId2(relationship.getUserId2().value());
        po.setStatus(relationship.getStatus().getValue());
        po.setCreateTime(relationship.getCreateTime());
        po.setUpdateTime(relationship.getUpdateTime());
        return po;
    }
}
