package com.novacloudedu.backend.domain.scraper.valueobject;

/**
 * 抓取任务ID值对象
 */
public record ScraperTaskId(Long value) {

    public static ScraperTaskId of(Long value) {
        return new ScraperTaskId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
