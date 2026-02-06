package com.novacloudedu.backend.interfaces.rest.scraper.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 动态网页抓取请求
 */
@Data
public class DynamicScrapeRequest {

    @NotBlank(message = "URL不能为空")
    private String url;

    private ScrapeRequest.ScrapeConfigRequest config;

    private boolean recursive = false;

    private int maxArticles = 10;

    /**
     * JavaScript 等待时间（毫秒）
     */
    private int waitForJsMs = 3000;

    /**
     * 等待特定元素出现的选择器（可选）
     */
    private String waitForSelector;

    /**
     * 等待超时时间（秒）
     */
    private int timeoutSeconds = 30;
}
