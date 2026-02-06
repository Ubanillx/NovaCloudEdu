package com.novacloudedu.backend.interfaces.rest.scraper.dto.request;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.List;

/**
 * 批量抓取请求
 */
@Data
public class BatchScrapeRequest {

    @NotEmpty(message = "URL列表不能为空")
    private List<String> urls;

    private ScrapeRequest.ScrapeConfigRequest config;
}
