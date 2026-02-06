package com.novacloudedu.backend.interfaces.rest.scraper.dto.response;

import lombok.Builder;
import lombok.Data;

/**
 * 文章来源响应
 */
@Data
@Builder
public class ArticleSourceResponse {

    private String code;
    private String name;
    private String baseUrl;
    private String description;
}
