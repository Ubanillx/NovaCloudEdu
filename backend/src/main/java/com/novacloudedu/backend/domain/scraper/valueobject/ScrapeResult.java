package com.novacloudedu.backend.domain.scraper.valueobject;

import com.novacloudedu.backend.domain.scraper.entity.ScrapedArticle;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 抓取结果值对象
 */
@Getter
public class ScrapeResult {

    private final String sourceUrl;
    private final List<ScrapedArticle> articles;
    private final int totalPages;
    private final int successCount;
    private final int failCount;
    private final List<String> errors;
    private final LocalDateTime startTime;
    private final LocalDateTime endTime;
    private final long durationMs;

    private ScrapeResult(Builder builder) {
        this.sourceUrl = builder.sourceUrl;
        this.articles = builder.articles;
        this.totalPages = builder.totalPages;
        this.successCount = builder.successCount;
        this.failCount = builder.failCount;
        this.errors = builder.errors;
        this.startTime = builder.startTime;
        this.endTime = builder.endTime;
        this.durationMs = builder.durationMs;
    }

    public boolean hasErrors() {
        return !errors.isEmpty();
    }

    public boolean isEmpty() {
        return articles.isEmpty();
    }

    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private String sourceUrl;
        private List<ScrapedArticle> articles = new ArrayList<>();
        private int totalPages = 0;
        private int successCount = 0;
        private int failCount = 0;
        private List<String> errors = new ArrayList<>();
        private LocalDateTime startTime;
        private LocalDateTime endTime;
        private long durationMs = 0;

        public Builder sourceUrl(String sourceUrl) {
            this.sourceUrl = sourceUrl;
            return this;
        }

        public Builder articles(List<ScrapedArticle> articles) {
            this.articles = articles;
            return this;
        }

        public Builder addArticle(ScrapedArticle article) {
            this.articles.add(article);
            return this;
        }

        public Builder totalPages(int totalPages) {
            this.totalPages = totalPages;
            return this;
        }

        public Builder successCount(int successCount) {
            this.successCount = successCount;
            return this;
        }

        public Builder failCount(int failCount) {
            this.failCount = failCount;
            return this;
        }

        public Builder addError(String error) {
            this.errors.add(error);
            return this;
        }

        public Builder errors(List<String> errors) {
            this.errors = errors;
            return this;
        }

        public Builder startTime(LocalDateTime startTime) {
            this.startTime = startTime;
            return this;
        }

        public Builder endTime(LocalDateTime endTime) {
            this.endTime = endTime;
            return this;
        }

        public Builder durationMs(long durationMs) {
            this.durationMs = durationMs;
            return this;
        }

        public ScrapeResult build() {
            return new ScrapeResult(this);
        }
    }
}
