package com.novacloudedu.backend.interfaces.rest.scraper.dto.response;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 抓取结果响应
 */
@Data
@Builder
public class ScrapeResultResponse {

    private String sourceUrl;
    private List<ArticleResponse> articles;
    private int totalPages;
    private int successCount;
    private int failCount;
    private List<String> errors;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private long durationMs;
    private boolean hasErrors;
}
