package com.novacloudedu.backend.application.scraper.command;


/**
 * 抓取命令
 */
public record ScrapeCommand(
        String url,
        String sourceCode,
        ScrapeConfigCommand config,
        boolean recursive,
        int maxArticles
) {
    public static ScrapeCommand ofSinglePage(String url, ScrapeConfigCommand config) {
        return new ScrapeCommand(url, null, config, false, 1);
    }

    public static ScrapeCommand ofRecursive(String url, ScrapeConfigCommand config, int maxArticles) {
        return new ScrapeCommand(url, null, config, true, maxArticles);
    }

    public static ScrapeCommand ofSource(String sourceCode, int maxArticles) {
        return new ScrapeCommand(null, sourceCode, null, true, maxArticles);
    }

    /**
     * 抓取配置命令
     */
    public record ScrapeConfigCommand(
            String titleSelector,
            String authorSelector,
            String sourceSelector,
            String contentSelector,
            String dateSelector,
            String imageSelector,
            String linkSelector,
            Integer maxDepth,
            Integer maxPages,
            Long delayMs
    ) {
        public static ScrapeConfigCommand defaults() {
            return new ScrapeConfigCommand(
                    "h1, .title, .article-title",
                    ".author, .byline, .author-name",
                    ".source, .category",
                    "article, .content, .article-content, main",
                    ".date, time, .publish-date",
                    "article img, .content img",
                    "a",
                    2,
                    50,
                    1000L
            );
        }
    }
}
