package com.novacloudedu.backend.interfaces.rest.scraper.dto.response;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 抓取任务响应
 */
@Data
@Builder
public class ScraperTaskResponse {

    private Long id;
    private Long configId;
    private String configName;
    private String status;
    private String statusDescription;
    private Integer totalArticles;
    private Integer successCount;
    private Integer failCount;
    private List<Long> createdArticleIds;
    private String errorMessage;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Long durationMs;
    private LocalDateTime createTime;
}
