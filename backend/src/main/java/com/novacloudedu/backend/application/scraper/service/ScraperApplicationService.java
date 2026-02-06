package com.novacloudedu.backend.application.scraper.service;

import com.novacloudedu.backend.application.scraper.command.ScrapeCommand;
import com.novacloudedu.backend.domain.scraper.entity.ScrapedArticle;
import com.novacloudedu.backend.domain.scraper.service.WebScraperService;
import com.novacloudedu.backend.domain.scraper.valueobject.ArticleSource;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeConfig;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeResult;
import com.novacloudedu.backend.infrastructure.scraper.SeleniumWebScraperService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 网页抓取应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ScraperApplicationService {

    private final WebScraperService webScraperService;
    private final SeleniumWebScraperService seleniumWebScraperService;

    /**
     * 抓取单个页面
     */
    public ScrapedArticle scrapeSinglePage(ScrapeCommand command) {
        log.info("开始抓取单个页面: {}", command.url());
        ScrapeConfig config = buildConfig(command.config());
        return webScraperService.scrapeSinglePage(command.url(), config);
    }

    /**
     * 抓取文章链接列表
     */
    public List<String> scrapeArticleLinks(String listUrl, ScrapeCommand.ScrapeConfigCommand configCommand) {
        log.info("开始抓取文章链接: {}", listUrl);
        ScrapeConfig config = buildConfig(configCommand);
        return webScraperService.scrapeArticleLinks(listUrl, config);
    }

    /**
     * 批量抓取多个页面
     */
    public ScrapeResult scrapeMultiplePages(List<String> urls, ScrapeCommand.ScrapeConfigCommand configCommand) {
        log.info("开始批量抓取, 页面数: {}", urls.size());
        ScrapeConfig config = buildConfig(configCommand);
        return webScraperService.scrapeMultiplePages(urls, config);
    }

    /**
     * 递归抓取网站
     */
    public ScrapeResult scrapeRecursively(ScrapeCommand command) {
        log.info("开始递归抓取: {}, 最大文章数: {}", command.url(), command.maxArticles());
        ScrapeConfig config = buildConfig(command.config());
        return webScraperService.scrapeRecursively(command.url(), config);
    }

    /**
     * 从预设来源抓取
     */
    public ScrapeResult scrapeFromSource(String sourceCode, int maxArticles) {
        log.info("从预设来源抓取: {}, 最大文章数: {}", sourceCode, maxArticles);
        ArticleSource source = ArticleSource.fromCode(sourceCode);
        return webScraperService.scrapeFromSource(source, maxArticles);
    }

    /**
     * 获取所有支持的预设来源
     */
    public List<ArticleSourceInfo> getSupportedSources() {
        return java.util.Arrays.stream(ArticleSource.values())
                .filter(s -> s != ArticleSource.CUSTOM)
                .map(s -> new ArticleSourceInfo(s.getCode(), s.getDisplayName(), s.getBaseUrl()))
                .toList();
    }

    /**
     * 智能抓取 - 自动检测页面类型并抓取
     */
    public ScrapeResult smartScrape(String url, int maxArticles) {
        log.info("智能抓取: {}", url);
        
        // 尝试识别来源
        ArticleSource source = ArticleSource.fromUrl(url);
        if (source != ArticleSource.CUSTOM) {
            return webScraperService.scrapeFromSource(source, maxArticles);
        }
        
        // 使用默认配置递归抓取
        ScrapeConfig config = ScrapeConfig.builder()
                .maxPages(maxArticles)
                .build();
        return webScraperService.scrapeRecursively(url, config);
    }

    /**
     * 构建抓取配置
     */
    private ScrapeConfig buildConfig(ScrapeCommand.ScrapeConfigCommand configCommand) {
        if (configCommand == null) {
            return ScrapeConfig.builder().build();
        }
        
        ScrapeConfig.Builder builder = ScrapeConfig.builder();
        
        if (configCommand.titleSelector() != null) {
            builder.titleSelector(configCommand.titleSelector());
        }
        if (configCommand.authorSelector() != null) {
            builder.authorSelector(configCommand.authorSelector());
        }
        if (configCommand.sourceSelector() != null) {
            builder.sourceSelector(configCommand.sourceSelector());
        }
        if (configCommand.contentSelector() != null) {
            builder.contentSelector(configCommand.contentSelector());
        }
        if (configCommand.dateSelector() != null) {
            builder.dateSelector(configCommand.dateSelector());
        }
        if (configCommand.imageSelector() != null) {
            builder.imageSelector(configCommand.imageSelector());
        }
        if (configCommand.linkSelector() != null) {
            builder.linkSelector(configCommand.linkSelector());
        }
        if (configCommand.maxDepth() != null) {
            builder.maxDepth(configCommand.maxDepth());
        }
        if (configCommand.maxPages() != null) {
            builder.maxPages(configCommand.maxPages());
        }
        if (configCommand.delayMs() != null) {
            builder.delayMs(configCommand.delayMs());
        }
        
        return builder.build();
    }

    // ==================== 动态网页抓取方法 ====================

    /**
     * 动态抓取单个页面（支持 JavaScript 渲染）
     */
    public ScrapedArticle scrapeDynamicPage(ScrapeCommand command, int waitForJsMs) {
        log.info("开始动态抓取单个页面: {}, 等待时间: {}ms", command.url(), waitForJsMs);
        ScrapeConfig config = buildConfig(command.config());
        return seleniumWebScraperService.scrapeDynamicPage(command.url(), config, waitForJsMs);
    }

    /**
     * 动态抓取文章链接列表
     */
    public List<String> scrapeDynamicArticleLinks(String listUrl, ScrapeCommand.ScrapeConfigCommand configCommand, int waitForJsMs) {
        log.info("开始动态抓取文章链接: {}", listUrl);
        ScrapeConfig config = buildConfig(configCommand);
        return seleniumWebScraperService.scrapeDynamicArticleLinks(listUrl, config, waitForJsMs);
    }

    /**
     * 批量动态抓取多个页面
     */
    public ScrapeResult scrapeDynamicMultiplePages(List<String> urls, ScrapeCommand.ScrapeConfigCommand configCommand, int waitForJsMs) {
        log.info("开始批量动态抓取, 页面数: {}", urls.size());
        ScrapeConfig config = buildConfig(configCommand);
        return seleniumWebScraperService.scrapeDynamicMultiplePages(urls, config, waitForJsMs);
    }

    /**
     * 递归动态抓取网站
     */
    public ScrapeResult scrapeDynamicRecursively(ScrapeCommand command, int waitForJsMs) {
        log.info("开始递归动态抓取: {}, 最大文章数: {}", command.url(), command.maxArticles());
        ScrapeConfig config = buildConfig(command.config());
        return seleniumWebScraperService.scrapeDynamicRecursively(command.url(), config, waitForJsMs);
    }

    /**
     * 动态抓取页面（等待特定元素加载）
     */
    public ScrapedArticle scrapeDynamicPageWithSelector(String url, ScrapeCommand.ScrapeConfigCommand configCommand, 
                                                         String waitForSelector, int timeoutSeconds) {
        log.info("开始动态抓取页面（等待选择器）: {}, 选择器: {}", url, waitForSelector);
        ScrapeConfig config = buildConfig(configCommand);
        return seleniumWebScraperService.scrapeDynamicPageWithSelector(url, config, waitForSelector, timeoutSeconds);
    }

    /**
     * 智能动态抓取 - 自动检测是否需要动态抓取
     */
    public ScrapeResult smartDynamicScrape(String url, int maxArticles, boolean forceDynamic) {
        log.info("智能动态抓取: {}, 强制动态: {}", url, forceDynamic);
        
        ScrapeConfig config = ScrapeConfig.builder()
                .maxPages(maxArticles)
                .build();
        
        if (forceDynamic) {
            return seleniumWebScraperService.scrapeDynamicRecursively(url, config, 3000);
        }
        
        // 先尝试静态抓取
        ScrapeResult staticResult = webScraperService.scrapeRecursively(url, config);
        
        // 如果静态抓取结果为空或内容太少，尝试动态抓取
        if (staticResult.isEmpty() || staticResult.getSuccessCount() == 0) {
            log.info("静态抓取结果为空，切换到动态抓取");
            return seleniumWebScraperService.scrapeDynamicRecursively(url, config, 3000);
        }
        
        return staticResult;
    }

    /**
     * 文章来源信息
     */
    public record ArticleSourceInfo(String code, String name, String baseUrl) {}
}
