package com.novacloudedu.backend.domain.scraper.entity;

import com.novacloudedu.backend.domain.scraper.valueobject.ScraperConfigId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 抓取源配置实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ScraperSourceConfig {

    private ScraperConfigId id;
    private String name;
    private String sourceCode;
    private String baseUrl;
    private String description;
    
    // 选择器配置
    private String titleSelector;
    private String authorSelector;
    private String sourceSelector;
    private String contentSelector;
    private String dateSelector;
    private String imageSelector;
    private String linkSelector;
    
    // 抓取配置
    private Integer maxDepth;
    private Integer maxPages;
    private Long delayMs;
    private Boolean useDynamic;
    private Integer waitForJsMs;
    
    // 调度配置
    private String cronExpression;
    private Boolean enabled;
    private Integer defaultMaxArticles;
    private String defaultCategory;
    private Integer defaultDifficulty;
    
    private UserId creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static ScraperSourceConfig create(String name, String sourceCode, String baseUrl, String description,
                                              String titleSelector, String authorSelector, String sourceSelector,
                                              String contentSelector, String dateSelector, String imageSelector,
                                              String linkSelector, Integer maxDepth, Integer maxPages, Long delayMs,
                                              Boolean useDynamic, Integer waitForJsMs, String cronExpression,
                                              Boolean enabled, Integer defaultMaxArticles, String defaultCategory,
                                              Integer defaultDifficulty, UserId creatorId) {
        ScraperSourceConfig config = new ScraperSourceConfig();
        config.name = name;
        config.sourceCode = sourceCode;
        config.baseUrl = baseUrl;
        config.description = description;
        config.titleSelector = titleSelector;
        config.authorSelector = authorSelector;
        config.sourceSelector = sourceSelector;
        config.contentSelector = contentSelector;
        config.dateSelector = dateSelector;
        config.imageSelector = imageSelector;
        config.linkSelector = linkSelector;
        config.maxDepth = maxDepth != null ? maxDepth : 2;
        config.maxPages = maxPages != null ? maxPages : 10;
        config.delayMs = delayMs != null ? delayMs : 1500L;
        config.useDynamic = useDynamic != null ? useDynamic : false;
        config.waitForJsMs = waitForJsMs != null ? waitForJsMs : 3000;
        config.cronExpression = cronExpression;
        config.enabled = enabled != null ? enabled : true;
        config.defaultMaxArticles = defaultMaxArticles != null ? defaultMaxArticles : 5;
        config.defaultCategory = defaultCategory;
        config.defaultDifficulty = defaultDifficulty != null ? defaultDifficulty : 2;
        config.creatorId = creatorId;
        config.createTime = LocalDateTime.now();
        config.updateTime = LocalDateTime.now();
        return config;
    }

    public static ScraperSourceConfig reconstruct(ScraperConfigId id, String name, String sourceCode, String baseUrl,
                                                    String description, String titleSelector, String authorSelector,
                                                    String sourceSelector, String contentSelector, String dateSelector,
                                                    String imageSelector, String linkSelector, Integer maxDepth,
                                                    Integer maxPages, Long delayMs, Boolean useDynamic,
                                                    Integer waitForJsMs, String cronExpression, Boolean enabled,
                                                    Integer defaultMaxArticles, String defaultCategory,
                                                    Integer defaultDifficulty, UserId creatorId,
                                                    LocalDateTime createTime, LocalDateTime updateTime) {
        ScraperSourceConfig config = new ScraperSourceConfig();
        config.id = id;
        config.name = name;
        config.sourceCode = sourceCode;
        config.baseUrl = baseUrl;
        config.description = description;
        config.titleSelector = titleSelector;
        config.authorSelector = authorSelector;
        config.sourceSelector = sourceSelector;
        config.contentSelector = contentSelector;
        config.dateSelector = dateSelector;
        config.imageSelector = imageSelector;
        config.linkSelector = linkSelector;
        config.maxDepth = maxDepth;
        config.maxPages = maxPages;
        config.delayMs = delayMs;
        config.useDynamic = useDynamic;
        config.waitForJsMs = waitForJsMs;
        config.cronExpression = cronExpression;
        config.enabled = enabled;
        config.defaultMaxArticles = defaultMaxArticles;
        config.defaultCategory = defaultCategory;
        config.defaultDifficulty = defaultDifficulty;
        config.creatorId = creatorId;
        config.createTime = createTime;
        config.updateTime = updateTime;
        return config;
    }

    public void assignId(ScraperConfigId id) {
        if (this.id != null) {
            throw new IllegalStateException("配置ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void updateConfig(String name, String baseUrl, String description,
                             String titleSelector, String authorSelector, String sourceSelector,
                             String contentSelector, String dateSelector, String imageSelector,
                             String linkSelector, Integer maxDepth, Integer maxPages, Long delayMs,
                             Boolean useDynamic, Integer waitForJsMs, String cronExpression,
                             Boolean enabled, Integer defaultMaxArticles, String defaultCategory,
                             Integer defaultDifficulty) {
        this.name = name;
        this.baseUrl = baseUrl;
        this.description = description;
        this.titleSelector = titleSelector;
        this.authorSelector = authorSelector;
        this.sourceSelector = sourceSelector;
        this.contentSelector = contentSelector;
        this.dateSelector = dateSelector;
        this.imageSelector = imageSelector;
        this.linkSelector = linkSelector;
        this.maxDepth = maxDepth;
        this.maxPages = maxPages;
        this.delayMs = delayMs;
        this.useDynamic = useDynamic;
        this.waitForJsMs = waitForJsMs;
        this.cronExpression = cronExpression;
        this.enabled = enabled;
        this.defaultMaxArticles = defaultMaxArticles;
        this.defaultCategory = defaultCategory;
        this.defaultDifficulty = defaultDifficulty;
        this.updateTime = LocalDateTime.now();
    }

    public void enable() {
        this.enabled = true;
        this.updateTime = LocalDateTime.now();
    }

    public void disable() {
        this.enabled = false;
        this.updateTime = LocalDateTime.now();
    }

    public boolean isEnabled() {
        return Boolean.TRUE.equals(this.enabled);
    }

    public boolean isDynamic() {
        return Boolean.TRUE.equals(this.useDynamic);
    }
}
