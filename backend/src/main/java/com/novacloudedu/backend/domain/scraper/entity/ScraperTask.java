package com.novacloudedu.backend.domain.scraper.entity;

import com.novacloudedu.backend.domain.scraper.valueobject.ScraperConfigId;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperStatus;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperTaskId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 抓取任务实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ScraperTask {

    private ScraperTaskId id;
    private ScraperConfigId configId;
    private String configName;
    private ScraperStatus status;
    private Integer totalArticles;
    private Integer successCount;
    private Integer failCount;
    private List<Long> createdArticleIds;
    private String errorMessage;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Long durationMs;
    private LocalDateTime createTime;

    public static ScraperTask create(ScraperConfigId configId, String configName) {
        ScraperTask task = new ScraperTask();
        task.configId = configId;
        task.configName = configName;
        task.status = ScraperStatus.PENDING;
        task.totalArticles = 0;
        task.successCount = 0;
        task.failCount = 0;
        task.createdArticleIds = new ArrayList<>();
        task.createTime = LocalDateTime.now();
        return task;
    }

    public static ScraperTask reconstruct(ScraperTaskId id, ScraperConfigId configId, String configName,
                                           ScraperStatus status, Integer totalArticles, Integer successCount,
                                           Integer failCount, List<Long> createdArticleIds, String errorMessage,
                                           LocalDateTime startTime, LocalDateTime endTime, Long durationMs,
                                           LocalDateTime createTime) {
        ScraperTask task = new ScraperTask();
        task.id = id;
        task.configId = configId;
        task.configName = configName;
        task.status = status;
        task.totalArticles = totalArticles;
        task.successCount = successCount;
        task.failCount = failCount;
        task.createdArticleIds = createdArticleIds != null ? createdArticleIds : new ArrayList<>();
        task.errorMessage = errorMessage;
        task.startTime = startTime;
        task.endTime = endTime;
        task.durationMs = durationMs;
        task.createTime = createTime;
        return task;
    }

    public void assignId(ScraperTaskId id) {
        if (this.id != null) {
            throw new IllegalStateException("任务ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void start() {
        this.status = ScraperStatus.RUNNING;
        this.startTime = LocalDateTime.now();
    }

    public void complete(int totalArticles, int successCount, int failCount, List<Long> createdArticleIds) {
        this.totalArticles = totalArticles;
        this.successCount = successCount;
        this.failCount = failCount;
        this.createdArticleIds = createdArticleIds != null ? createdArticleIds : new ArrayList<>();
        this.endTime = LocalDateTime.now();
        this.durationMs = java.time.Duration.between(startTime, endTime).toMillis();
        
        if (failCount == 0 && successCount > 0) {
            this.status = ScraperStatus.SUCCESS;
        } else if (successCount > 0) {
            this.status = ScraperStatus.PARTIAL;
        } else {
            this.status = ScraperStatus.FAILED;
        }
    }

    public void fail(String errorMessage) {
        this.status = ScraperStatus.FAILED;
        this.errorMessage = errorMessage;
        this.endTime = LocalDateTime.now();
        if (this.startTime != null) {
            this.durationMs = java.time.Duration.between(startTime, endTime).toMillis();
        }
    }

    /**
     * 设置部分错误信息（任务完成但有部分文章保存失败时使用）
     */
    public void setPartialErrors(String errors) {
        this.errorMessage = errors;
    }

    public void addCreatedArticle(Long articleId) {
        if (this.createdArticleIds == null) {
            this.createdArticleIds = new ArrayList<>();
        }
        this.createdArticleIds.add(articleId);
        this.successCount++;
    }

    public boolean isRunning() {
        return this.status == ScraperStatus.RUNNING;
    }

    public boolean isCompleted() {
        return this.status == ScraperStatus.SUCCESS || 
               this.status == ScraperStatus.FAILED || 
               this.status == ScraperStatus.PARTIAL;
    }
}
