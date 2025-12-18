package com.novacloudedu.backend.interfaces.rest.post.dto.response;

import com.novacloudedu.backend.domain.post.entity.Post;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 帖子详情响应（包含用户交互状态）
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class PostDetailResponse extends PostResponse {

    private Boolean hasThumb;
    private Boolean hasFavour;

    public static PostDetailResponse from(Post post, boolean hasThumb, boolean hasFavour) {
        if (post == null) {
            return null;
        }
        PostDetailResponse response = new PostDetailResponse();
        response.setId(post.getId().value());
        response.setTitle(post.getTitle());
        response.setContent(post.getContent());
        response.setTags(post.getTags());
        response.setThumbNum(post.getThumbNum());
        response.setFavourNum(post.getFavourNum());
        response.setCommentNum(post.getCommentNum());
        response.setUserId(post.getUserId().value());
        response.setIpAddress(post.getIpAddress());
        response.setPostType(post.getPostType().getCode());
        response.setCreateTime(post.getCreateTime());
        response.setUpdateTime(post.getUpdateTime());
        response.setHasThumb(hasThumb);
        response.setHasFavour(hasFavour);
        return response;
    }
}
