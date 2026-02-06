package com.novacloudedu.backend.infrastructure.scraper;

import com.novacloudedu.backend.domain.scraper.entity.ScrapedArticle;
import com.novacloudedu.backend.domain.scraper.service.WebScraperService;
import com.novacloudedu.backend.domain.scraper.valueobject.ArticleSource;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeConfig;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeResult;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

/**
 * 基于 Jsoup 的网页抓取服务实现
 */
@Service
@Slf4j
public class JsoupWebScraperService implements WebScraperService {

    private static final int TIMEOUT_MS = 10000;
    private static final int MAX_QUEUE_SIZE = 100;
    private static final int MAX_VISITED_PAGES = 200;
    private static final long MAX_TOTAL_DURATION_MS = 300000; // 5分钟总超时
    private static final String USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36";

    @Override
    public ScrapedArticle scrapeSinglePage(String url, ScrapeConfig config) {
        try {
            Document doc = fetchDocument(url);
            return extractArticle(doc, url, config);
        } catch (Exception e) {
            log.error("抓取页面失败: {}, 错误: {}", url, e.getMessage());
            return null;
        }
    }

    @Override
    public List<String> scrapeArticleLinks(String listUrl, ScrapeConfig config) {
        try {
            Document doc = fetchDocument(listUrl);
            Elements links = doc.select(config.getLinkSelector());
            
            String baseUrl = getBaseUrl(listUrl);
            return links.stream()
                    .map(link -> link.absUrl("href"))
                    .filter(href -> !href.isBlank())
                    .filter(href -> isValidArticleUrl(href, baseUrl))
                    .distinct()
                    .limit(config.getMaxPages())
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("抓取文章链接失败: {}, 错误: {}", listUrl, e.getMessage());
            return Collections.emptyList();
        }
    }

    @Override
    public ScrapeResult scrapeMultiplePages(List<String> urls, ScrapeConfig config) {
        LocalDateTime startTime = LocalDateTime.now();
        long startMs = System.currentTimeMillis();
        
        List<ScrapedArticle> articles = new ArrayList<>();
        List<String> errors = new ArrayList<>();
        int successCount = 0;
        int failCount = 0;

        for (String url : urls) {
            try {
                ScrapedArticle article = scrapeSinglePage(url, config);
                if (article != null && article.isValid()) {
                    articles.add(article);
                    successCount++;
                } else {
                    failCount++;
                    errors.add("无效文章: " + url);
                }
                
                // 延迟避免被封
                if (config.getDelayMs() > 0) {
                    Thread.sleep(config.getDelayMs());
                }
            } catch (Exception e) {
                failCount++;
                errors.add("抓取失败 " + url + ": " + e.getMessage());
            }
        }

        return ScrapeResult.builder()
                .sourceUrl(urls.isEmpty() ? "" : urls.get(0))
                .articles(articles)
                .totalPages(urls.size())
                .successCount(successCount)
                .failCount(failCount)
                .errors(errors)
                .startTime(startTime)
                .endTime(LocalDateTime.now())
                .durationMs(System.currentTimeMillis() - startMs)
                .build();
    }

    @Override
    public ScrapeResult scrapeRecursively(String startUrl, ScrapeConfig config) {
        LocalDateTime startTime = LocalDateTime.now();
        long startMs = System.currentTimeMillis();
        
        Set<String> visited = ConcurrentHashMap.newKeySet();
        Set<String> normalizedVisited = ConcurrentHashMap.newKeySet(); // 规范化URL去重
        List<ScrapedArticle> articles = new ArrayList<>();
        List<String> errors = new ArrayList<>();
        // 使用优先队列，评分高的优先
        PriorityQueue<UrlWithDepth> queue = new PriorityQueue<>(
            Comparator.comparingInt(UrlWithDepth::priority).reversed()
        );
        
        queue.add(new UrlWithDepth(startUrl, 0, 0));
        String baseUrl = getBaseUrl(startUrl);
        
        int successCount = 0;
        int failCount = 0;
        int processedCount = 0;

        log.info("开始递归抓取: {}, 最大文章数: {}, 最大深度: {}", startUrl, config.getMaxPages(), config.getMaxDepth());

        while (!queue.isEmpty() && articles.size() < config.getMaxPages()) {
            // 检查总超时
            if (System.currentTimeMillis() - startMs > MAX_TOTAL_DURATION_MS) {
                log.warn("递归抓取超时，已处理 {} 个页面，获取 {} 篇文章", processedCount, articles.size());
                errors.add("抓取超时，已达到最大时间限制");
                break;
            }
            
            // 检查已访问页面数限制
            if (visited.size() >= MAX_VISITED_PAGES) {
                log.warn("已达到最大访问页面数限制: {}", MAX_VISITED_PAGES);
                errors.add("已达到最大访问页面数限制");
                break;
            }
            
            UrlWithDepth current = queue.poll();
            
            if (visited.contains(current.url()) || current.depth() > config.getMaxDepth()) {
                continue;
            }
            visited.add(current.url());
            processedCount++;

            try {
                log.info("抓取页面 [{}/{}]: {} (深度: {})", processedCount, config.getMaxPages(), current.url(), current.depth());
                Document doc = fetchDocument(current.url());
                
                // 先提取链接（列表页优先）
                if (current.depth() < config.getMaxDepth() && queue.size() < MAX_QUEUE_SIZE) {
                    Elements links = doc.select(config.getLinkSelector());
                    int addedLinks = 0;
                    for (Element link : links) {
                        if (queue.size() >= MAX_QUEUE_SIZE) {
                            break;
                        }
                        String href = link.absUrl("href");
                        String normalizedHref = normalizeUrl(href);
                        if (!href.isBlank() && !visited.contains(href) 
                            && !normalizedVisited.contains(normalizedHref)
                            && isValidArticleUrl(href, baseUrl)) {
                            int priority = calculateUrlPriority(href);
                            queue.add(new UrlWithDepth(href, current.depth() + 1, priority));
                            normalizedVisited.add(normalizedHref);
                            addedLinks++;
                        }
                    }
                    if (addedLinks > 0) {
                        log.info("从页面发现 {} 个新链接，队列大小: {}", addedLinks, queue.size());
                    }
                }
                
                // 尝试提取文章（深度 > 0 的页面更可能是文章详情页）
                ScrapedArticle article = extractArticle(doc, current.url(), config);
                if (article != null && article.isValid()) {
                    articles.add(article);
                    successCount++;
                    log.info("成功提取文章: {} (URL: {})", article.getTitle(), current.url());
                } else if (current.depth() > 0) {
                    // 只有非起始页才记录失败
                    log.debug("页面不是有效文章: {} (标题: {}, 内容长度: {})", 
                            current.url(), 
                            article != null ? article.getTitle() : "null",
                            article != null && article.getContent() != null ? article.getContent().length() : 0);
                }
                
                // 延迟
                if (config.getDelayMs() > 0) {
                    Thread.sleep(config.getDelayMs());
                }
            } catch (Exception e) {
                failCount++;
                errors.add("抓取失败 " + current.url() + ": " + e.getMessage());
                log.warn("抓取页面失败: {}, 错误: {}", current.url(), e.getMessage());
            }
        }

        log.info("递归抓取完成: 处理 {} 个页面，成功 {} 篇文章，失败 {} 个，耗时 {}ms", 
                processedCount, successCount, failCount, System.currentTimeMillis() - startMs);

        return ScrapeResult.builder()
                .sourceUrl(startUrl)
                .articles(articles)
                .totalPages(visited.size())
                .successCount(successCount)
                .failCount(failCount)
                .errors(errors)
                .startTime(startTime)
                .endTime(LocalDateTime.now())
                .durationMs(System.currentTimeMillis() - startMs)
                .build();
    }

    @Override
    public ScrapeResult scrapeFromSource(ArticleSource source, int maxArticles) {
        ScrapeConfig baseConfig = ScrapeConfig.forSource(source);
        ScrapeConfig config = ScrapeConfig.builder()
                .titleSelector(baseConfig.getTitleSelector())
                .authorSelector(baseConfig.getAuthorSelector())
                .sourceSelector(baseConfig.getSourceSelector())
                .contentSelector(baseConfig.getContentSelector())
                .dateSelector(baseConfig.getDateSelector())
                .imageSelector(baseConfig.getImageSelector())
                .linkSelector(baseConfig.getLinkSelector())
                .maxPages(maxArticles)
                .maxDepth(baseConfig.getMaxDepth())
                .delayMs(baseConfig.getDelayMs())
                .build();
        
        String startUrl = source.getBaseUrl();
        return scrapeRecursively(startUrl, config);
    }

    /**
     * 获取网页文档
     */
    private Document fetchDocument(String url) throws Exception {
        return Jsoup.connect(url)
                .userAgent(USER_AGENT)
                .timeout(TIMEOUT_MS)
                .followRedirects(true)
                .ignoreHttpErrors(true)
                .get();
    }

    /**
     * 从文档中提取文章
     */
    private ScrapedArticle extractArticle(Document doc, String url, ScrapeConfig config) {
        try {
            String title = extractText(doc, config.getTitleSelector());
            String author = extractText(doc, config.getAuthorSelector());
            String source = extractText(doc, config.getSourceSelector());
            String content = extractContent(doc, config.getContentSelector());
            String dateStr = extractText(doc, config.getDateSelector());
            List<String> images = extractImages(doc, config.getImageSelector());
            String coverImage = images.isEmpty() ? null : images.get(0);
            
            ArticleSource articleSource = ArticleSource.fromUrl(url);
            LocalDateTime publishTime = parseDateString(dateStr);

            return ScrapedArticle.create(
                    title, author, source, content, url,
                    coverImage, images, articleSource, publishTime
            );
        } catch (Exception e) {
            log.warn("提取文章失败: {}, 错误: {}", url, e.getMessage());
            return null;
        }
    }

    /**
     * 提取文本内容
     */
    private String extractText(Document doc, String selector) {
        Element element = doc.selectFirst(selector);
        return element != null ? element.text().trim() : "";
    }

    /**
     * 提取正文内容
     */
    private String extractContent(Document doc, String selector) {
        Element element = doc.selectFirst(selector);
        if (element == null) {
            return "";
        }
        
        // 移除脚本和样式
        element.select("script, style, nav, header, footer, aside, .ad, .advertisement").remove();
        
        // 获取纯文本
        return element.text().trim();
    }

    /**
     * 提取图片链接
     */
    private List<String> extractImages(Document doc, String selector) {
        Elements images = doc.select(selector);
        return images.stream()
                .map(img -> img.absUrl("src"))
                .filter(src -> !src.isBlank())
                .distinct()
                .collect(Collectors.toList());
    }

    /**
     * 解析日期字符串
     */
    private LocalDateTime parseDateString(String dateStr) {
        // 简单处理，实际可以使用更复杂的日期解析
        if (dateStr == null || dateStr.isBlank()) {
            return null;
        }
        try {
            // 尝试多种格式解析
            return LocalDateTime.now(); // 简化处理
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 获取基础URL
     */
    private String getBaseUrl(String url) {
        try {
            URI uri = new URI(url);
            return uri.getScheme() + "://" + uri.getHost();
        } catch (Exception e) {
            return url;
        }
    }

    /**
     * 获取根域名（如 people.com.cn）
     */
    private String getRootDomain(String url) {
        try {
            URI uri = new URI(url);
            String host = uri.getHost();
            if (host == null) {
                return null;
            }
            // 处理子域名：www.people.com.cn -> people.com.cn
            // politics.people.com.cn -> people.com.cn
            String[] parts = host.split("\\.");
            if (parts.length >= 2) {
                // 取最后两部分或三部分（处理 .com.cn, .co.uk 等）
                if (parts.length >= 3 && (parts[parts.length - 2].equals("com") || 
                    parts[parts.length - 2].equals("co") || 
                    parts[parts.length - 2].equals("org") ||
                    parts[parts.length - 2].equals("net"))) {
                    // 如 people.com.cn -> people.com.cn
                    return parts[parts.length - 3] + "." + parts[parts.length - 2] + "." + parts[parts.length - 1];
                } else {
                    // 如 example.com -> example.com
                    return parts[parts.length - 2] + "." + parts[parts.length - 1];
                }
            }
            return host;
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 检查是否为有效的文章URL
     */
    private boolean isValidArticleUrl(String url, String baseUrl) {
        if (url == null || url.isBlank()) {
            return false;
        }
        // 排除非文章链接
        String lowerUrl = url.toLowerCase();
        if (lowerUrl.contains("javascript:") || 
            lowerUrl.contains("mailto:") ||
            lowerUrl.contains("#") ||
            lowerUrl.endsWith(".pdf") ||
            lowerUrl.endsWith(".jpg") ||
            lowerUrl.endsWith(".png") ||
            lowerUrl.endsWith(".gif")) {
            return false;
        }
        
        // 优先抓取文章页（.html/.htm/.shtml 后缀，或包含文章路径特征）
        // 去掉查询参数后检查
        String urlPath = lowerUrl.split("\\?")[0];
        boolean isArticlePage = urlPath.endsWith(".html") || 
                                urlPath.endsWith(".htm") || 
                                urlPath.endsWith(".shtml") ||
                                urlPath.matches(".*/(\\d+|article|news|detail)/.*");
        
        // 如果不是文章页，跳过（减少无效链接）
        if (!isArticlePage) {
            return false;
        }
        
        // 相对路径直接有效
        if (url.startsWith("/")) {
            return true;
        }
        
        // 同域名或同根域名（支持子域名）
        if (url.startsWith(baseUrl)) {
            return true;
        }
        
        // 检查是否为同根域名（如 politics.people.com.cn 和 www.people.com.cn）
        String baseRootDomain = getRootDomain(baseUrl);
        String urlRootDomain = getRootDomain(url);
        return baseRootDomain != null && baseRootDomain.equals(urlRootDomain);
    }

    /**
     * 计算URL优先级评分（分数越高越优先）
     */
    private int calculateUrlPriority(String url) {
        int score = 0;
        String lowerUrl = url.toLowerCase();
        
        // 1. URL长度加分（长URL通常是具体文章）
        score += Math.min(url.length(), 150); // 最多150分
        
        // 2. 包含日期格式加分（如 /2026/0205/ 或 /20260205/）
        if (lowerUrl.matches(".*/(\\d{4})/(\\d{2})/(\\d{2})/.*") ||
            lowerUrl.matches(".*/(\\d{4})(\\d{2})(\\d{2})/.*") ||
            lowerUrl.matches(".*/(\\d{4})/(\\d{4})/.*")) {
            score += 50;
        }
        
        // 3. 包含文章ID特征加分（如 c1001-40660335）
        if (lowerUrl.matches(".*[a-z]\\d+-\\d+.*")) {
            score += 40;
        }
        
        // 4. .html/.shtml 后缀加分
        if (lowerUrl.endsWith(".html") || lowerUrl.endsWith(".shtml")) {
            score += 30;
        }
        
        // 5. 包含 /n1/ /n2/ 等新闻路径加分（人民网特征）
        if (lowerUrl.matches(".*/n\\d+/.*")) {
            score += 20;
        }
        
        // 6. 包含 article/news/detail 关键词加分
        if (lowerUrl.contains("/article/") || 
            lowerUrl.contains("/news/") || 
            lowerUrl.contains("/detail/")) {
            score += 25;
        }
        
        // 7. 减分项：首页/列表页特征
        if (lowerUrl.endsWith("/") || lowerUrl.matches(".*/index\\.(html|shtml|htm)")) {
            score -= 50;
        }
        
        return score;
    }

    /**
     * 规范化URL（用于去重）
     */
    private String normalizeUrl(String url) {
        if (url == null) return "";
        // 移除协议差异
        String normalized = url.replaceFirst("^https?://", "");
        // 移除www前缀
        normalized = normalized.replaceFirst("^www\\.", "");
        // 移除尾部斜杠
        normalized = normalized.replaceFirst("/$", "");
        // 移除查询参数（可选，某些站点查询参数有意义）
        normalized = normalized.split("\\?")[0];
        // 移除锚点
        normalized = normalized.split("#")[0];
        return normalized.toLowerCase();
    }

    /**
     * URL与深度的包装类（带优先级）
     */
    private record UrlWithDepth(String url, int depth, int priority) {}
}
