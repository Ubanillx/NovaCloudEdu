package com.novacloudedu.backend.domain.scraper.valueobject;

/**
 * 抓取配置ID值对象
 */
public record ScraperConfigId(Long value) {

    public static ScraperConfigId of(Long value) {
        return new ScraperConfigId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
