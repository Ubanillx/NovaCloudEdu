package com.novacloudedu.backend.interfaces.rest.scraper.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 抓取配置请求
 */
@Data
public class ScraperConfigRequest {

    private Long id;

    @NotBlank(message = "配置名称不能为空")
    private String name;

    @NotBlank(message = "来源代码不能为空")
    private String sourceCode;

    @NotBlank(message = "基础URL不能为空")
    private String baseUrl;

    private String description;

    private String titleSelector;
    private String authorSelector;
    private String sourceSelector;
    private String contentSelector;
    private String dateSelector;
    private String imageSelector;
    private String linkSelector;

    private Integer maxDepth = 2;
    private Integer maxPages = 10;
    private Long delayMs = 1500L;
    private Boolean useDynamic = false;
    private Integer waitForJsMs = 3000;

    private String cronExpression;
    private Boolean enabled = true;
    private Integer defaultMaxArticles = 5;
    private String defaultCategory;
    private Integer defaultDifficulty = 2;
}
