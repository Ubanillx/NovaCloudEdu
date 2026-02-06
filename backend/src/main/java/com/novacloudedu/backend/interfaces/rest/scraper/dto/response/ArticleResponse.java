package com.novacloudedu.backend.interfaces.rest.scraper.dto.response;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 文章响应
 */
@Data
@Builder
public class ArticleResponse {

    private String title;
    private String author;
    private String source;
    private String content;
    private String summary;
    private String url;
    private String coverImage;
    private List<String> images;
    private String sourceType;
    private String sourceTypeName;
    private LocalDateTime publishTime;
    private LocalDateTime scrapeTime;
}
