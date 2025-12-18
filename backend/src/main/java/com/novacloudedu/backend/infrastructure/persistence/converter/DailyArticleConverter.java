package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.DailyArticlePO;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class DailyArticleConverter {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    public DailyArticlePO toPO(DailyArticle article) {
        DailyArticlePO po = new DailyArticlePO();
        if (article.getId() != null) {
            po.setId(article.getId().value());
        }
        po.setTitle(article.getTitle());
        po.setContent(article.getContent());
        po.setSummary(article.getSummary());
        po.setCoverImage(article.getCoverImage());
        po.setAuthor(article.getAuthor());
        po.setSource(article.getSource());
        po.setSourceUrl(article.getSourceUrl());
        po.setCategory(article.getCategory());
        po.setTags(toJson(article.getTags()));
        po.setDifficulty(article.getDifficulty().getCode());
        po.setReadTime(article.getReadTime());
        po.setPublishDate(article.getPublishDate());
        po.setAdminId(article.getAdminId().value());
        po.setViewCount(article.getViewCount());
        po.setLikeCount(article.getLikeCount());
        po.setCollectCount(article.getCollectCount());
        po.setCreateTime(article.getCreateTime());
        po.setUpdateTime(article.getUpdateTime());
        return po;
    }

    public DailyArticle toDomain(DailyArticlePO po) {
        return DailyArticle.reconstruct(
                DailyArticleId.of(po.getId()),
                po.getTitle(),
                po.getContent(),
                po.getSummary(),
                po.getCoverImage(),
                po.getAuthor(),
                po.getSource(),
                po.getSourceUrl(),
                po.getCategory(),
                fromJson(po.getTags()),
                Difficulty.fromCode(po.getDifficulty()),
                po.getReadTime(),
                po.getPublishDate(),
                UserId.of(po.getAdminId()),
                po.getViewCount(),
                po.getLikeCount(),
                po.getCollectCount(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    private String toJson(List<String> list) {
        if (list == null || list.isEmpty()) {
            return "[]";
        }
        try {
            return objectMapper.writeValueAsString(list);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("JSON序列化失败", e);
        }
    }

    private List<String> fromJson(String json) {
        if (json == null || json.isEmpty()) {
            return new ArrayList<>();
        }
        try {
            return objectMapper.readValue(json, new TypeReference<List<String>>() {});
        } catch (JsonProcessingException e) {
            return new ArrayList<>();
        }
    }
}
