package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.post.entity.PostCommentReply;
import com.novacloudedu.backend.domain.post.valueobject.CommentId;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.post.valueobject.ReplyId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.PostCommentReplyPO;
import org.springframework.stereotype.Component;

/**
 * 帖子评论回复转换器
 */
@Component
public class PostCommentReplyConverter {

    public PostCommentReply toDomain(PostCommentReplyPO po) {
        if (po == null) {
            return null;
        }
        return PostCommentReply.reconstruct(
                ReplyId.of(po.getId()),
                PostId.of(po.getPostId()),
                CommentId.of(po.getCommentId()),
                UserId.of(po.getUserId()),
                po.getContent(),
                po.getIpAddress(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    public PostCommentReplyPO toPO(PostCommentReply domain) {
        if (domain == null) {
            return null;
        }
        PostCommentReplyPO po = new PostCommentReplyPO();
        if (domain.getId() != null) {
            po.setId(domain.getId().value());
        }
        po.setPostId(domain.getPostId().value());
        po.setCommentId(domain.getCommentId().value());
        po.setUserId(domain.getUserId().value());
        po.setContent(domain.getContent());
        po.setIpAddress(domain.getIpAddress());
        po.setCreateTime(domain.getCreateTime());
        po.setUpdateTime(domain.getUpdateTime());
        return po;
    }
}
