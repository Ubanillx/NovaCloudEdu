package com.novacloudedu.backend.domain.scraper.valueobject;

import lombok.Getter;

/**
 * 抓取配置值对象
 */
@Getter
public class ScrapeConfig {

    private final String titleSelector;
    private final String authorSelector;
    private final String sourceSelector;
    private final String contentSelector;
    private final String dateSelector;
    private final String imageSelector;
    private final String linkSelector;
    private final int maxDepth;
    private final int maxPages;
    private final long delayMs;

    private ScrapeConfig(Builder builder) {
        this.titleSelector = builder.titleSelector;
        this.authorSelector = builder.authorSelector;
        this.sourceSelector = builder.sourceSelector;
        this.contentSelector = builder.contentSelector;
        this.dateSelector = builder.dateSelector;
        this.imageSelector = builder.imageSelector;
        this.linkSelector = builder.linkSelector;
        this.maxDepth = builder.maxDepth;
        this.maxPages = builder.maxPages;
        this.delayMs = builder.delayMs;
    }

    /**
     * 获取预设配置
     */
    public static ScrapeConfig forSource(ArticleSource source) {
        return switch (source) {
            case DOGO_NEWS -> Builder.create()
                    .titleSelector("h1, .post-title, .entry-title, .article-title")
                    .authorSelector(".author, .author-name, .byline, .writer")
                    .sourceSelector(".category, .source, .tag")
                    .contentSelector(".post-content, .entry-content, .article-content, .content, article p")
                    .dateSelector(".date, .post-date, .published-date, time")
                    .imageSelector(".post-content img, .entry-content img, article img, .featured-image img")
                    .linkSelector(".post-title a, .entry-title a, article a[href*='/20'], a[href*='/news/'], a[href*='/science/'], a[href*='/world/']")
                    .maxDepth(2)
                    .delayMs(1500)
                    .build();
            case SCIENCE_NEWS_FOR_STUDENTS -> Builder.create()
                    .titleSelector("h1, .entry-title, article h1, .post-title")
                    .authorSelector(".author, .byline, .writer")
                    .sourceSelector(".category, .topic, .tag")
                    .contentSelector(".entry-content, .post-content, article p, .article-body")
                    .dateSelector(".date, time, .posted-on")
                    .imageSelector("article img, .entry-content img, figure img")
                    .linkSelector("article a[href*='/article'], a[href*='/topic/'], .post-title a")
                    .maxDepth(2)
                    .delayMs(1500)
                    .build();
            case TIME_FOR_KIDS -> Builder.create()
                    .titleSelector("h1, .article-title, .headline")
                    .authorSelector(".author, .byline, .writer")
                    .sourceSelector(".section, .category, .grade")
                    .contentSelector(".article-body, .content, article p, .story-content")
                    .dateSelector(".date, time, .publish-date")
                    .imageSelector("article img, .article-image img, figure img")
                    .linkSelector("a[href*='/g34/'], a[href*='/g56/'], .article-card a, .story-link a")
                    .maxDepth(2)
                    .delayMs(2000)
                    .build();
            case BBC_BITESIZE -> Builder.create()
                    .titleSelector("h1, .article-title, .heading")
                    .authorSelector(".author")
                    .sourceSelector(".subject, .topic, .tag")
                    .contentSelector("main p, article p, .content p, .text")
                    .dateSelector(".date, time")
                    .imageSelector("main img, article img, figure img")
                    .linkSelector("a[href*='/articles/'], a[href*='/guides/'], .card a")
                    .maxDepth(2)
                    .delayMs(2000)
                    .build();
            case NAT_GEO_KIDS -> Builder.create()
                    .titleSelector("h1, .article-title, .title")
                    .authorSelector(".author, .writer")
                    .sourceSelector(".category, .topic")
                    .contentSelector(".article-content, .body, article p, main p")
                    .dateSelector(".date, time")
                    .imageSelector("article img, .article-content img, figure img")
                    .linkSelector("a[href*='/animals/'], a[href*='/science/'], a[href*='/history/'], .card a")
                    .maxDepth(2)
                    .delayMs(3000)
                    .build();
            case FUNBRAIN -> Builder.create()
                    .titleSelector("h1, .title, .heading")
                    .authorSelector(".author")
                    .sourceSelector(".category, .type")
                    .contentSelector(".content, article p, .description")
                    .dateSelector(".date")
                    .imageSelector("article img, .content img")
                    .linkSelector("a[href*='/books/'], a[href*='/games/'], .card a")
                    .maxDepth(1)
                    .delayMs(1500)
                    .build();
            default -> Builder.create().build();
        };
    }

    public static Builder builder() {
        return Builder.create();
    }

    public static class Builder {
        // 标题选择器：ID选择器 + 类选择器 + 标签选择器
        private String titleSelector = "h1, #title, #articleTitle, #article-title, #newsTitle, " +
                ".title, .article-title, .news-title, .headline, .entry-title, " +
                "[class*='title'], [id*='title']";
        // 作者选择器
        private String authorSelector = "#author, #editor, .author, .author-name, .byline, .writer, " +
                ".editor, [class*='author'], [id*='author']";
        // 来源选择器
        private String sourceSelector = "#source, .source, .category, .origin, .from, [class*='source']";
        // 内容选择器：优先 ID，然后类，最后标签
        private String contentSelector = "#content, #articleContent, #article-content, #newsContent, " +
                "#article_content, #rm_txt_con, #p_content, #text, #main-content, " +
                ".content, .article-content, .news-content, .post-content, .entry-content, " +
                ".article-body, .news-body, .text, .detail, " +
                "[class*='content'], [class*='article'], article, main";
        // 日期选择器
        private String dateSelector = "#pubtime, #publishTime, #publish-time, #date, " +
                ".date, .time, .publish-date, .pubtime, time, [class*='time'], [class*='date']";
        // 图片选择器
        private String imageSelector = "#content img, #articleContent img, .content img, .article-content img, " +
                "article img, [class*='content'] img";
        // 链接选择器
        private String linkSelector = "a";
        private int maxDepth = 2;
        private int maxPages = 50;
        private long delayMs = 1000;

        private Builder() {}

        public static Builder create() {
            return new Builder();
        }

        public Builder titleSelector(String selector) {
            this.titleSelector = selector;
            return this;
        }

        public Builder authorSelector(String selector) {
            this.authorSelector = selector;
            return this;
        }

        public Builder sourceSelector(String selector) {
            this.sourceSelector = selector;
            return this;
        }

        public Builder contentSelector(String selector) {
            this.contentSelector = selector;
            return this;
        }

        public Builder dateSelector(String selector) {
            this.dateSelector = selector;
            return this;
        }

        public Builder imageSelector(String selector) {
            this.imageSelector = selector;
            return this;
        }

        public Builder linkSelector(String selector) {
            this.linkSelector = selector;
            return this;
        }

        public Builder maxDepth(int maxDepth) {
            this.maxDepth = maxDepth;
            return this;
        }

        public Builder maxPages(int maxPages) {
            this.maxPages = maxPages;
            return this;
        }

        public Builder delayMs(long delayMs) {
            this.delayMs = delayMs;
            return this;
        }

        public ScrapeConfig build() {
            return new ScrapeConfig(this);
        }
    }
}
