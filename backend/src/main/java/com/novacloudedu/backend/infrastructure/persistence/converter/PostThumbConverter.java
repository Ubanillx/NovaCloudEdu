package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.post.entity.PostThumb;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.PostThumbPO;
import org.springframework.stereotype.Component;

/**
 * 帖子点赞转换器
 */
@Component
public class PostThumbConverter {

    public PostThumb toDomain(PostThumbPO po) {
        if (po == null) {
            return null;
        }
        return PostThumb.reconstruct(
                po.getId(),
                PostId.of(po.getPostId()),
                UserId.of(po.getUserId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    public PostThumbPO toPO(PostThumb domain) {
        if (domain == null) {
            return null;
        }
        PostThumbPO po = new PostThumbPO();
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
