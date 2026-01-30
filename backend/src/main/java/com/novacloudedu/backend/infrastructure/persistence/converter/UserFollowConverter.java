package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.social.entity.UserFollow;
import com.novacloudedu.backend.domain.social.valueobject.UserFollowId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserFollowPO;
import org.springframework.stereotype.Component;

/**
 * 用户关注转换器
 */
@Component
public class UserFollowConverter {

    public UserFollowPO toPO(UserFollow follow) {
        if (follow == null) {
            return null;
        }
        UserFollowPO po = new UserFollowPO();
        if (follow.getId() != null) {
            po.setId(follow.getId().value());
        }
        po.setFollowerId(follow.getFollowerId().value());
        po.setFollowingId(follow.getFollowingId().value());
        po.setCreateTime(follow.getCreateTime());
        return po;
    }

    public UserFollow toDomain(UserFollowPO po) {
        if (po == null) {
            return null;
        }
        return UserFollow.reconstruct(
                new UserFollowId(po.getId()),
                new UserId(po.getFollowerId()),
                new UserId(po.getFollowingId()),
                po.getCreateTime()
        );
    }
}
