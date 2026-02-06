package com.novacloudedu.backend.interfaces.rest.scraper.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 抓取请求
 */
@Data
public class ScrapeRequest {

    @NotBlank(message = "URL不能为空")
    private String url;

    private ScrapeConfigRequest config;

    private boolean recursive = false;

    private int maxArticles = 10;

    @Data
    public static class ScrapeConfigRequest {
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
    }
}
