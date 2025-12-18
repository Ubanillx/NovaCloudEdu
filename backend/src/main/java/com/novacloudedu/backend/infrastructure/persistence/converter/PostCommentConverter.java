package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.post.entity.PostComment;
import com.novacloudedu.backend.domain.post.valueobject.CommentId;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.PostCommentPO;
import org.springframework.stereotype.Component;

/**
 * 帖子评论转换器
 */
@Component
public class PostCommentConverter {

    public PostComment toDomain(PostCommentPO po) {
        if (po == null) {
            return null;
        }
        return PostComment.reconstruct(
                CommentId.of(po.getId()),
                PostId.of(po.getPostId()),
                UserId.of(po.getUserId()),
                po.getContent(),
                po.getIpAddress(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    public PostCommentPO toPO(PostComment domain) {
        if (domain == null) {
            return null;
        }
        PostCommentPO po = new PostCommentPO();
        if (domain.getId() != null) {
            po.setId(domain.getId().value());
        }
        po.setPostId(domain.getPostId().value());
        po.setUserId(domain.getUserId().value());
        po.setContent(domain.getContent());
        po.setIpAddress(domain.getIpAddress());
        po.setCreateTime(domain.getCreateTime());
        po.setUpdateTime(domain.getUpdateTime());
        return po;
    }
}
