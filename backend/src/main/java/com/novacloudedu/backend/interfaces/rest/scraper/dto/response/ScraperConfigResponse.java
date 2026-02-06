package com.novacloudedu.backend.interfaces.rest.scraper.dto.response;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 抓取配置响应
 */
@Data
@Builder
public class ScraperConfigResponse {

    private Long id;
    private String name;
    private String sourceCode;
    private String baseUrl;
    private String description;

    private String titleSelector;
    private String authorSelector;
    private String sourceSelector;
    private String contentSelector;
    private String dateSelector;
    private String imageSelector;
    private String linkSelector;

    private Integer maxDepth;
    private Integer maxPages;
    private Long delayMs;
    private Boolean useDynamic;
    private Integer waitForJsMs;

    private String cronExpression;
    private Boolean enabled;
    private Integer defaultMaxArticles;
    private String defaultCategory;
    private Integer defaultDifficulty;

    private Long creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
