package com.novacloudedu.backend.interfaces.rest.scraper.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 预设来源抓取请求
 */
@Data
public class SourceScrapeRequest {

    @NotBlank(message = "来源代码不能为空")
    private String sourceCode;

    private int maxArticles = 10;
}
