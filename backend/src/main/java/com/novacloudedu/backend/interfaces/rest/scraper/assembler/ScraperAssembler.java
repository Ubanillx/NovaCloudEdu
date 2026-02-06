package com.novacloudedu.backend.interfaces.rest.scraper.assembler;

import com.novacloudedu.backend.application.scraper.command.ScrapeCommand;
import com.novacloudedu.backend.application.scraper.service.ScraperApplicationService;
import com.novacloudedu.backend.domain.scraper.entity.ScrapedArticle;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeResult;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.request.BatchScrapeRequest;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.request.DynamicScrapeRequest;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.request.ScrapeRequest;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ArticleResponse;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ArticleSourceResponse;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ScrapeResultResponse;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 抓取模块装配器
 */
@Component
public class ScraperAssembler {

    private static final int SUMMARY_LENGTH = 200;

    /**
     * 转换请求为命令
     */
    public ScrapeCommand toCommand(ScrapeRequest request) {
        ScrapeCommand.ScrapeConfigCommand configCommand = null;
        if (request.getConfig() != null) {
            configCommand = toConfigCommand(request.getConfig());
        }
        
        if (request.isRecursive()) {
            return ScrapeCommand.ofRecursive(request.getUrl(), configCommand, request.getMaxArticles());
        } else {
            return ScrapeCommand.ofSinglePage(request.getUrl(), configCommand);
        }
    }

    /**
     * 转换配置请求为配置命令
     */
    public ScrapeCommand.ScrapeConfigCommand toConfigCommand(ScrapeRequest.ScrapeConfigRequest config) {
        if (config == null) {
            return ScrapeCommand.ScrapeConfigCommand.defaults();
        }
        return new ScrapeCommand.ScrapeConfigCommand(
                config.getTitleSelector(),
                config.getAuthorSelector(),
                config.getSourceSelector(),
                config.getContentSelector(),
                config.getDateSelector(),
                config.getImageSelector(),
                config.getLinkSelector(),
                config.getMaxDepth(),
                config.getMaxPages(),
                config.getDelayMs()
        );
    }

    /**
     * 转换批量请求的配置
     */
    public ScrapeCommand.ScrapeConfigCommand toConfigCommand(BatchScrapeRequest request) {
        return toConfigCommand(request.getConfig());
    }

    /**
     * 转换文章实体为响应
     */
    public ArticleResponse toArticleResponse(ScrapedArticle article) {
        if (article == null) {
            return null;
        }
        return ArticleResponse.builder()
                .title(article.getTitle())
                .author(article.getAuthor())
                .source(article.getSource())
                .content(article.getContent())
                .summary(article.getSummary(SUMMARY_LENGTH))
                .url(article.getUrl())
                .coverImage(article.getCoverImage())
                .images(article.getImages())
                .sourceType(article.getArticleSource() != null ? article.getArticleSource().getCode() : null)
                .sourceTypeName(article.getArticleSource() != null ? article.getArticleSource().getDisplayName() : null)
                .publishTime(article.getPublishTime())
                .scrapeTime(article.getScrapeTime())
                .build();
    }

    /**
     * 转换抓取结果为响应
     */
    public ScrapeResultResponse toScrapeResultResponse(ScrapeResult result) {
        if (result == null) {
            return null;
        }
        
        List<ArticleResponse> articles = result.getArticles().stream()
                .map(this::toArticleResponse)
                .collect(Collectors.toList());
        
        return ScrapeResultResponse.builder()
                .sourceUrl(result.getSourceUrl())
                .articles(articles)
                .totalPages(result.getTotalPages())
                .successCount(result.getSuccessCount())
                .failCount(result.getFailCount())
                .errors(result.getErrors())
                .startTime(result.getStartTime())
                .endTime(result.getEndTime())
                .durationMs(result.getDurationMs())
                .hasErrors(result.hasErrors())
                .build();
    }

    /**
     * 转换来源信息为响应
     */
    public ArticleSourceResponse toSourceResponse(ScraperApplicationService.ArticleSourceInfo info) {
        return ArticleSourceResponse.builder()
                .code(info.code())
                .name(info.name())
                .baseUrl(info.baseUrl())
                .build();
    }

    /**
     * 转换来源信息列表为响应列表
     */
    public List<ArticleSourceResponse> toSourceResponseList(List<ScraperApplicationService.ArticleSourceInfo> infos) {
        return infos.stream()
                .map(this::toSourceResponse)
                .collect(Collectors.toList());
    }

    /**
     * 转换动态抓取请求为命令
     */
    public ScrapeCommand toDynamicCommand(DynamicScrapeRequest request) {
        ScrapeCommand.ScrapeConfigCommand configCommand = null;
        if (request.getConfig() != null) {
            configCommand = toConfigCommand(request.getConfig());
        }
        
        if (request.isRecursive()) {
            return ScrapeCommand.ofRecursive(request.getUrl(), configCommand, request.getMaxArticles());
        } else {
            return ScrapeCommand.ofSinglePage(request.getUrl(), configCommand);
        }
    }
}
