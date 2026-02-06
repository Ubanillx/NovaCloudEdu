package com.novacloudedu.backend.application.scraper.command;

/**
 * 抓取配置命令
 */
public record ScraperConfigCommand(
        Long id,
        String name,
        String sourceCode,
        String baseUrl,
        String description,
        String titleSelector,
        String authorSelector,
        String sourceSelector,
        String contentSelector,
        String dateSelector,
        String imageSelector,
        String linkSelector,
        Integer maxDepth,
        Integer maxPages,
        Long delayMs,
        Boolean useDynamic,
        Integer waitForJsMs,
        String cronExpression,
        Boolean enabled,
        Integer defaultMaxArticles,
        String defaultCategory,
        Integer defaultDifficulty
) {
    public static ScraperConfigCommand create(String name, String sourceCode, String baseUrl, String description) {
        return new ScraperConfigCommand(
                null, name, sourceCode, baseUrl, description,
                null, null, null, null, null, null, null,
                2, 10, 1500L, false, 3000,
                null, true, 5, null, 2
        );
    }
}
