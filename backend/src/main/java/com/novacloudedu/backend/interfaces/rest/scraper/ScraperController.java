package com.novacloudedu.backend.interfaces.rest.scraper;

import com.novacloudedu.backend.application.scraper.command.ScrapeCommand;
import com.novacloudedu.backend.application.scraper.service.ScraperApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.scraper.entity.ScrapedArticle;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeResult;
import com.novacloudedu.backend.interfaces.rest.scraper.assembler.ScraperAssembler;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.request.BatchScrapeRequest;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.request.DynamicScrapeRequest;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.request.ScrapeRequest;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.request.SourceScrapeRequest;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ArticleResponse;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ArticleSourceResponse;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ScrapeResultResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 网页抓取控制器
 */
@Tag(name = "网页抓取", description = "网页内容抓取接口")
@RestController
@RequestMapping("/api/scraper")
@RequiredArgsConstructor
@Slf4j
public class ScraperController {

    private final ScraperApplicationService scraperApplicationService;
    private final ScraperAssembler scraperAssembler;

    /**
     * 抓取单个页面
     */
    @Operation(summary = "抓取单个页面", description = "抓取指定URL的页面内容，提取标题、作者、来源、正文等信息")
    @PostMapping("/single")
    public BaseResponse<ArticleResponse> scrapeSinglePage(@Valid @RequestBody ScrapeRequest request) {
        log.info("抓取单个页面请求: {}", request.getUrl());
        ScrapeCommand command = scraperAssembler.toCommand(request);
        ScrapedArticle article = scraperApplicationService.scrapeSinglePage(command);
        return ResultUtils.success(scraperAssembler.toArticleResponse(article));
    }

    /**
     * 获取页面中的文章链接
     */
    @Operation(summary = "获取文章链接", description = "从列表页获取所有文章链接")
    @PostMapping("/links")
    public BaseResponse<List<String>> scrapeArticleLinks(@Valid @RequestBody ScrapeRequest request) {
        log.info("获取文章链接请求: {}", request.getUrl());
        ScrapeCommand.ScrapeConfigCommand configCommand = scraperAssembler.toConfigCommand(request.getConfig());
        List<String> links = scraperApplicationService.scrapeArticleLinks(request.getUrl(), configCommand);
        return ResultUtils.success(links);
    }

    /**
     * 批量抓取多个页面
     */
    @Operation(summary = "批量抓取", description = "批量抓取多个URL的页面内容")
    @PostMapping("/batch")
    public BaseResponse<ScrapeResultResponse> scrapeMultiplePages(@Valid @RequestBody BatchScrapeRequest request) {
        log.info("批量抓取请求, URL数量: {}", request.getUrls().size());
        ScrapeCommand.ScrapeConfigCommand configCommand = scraperAssembler.toConfigCommand(request);
        ScrapeResult result = scraperApplicationService.scrapeMultiplePages(request.getUrls(), configCommand);
        return ResultUtils.success(scraperAssembler.toScrapeResultResponse(result));
    }

    /**
     * 递归抓取网站
     */
    @Operation(summary = "递归抓取", description = "从起始URL开始递归抓取网站内容，支持嵌套页面扫描")
    @PostMapping("/recursive")
    public BaseResponse<ScrapeResultResponse> scrapeRecursively(@Valid @RequestBody ScrapeRequest request) {
        log.info("递归抓取请求: {}, 最大文章数: {}", request.getUrl(), request.getMaxArticles());
        request.setRecursive(true);
        ScrapeCommand command = scraperAssembler.toCommand(request);
        ScrapeResult result = scraperApplicationService.scrapeRecursively(command);
        return ResultUtils.success(scraperAssembler.toScrapeResultResponse(result));
    }

    /**
     * 从预设来源抓取
     */
    @Operation(summary = "从预设来源抓取", description = "使用预设的来源配置抓取内容，支持 Dogo News、Science News for Students 等")
    @PostMapping("/source")
    public BaseResponse<ScrapeResultResponse> scrapeFromSource(@Valid @RequestBody SourceScrapeRequest request) {
        log.info("从预设来源抓取: {}, 最大文章数: {}", request.getSourceCode(), request.getMaxArticles());
        ScrapeResult result = scraperApplicationService.scrapeFromSource(
                request.getSourceCode(), request.getMaxArticles());
        return ResultUtils.success(scraperAssembler.toScrapeResultResponse(result));
    }

    /**
     * 智能抓取
     */
    @Operation(summary = "智能抓取", description = "自动识别页面类型并使用最佳策略抓取")
    @PostMapping("/smart")
    public BaseResponse<ScrapeResultResponse> smartScrape(
            @RequestParam String url,
            @RequestParam(defaultValue = "10") int maxArticles) {
        log.info("智能抓取请求: {}, 最大文章数: {}", url, maxArticles);
        ScrapeResult result = scraperApplicationService.smartScrape(url, maxArticles);
        return ResultUtils.success(scraperAssembler.toScrapeResultResponse(result));
    }

    /**
     * 获取支持的预设来源列表
     */
    @Operation(summary = "获取预设来源列表", description = "获取所有支持的预设新闻来源")
    @GetMapping("/sources")
    public BaseResponse<List<ArticleSourceResponse>> getSupportedSources() {
        List<ScraperApplicationService.ArticleSourceInfo> sources = 
                scraperApplicationService.getSupportedSources();
        return ResultUtils.success(scraperAssembler.toSourceResponseList(sources));
    }

    /**
     * 快速抓取 - GET 方式
     */
    @Operation(summary = "快速抓取", description = "通过GET方式快速抓取单个页面")
    @GetMapping("/quick")
    public BaseResponse<ArticleResponse> quickScrape(@RequestParam String url) {
        log.info("快速抓取请求: {}", url);
        ScrapeCommand command = ScrapeCommand.ofSinglePage(url, null);
        ScrapedArticle article = scraperApplicationService.scrapeSinglePage(command);
        return ResultUtils.success(scraperAssembler.toArticleResponse(article));
    }

    // ==================== 动态网页抓取接口 ====================

    /**
     * 动态抓取单个页面（支持 JavaScript 渲染）
     */
    @Operation(summary = "动态抓取单个页面", description = "使用无头浏览器抓取 JavaScript 渲染的动态页面")
    @PostMapping("/dynamic/single")
    public BaseResponse<ArticleResponse> scrapeDynamicPage(@Valid @RequestBody DynamicScrapeRequest request) {
        log.info("动态抓取单个页面请求: {}, 等待时间: {}ms", request.getUrl(), request.getWaitForJsMs());
        ScrapeCommand command = scraperAssembler.toDynamicCommand(request);
        ScrapedArticle article = scraperApplicationService.scrapeDynamicPage(command, request.getWaitForJsMs());
        return ResultUtils.success(scraperAssembler.toArticleResponse(article));
    }

    /**
     * 动态抓取文章链接
     */
    @Operation(summary = "动态获取文章链接", description = "从动态页面获取所有文章链接")
    @PostMapping("/dynamic/links")
    public BaseResponse<List<String>> scrapeDynamicArticleLinks(@Valid @RequestBody DynamicScrapeRequest request) {
        log.info("动态获取文章链接请求: {}", request.getUrl());
        ScrapeCommand.ScrapeConfigCommand configCommand = scraperAssembler.toConfigCommand(request.getConfig());
        List<String> links = scraperApplicationService.scrapeDynamicArticleLinks(
                request.getUrl(), configCommand, request.getWaitForJsMs());
        return ResultUtils.success(links);
    }

    /**
     * 批量动态抓取
     */
    @Operation(summary = "批量动态抓取", description = "批量抓取多个动态页面")
    @PostMapping("/dynamic/batch")
    public BaseResponse<ScrapeResultResponse> scrapeDynamicMultiplePages(@Valid @RequestBody BatchScrapeRequest request,
                                                                          @RequestParam(defaultValue = "3000") int waitForJsMs) {
        log.info("批量动态抓取请求, URL数量: {}", request.getUrls().size());
        ScrapeCommand.ScrapeConfigCommand configCommand = scraperAssembler.toConfigCommand(request);
        ScrapeResult result = scraperApplicationService.scrapeDynamicMultiplePages(
                request.getUrls(), configCommand, waitForJsMs);
        return ResultUtils.success(scraperAssembler.toScrapeResultResponse(result));
    }

    /**
     * 递归动态抓取
     */
    @Operation(summary = "递归动态抓取", description = "递归抓取动态网站，支持 SPA 和 JavaScript 渲染页面")
    @PostMapping("/dynamic/recursive")
    public BaseResponse<ScrapeResultResponse> scrapeDynamicRecursively(@Valid @RequestBody DynamicScrapeRequest request) {
        log.info("递归动态抓取请求: {}, 最大文章数: {}", request.getUrl(), request.getMaxArticles());
        ScrapeCommand command = scraperAssembler.toDynamicCommand(request);
        ScrapeResult result = scraperApplicationService.scrapeDynamicRecursively(command, request.getWaitForJsMs());
        return ResultUtils.success(scraperAssembler.toScrapeResultResponse(result));
    }

    /**
     * 动态抓取（等待特定元素）
     */
    @Operation(summary = "动态抓取（等待元素）", description = "等待页面特定元素加载后再抓取")
    @PostMapping("/dynamic/wait-for")
    public BaseResponse<ArticleResponse> scrapeDynamicPageWithSelector(@Valid @RequestBody DynamicScrapeRequest request) {
        log.info("动态抓取（等待选择器）: {}, 选择器: {}", request.getUrl(), request.getWaitForSelector());
        ScrapeCommand.ScrapeConfigCommand configCommand = scraperAssembler.toConfigCommand(request.getConfig());
        ScrapedArticle article = scraperApplicationService.scrapeDynamicPageWithSelector(
                request.getUrl(), configCommand, request.getWaitForSelector(), request.getTimeoutSeconds());
        return ResultUtils.success(scraperAssembler.toArticleResponse(article));
    }

    /**
     * 智能动态抓取
     */
    @Operation(summary = "智能动态抓取", description = "自动检测是否需要动态抓取，先尝试静态抓取，失败后自动切换到动态抓取")
    @PostMapping("/dynamic/smart")
    public BaseResponse<ScrapeResultResponse> smartDynamicScrape(
            @RequestParam String url,
            @RequestParam(defaultValue = "10") int maxArticles,
            @RequestParam(defaultValue = "false") boolean forceDynamic) {
        log.info("智能动态抓取请求: {}, 强制动态: {}", url, forceDynamic);
        ScrapeResult result = scraperApplicationService.smartDynamicScrape(url, maxArticles, forceDynamic);
        return ResultUtils.success(scraperAssembler.toScrapeResultResponse(result));
    }

    /**
     * 快速动态抓取 - GET 方式
     */
    @Operation(summary = "快速动态抓取", description = "通过GET方式快速动态抓取单个页面")
    @GetMapping("/dynamic/quick")
    public BaseResponse<ArticleResponse> quickDynamicScrape(
            @RequestParam String url,
            @RequestParam(defaultValue = "3000") int waitForJsMs) {
        log.info("快速动态抓取请求: {}", url);
        ScrapeCommand command = ScrapeCommand.ofSinglePage(url, null);
        ScrapedArticle article = scraperApplicationService.scrapeDynamicPage(command, waitForJsMs);
        return ResultUtils.success(scraperAssembler.toArticleResponse(article));
    }
}
