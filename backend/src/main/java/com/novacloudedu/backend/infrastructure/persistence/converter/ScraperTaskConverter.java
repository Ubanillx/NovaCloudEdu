package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.scraper.entity.ScraperTask;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperConfigId;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperStatus;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperTaskId;
import com.novacloudedu.backend.infrastructure.persistence.po.ScraperTaskPO;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class ScraperTaskConverter {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    public ScraperTaskPO toPO(ScraperTask task) {
        ScraperTaskPO po = new ScraperTaskPO();
        if (task.getId() != null) {
            po.setId(task.getId().value());
        }
        if (task.getConfigId() != null) {
            po.setConfigId(task.getConfigId().value());
        }
        po.setConfigName(task.getConfigName());
        po.setStatus(task.getStatus().getCode());
        po.setTotalArticles(task.getTotalArticles());
        po.setSuccessCount(task.getSuccessCount());
        po.setFailCount(task.getFailCount());
        po.setCreatedArticleIds(toJson(task.getCreatedArticleIds()));
        po.setErrorMessage(task.getErrorMessage());
        po.setStartTime(task.getStartTime());
        po.setEndTime(task.getEndTime());
        po.setDurationMs(task.getDurationMs());
        po.setCreateTime(task.getCreateTime());
        return po;
    }

    public ScraperTask toDomain(ScraperTaskPO po) {
        return ScraperTask.reconstruct(
                ScraperTaskId.of(po.getId()),
                ScraperConfigId.of(po.getConfigId()),
                po.getConfigName(),
                ScraperStatus.fromCode(po.getStatus()),
                po.getTotalArticles(),
                po.getSuccessCount(),
                po.getFailCount(),
                fromJson(po.getCreatedArticleIds()),
                po.getErrorMessage(),
                po.getStartTime(),
                po.getEndTime(),
                po.getDurationMs(),
                po.getCreateTime()
        );
    }

    private String toJson(List<Long> list) {
        if (list == null || list.isEmpty()) {
            return "[]";
        }
        try {
            return objectMapper.writeValueAsString(list);
        } catch (JsonProcessingException e) {
            return "[]";
        }
    }

    private List<Long> fromJson(String json) {
        if (json == null || json.isEmpty()) {
            return new ArrayList<>();
        }
        try {
            return objectMapper.readValue(json, new TypeReference<List<Long>>() {});
        } catch (JsonProcessingException e) {
            return new ArrayList<>();
        }
    }
}
