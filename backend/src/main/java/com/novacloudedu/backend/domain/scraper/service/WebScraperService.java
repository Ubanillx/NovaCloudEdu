package com.novacloudedu.backend.domain.scraper.service;

import com.novacloudedu.backend.domain.scraper.entity.ScrapedArticle;
import com.novacloudedu.backend.domain.scraper.valueobject.ArticleSource;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeConfig;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeResult;

import java.util.List;

/**
 * 网页抓取领域服务接口
 */
public interface WebScraperService {

    /**
     * 抓取单个页面的文章内容
     *
     * @param url    页面URL
     * @param config 抓取配置
     * @return 抓取的文章
     */
    ScrapedArticle scrapeSinglePage(String url, ScrapeConfig config);

    /**
     * 抓取列表页并获取所有文章链接
     *
     * @param listUrl 列表页URL
     * @param config  抓取配置
     * @return 文章链接列表
     */
    List<String> scrapeArticleLinks(String listUrl, ScrapeConfig config);

    /**
     * 批量抓取多个页面
     *
     * @param urls   页面URL列表
     * @param config 抓取配置
     * @return 抓取结果
     */
    ScrapeResult scrapeMultiplePages(List<String> urls, ScrapeConfig config);

    /**
     * 递归抓取网站（嵌套扫描）
     *
     * @param startUrl 起始URL
     * @param config   抓取配置
     * @return 抓取结果
     */
    ScrapeResult scrapeRecursively(String startUrl, ScrapeConfig config);

    /**
     * 使用预设配置抓取指定来源
     *
     * @param source 文章来源
     * @param maxArticles 最大文章数
     * @return 抓取结果
     */
    ScrapeResult scrapeFromSource(ArticleSource source, int maxArticles);
}
