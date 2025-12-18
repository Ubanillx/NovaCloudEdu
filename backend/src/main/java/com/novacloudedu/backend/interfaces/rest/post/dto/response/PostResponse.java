package com.novacloudedu.backend.interfaces.rest.post.dto.response;

import com.novacloudedu.backend.domain.post.entity.Post;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 帖子响应
 */
@Data
public class PostResponse {

    private Long id;
    private String title;
    private String content;
    private List<String> tags;
    private Integer thumbNum;
    private Integer favourNum;
    private Integer commentNum;
    private Long userId;
    private String ipAddress;
    private String postType;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static PostResponse from(Post post) {
        if (post == null) {
            return null;
        }
        PostResponse response = new PostResponse();
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
        return response;
    }
}
