package com.novacloudedu.backend.domain.scraper.entity;

import com.novacloudedu.backend.domain.scraper.valueobject.ArticleSource;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 抓取的文章实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ScrapedArticle {

    private String title;
    private String author;
    private String source;
    private String content;
    private String url;
    private String coverImage;
    private List<String> images;
    private ArticleSource articleSource;
    private LocalDateTime publishTime;
    private LocalDateTime scrapeTime;

    /**
     * 创建抓取的文章
     */
    public static ScrapedArticle create(String title, String author, String source,
                                         String content, String url, String coverImage,
                                         List<String> images, ArticleSource articleSource,
                                         LocalDateTime publishTime) {
        ScrapedArticle article = new ScrapedArticle();
        article.title = title != null ? title.trim() : "";
        article.author = author != null ? author.trim() : "";
        article.source = source != null ? source.trim() : "";
        article.content = content != null ? content.trim() : "";
        article.url = url;
        article.coverImage = coverImage;
        article.images = images;
        article.articleSource = articleSource;
        article.publishTime = publishTime;
        article.scrapeTime = LocalDateTime.now();
        return article;
    }

    /**
     * 检查文章是否有效
     */
    public boolean isValid() {
        return title != null && !title.isBlank() 
                && content != null && !content.isBlank();
    }

    /**
     * 获取内容摘要
     */
    public String getSummary(int maxLength) {
        if (content == null || content.isBlank()) {
            return "";
        }
        if (content.length() <= maxLength) {
            return content;
        }
        return content.substring(0, maxLength) + "...";
    }
}
