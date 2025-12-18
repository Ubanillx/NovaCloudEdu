package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.post.entity.PostFavour;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.PostFavourPO;
import org.springframework.stereotype.Component;

/**
 * 帖子收藏转换器
 */
@Component
public class PostFavourConverter {

    public PostFavour toDomain(PostFavourPO po) {
        if (po == null) {
            return null;
        }
        return PostFavour.reconstruct(
                po.getId(),
                PostId.of(po.getPostId()),
                UserId.of(po.getUserId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    public PostFavourPO toPO(PostFavour domain) {
        if (domain == null) {
            return null;
        }
        PostFavourPO po = new PostFavourPO();
        if (domain.getId() != null) {
            po.setId(domain.getId());
        }
        po.setPostId(domain.getPostId().value());
        po.setUserId(domain.getUserId().value());
        po.setCreateTime(domain.getCreateTime());
        po.setUpdateTime(domain.getUpdateTime());
        return po;
    }
}
