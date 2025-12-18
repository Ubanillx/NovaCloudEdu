package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.post.entity.Post;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.post.valueobject.PostType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.PostPO;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * 帖子转换器
 */
@Component
public class PostConverter {

    private final ObjectMapper objectMapper = new ObjectMapper();

    public Post toDomain(PostPO po) {
        if (po == null) {
            return null;
        }
        List<String> tags = parseTagsFromJson(po.getTags());
        return Post.reconstruct(
                PostId.of(po.getId()),
                po.getTitle(),
                po.getContent(),
                tags,
                po.getThumbNum() != null ? po.getThumbNum() : 0,
                po.getFavourNum() != null ? po.getFavourNum() : 0,
                po.getCommentNum() != null ? po.getCommentNum() : 0,
                UserId.of(po.getUserId()),
                po.getIpAddress(),
                PostType.fromCode(po.getPostType()),
                po.getCreateTime(),
                po.getUpdateTime(),
                po.getIsDelete() != null && po.getIsDelete() == 1
        );
    }

    public PostPO toPO(Post domain) {
        if (domain == null) {
            return null;
        }
        PostPO po = new PostPO();
        if (domain.getId() != null) {
            po.setId(domain.getId().value());
        }
        po.setTitle(domain.getTitle());
        po.setContent(domain.getContent());
        po.setTags(convertTagsToJson(domain.getTags()));
        po.setThumbNum(domain.getThumbNum());
        po.setFavourNum(domain.getFavourNum());
        po.setCommentNum(domain.getCommentNum());
        po.setUserId(domain.getUserId().value());
        po.setIpAddress(domain.getIpAddress());
        po.setPostType(domain.getPostType().getCode());
        po.setCreateTime(domain.getCreateTime());
        po.setUpdateTime(domain.getUpdateTime());
        po.setIsDelete(domain.isDelete() ? 1 : 0);
        return po;
    }

    private List<String> parseTagsFromJson(String tagsJson) {
        if (tagsJson == null || tagsJson.isBlank()) {
            return new ArrayList<>();
        }
        try {
            return objectMapper.readValue(tagsJson, new TypeReference<List<String>>() {});
        } catch (JsonProcessingException e) {
            return new ArrayList<>();
        }
    }

    private String convertTagsToJson(List<String> tags) {
        if (tags == null || tags.isEmpty()) {
            return "[]";
        }
        try {
            return objectMapper.writeValueAsString(tags);
        } catch (JsonProcessingException e) {
            return "[]";
        }
    }
}
