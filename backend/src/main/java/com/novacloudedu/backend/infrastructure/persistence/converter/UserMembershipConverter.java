package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.membership.entity.UserMembership;
import com.novacloudedu.backend.domain.membership.valueobject.MembershipStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserMembershipPO;
import org.springframework.stereotype.Component;

@Component
public class UserMembershipConverter {

    public UserMembershipPO toPO(UserMembership membership) {
        UserMembershipPO po = new UserMembershipPO();
        if (membership.getId() != null) {
            po.setId(membership.getId());
        }
        po.setUserId(membership.getUserId().value());
        po.setPlanId(membership.getPlanId());
        po.setOrderNo(membership.getOrderNo());
        po.setStartTime(membership.getStartTime());
        po.setExpireTime(membership.getExpireTime());
        po.setStatus(membership.getStatus().getCode());
        po.setCreateTime(membership.getCreateTime());
        po.setUpdateTime(membership.getUpdateTime());
        return po;
    }

    public UserMembership toDomain(UserMembershipPO po) {
        return UserMembership.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                po.getPlanId(),
                po.getOrderNo(),
                po.getStartTime(),
                po.getExpireTime(),
                MembershipStatus.fromCode(po.getStatus()),
                po.getCreateTime(),
                po.getUpdateTime(),
                po.getIsDelete() != null && po.getIsDelete() == 1
        );
    }
}
