package com.novacloudedu.backend.infrastructure.scraper;

import com.novacloudedu.backend.domain.scraper.entity.ScrapedArticle;
import com.novacloudedu.backend.domain.scraper.valueobject.ArticleSource;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeConfig;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeResult;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

/**
 * 基于 Selenium 的动态网页抓取服务
 * 支持 JavaScript 渲染的 SPA 页面
 */
@Service
@Slf4j
public class SeleniumWebScraperService {

    private static final int DEFAULT_TIMEOUT_SECONDS = 30;
    private static final int DEFAULT_WAIT_FOR_JS_MS = 3000;
    private static final int MAX_QUEUE_SIZE = 50;
    private static final int MAX_VISITED_PAGES = 100;
    private static final long MAX_TOTAL_DURATION_MS = 600000; // 10分钟总超时（动态抓取更慢）

    // Selenium 4.6+ 内置 Selenium Manager，自动管理 ChromeDriver，无需手动配置

    /**
     * 创建无头浏览器实例
     */
    private WebDriver createHeadlessDriver() {
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless=new");
        options.addArguments("--disable-gpu");
        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");
        options.addArguments("--window-size=1920,1080");
        options.addArguments("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
        options.addArguments("--disable-blink-features=AutomationControlled");
        options.setExperimentalOption("excludeSwitches", Collections.singletonList("enable-automation"));
        
        return new ChromeDriver(options);
    }

    /**
     * 抓取动态页面内容
     */
    public ScrapedArticle scrapeDynamicPage(String url, ScrapeConfig config) {
        return scrapeDynamicPage(url, config, DEFAULT_WAIT_FOR_JS_MS);
    }

    /**
     * 抓取动态页面内容（自定义等待时间）
     */
    public ScrapedArticle scrapeDynamicPage(String url, ScrapeConfig config, int waitForJsMs) {
        WebDriver driver = null;
        try {
            driver = createHeadlessDriver();
            driver.get(url);
            
            // 等待 JavaScript 执行
            Thread.sleep(waitForJsMs);
            
            // 滚动页面以触发懒加载
            scrollPage(driver);
            
            // 获取渲染后的 HTML
            String pageSource = driver.getPageSource();
            Document doc = Jsoup.parse(pageSource, url);
            
            return extractArticle(doc, url, config);
        } catch (Exception e) {
            log.error("动态抓取页面失败: {}, 错误: {}", url, e.getMessage());
            return null;
        } finally {
            if (driver != null) {
                driver.quit();
            }
        }
    }

    /**
     * 抓取动态页面中的文章链接
     */
    public List<String> scrapeDynamicArticleLinks(String listUrl, ScrapeConfig config, int waitForJsMs) {
        WebDriver driver = null;
        try {
            driver = createHeadlessDriver();
            driver.get(listUrl);
            
            // 等待 JavaScript 执行
            Thread.sleep(waitForJsMs);
            
            // 滚动页面
            scrollPage(driver);
            
            String pageSource = driver.getPageSource();
            Document doc = Jsoup.parse(pageSource, listUrl);
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
            log.error("动态抓取文章链接失败: {}, 错误: {}", listUrl, e.getMessage());
            return Collections.emptyList();
        } finally {
            if (driver != null) {
                driver.quit();
            }
        }
    }

    /**
     * 批量动态抓取多个页面
     */
    public ScrapeResult scrapeDynamicMultiplePages(List<String> urls, ScrapeConfig config, int waitForJsMs) {
        LocalDateTime startTime = LocalDateTime.now();
        long startMs = System.currentTimeMillis();
        
        List<ScrapedArticle> articles = new ArrayList<>();
        List<String> errors = new ArrayList<>();
        int successCount = 0;
        int failCount = 0;

        for (String url : urls) {
            try {
                ScrapedArticle article = scrapeDynamicPage(url, config, waitForJsMs);
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
                errors.add("动态抓取失败 " + url + ": " + e.getMessage());
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

    /**
     * 递归动态抓取网站
     */
    public ScrapeResult scrapeDynamicRecursively(String startUrl, ScrapeConfig config, int waitForJsMs) {
        LocalDateTime startTime = LocalDateTime.now();
        long startMs = System.currentTimeMillis();
        
        Set<String> visited = ConcurrentHashMap.newKeySet();
        List<ScrapedArticle> articles = new ArrayList<>();
        List<String> errors = new ArrayList<>();
        Queue<UrlWithDepth> queue = new LinkedList<>();
        
        queue.add(new UrlWithDepth(startUrl, 0));
        String baseUrl = getBaseUrl(startUrl);
        
        int successCount = 0;
        int failCount = 0;
        int processedCount = 0;

        log.info("开始动态递归抓取: {}, 最大文章数: {}, 最大深度: {}", startUrl, config.getMaxPages(), config.getMaxDepth());

        while (!queue.isEmpty() && articles.size() < config.getMaxPages()) {
            // 检查总超时
            if (System.currentTimeMillis() - startMs > MAX_TOTAL_DURATION_MS) {
                log.warn("动态递归抓取超时，已处理 {} 个页面，获取 {} 篇文章", processedCount, articles.size());
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

            WebDriver driver = null;
            try {
                log.debug("动态抓取页面 [{}/{}]: {} (深度: {})", processedCount, config.getMaxPages(), current.url(), current.depth());
                driver = createHeadlessDriver();
                driver.get(current.url());
                
                Thread.sleep(waitForJsMs);
                scrollPage(driver);
                
                String pageSource = driver.getPageSource();
                Document doc = Jsoup.parse(pageSource, current.url());
                
                // 尝试提取文章
                ScrapedArticle article = extractArticle(doc, current.url(), config);
                if (article != null && article.isValid()) {
                    articles.add(article);
                    successCount++;
                    log.info("成功提取文章: {} (URL: {}, 内容长度: {})", 
                            article.getTitle(), current.url(), 
                            article.getContent() != null ? article.getContent().length() : 0);
                } else if (current.depth() > 0) {
                    // 只有非起始页才记录失败
                    log.debug("页面不是有效文章: {} (标题: {}, 内容长度: {})", 
                            current.url(), 
                            article != null ? article.getTitle() : "null",
                            article != null && article.getContent() != null ? article.getContent().length() : 0);
                }
                
                // 如果未达到最大深度且队列未满，继续抓取链接
                if (current.depth() < config.getMaxDepth() && queue.size() < MAX_QUEUE_SIZE) {
                    Elements links = doc.select(config.getLinkSelector());
                    int addedLinks = 0;
                    for (Element link : links) {
                        if (queue.size() >= MAX_QUEUE_SIZE) {
                            break;
                        }
                        String href = link.absUrl("href");
                        if (!href.isBlank() && !visited.contains(href) && isValidArticleUrl(href, baseUrl)) {
                            queue.add(new UrlWithDepth(href, current.depth() + 1));
                            addedLinks++;
                        }
                    }
                    log.debug("从页面发现 {} 个新链接，队列大小: {}", addedLinks, queue.size());
                }
                
                // 延迟
                if (config.getDelayMs() > 0) {
                    Thread.sleep(config.getDelayMs());
                }
            } catch (Exception e) {
                failCount++;
                errors.add("动态抓取失败 " + current.url() + ": " + e.getMessage());
                log.warn("动态抓取页面失败: {}, 错误: {}", current.url(), e.getMessage());
            } finally {
                if (driver != null) {
                    try {
                        driver.quit();
                    } catch (Exception e) {
                        log.warn("关闭 WebDriver 失败: {}", e.getMessage());
                    }
                }
            }
        }

        log.info("动态递归抓取完成: 处理 {} 个页面，成功 {} 篇文章，失败 {} 个，耗时 {}ms", 
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

    /**
     * 等待页面特定元素加载
     */
    public ScrapedArticle scrapeDynamicPageWithSelector(String url, ScrapeConfig config, 
                                                         String waitForSelector, int timeoutSeconds) {
        WebDriver driver = null;
        try {
            driver = createHeadlessDriver();
            driver.get(url);
            
            // 等待特定元素出现
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(timeoutSeconds));
            wait.until(d -> {
                try {
                    Document doc = Jsoup.parse(d.getPageSource());
                    return !doc.select(waitForSelector).isEmpty();
                } catch (Exception e) {
                    return false;
                }
            });
            
            // 滚动页面
            scrollPage(driver);
            
            String pageSource = driver.getPageSource();
            Document doc = Jsoup.parse(pageSource, url);
            
            return extractArticle(doc, url, config);
        } catch (Exception e) {
            log.error("动态抓取页面失败（等待选择器）: {}, 错误: {}", url, e.getMessage());
            return null;
        } finally {
            if (driver != null) {
                driver.quit();
            }
        }
    }

    /**
     * 滚动页面以触发懒加载
     */
    private void scrollPage(WebDriver driver) {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            
            // 滚动到页面底部
            long lastHeight = (Long) js.executeScript("return document.body.scrollHeight");
            
            for (int i = 0; i < 3; i++) {
                js.executeScript("window.scrollTo(0, document.body.scrollHeight);");
                Thread.sleep(500);
                
                long newHeight = (Long) js.executeScript("return document.body.scrollHeight");
                if (newHeight == lastHeight) {
                    break;
                }
                lastHeight = newHeight;
            }
            
            // 滚动回顶部
            js.executeScript("window.scrollTo(0, 0);");
            Thread.sleep(300);
        } catch (Exception e) {
            log.warn("滚动页面时出错: {}", e.getMessage());
        }
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

    private String extractText(Document doc, String selector) {
        Element element = doc.selectFirst(selector);
        if (element != null) {
            return element.text().trim();
        }
        // 尝试通配符类选择器
        return tryWildcardSelectors(doc, selector, false);
    }

    private String extractContent(Document doc, String selector) {
        Element element = doc.selectFirst(selector);
        
        // 如果默认选择器没匹配到，尝试 SPA 选择器（优先）
        if (element == null || element.text().trim().length() < 50) {
            Element spaElement = tryCommonContentSelectors(doc);
            if (spaElement != null) {
                element = spaElement;
                log.debug("使用 SPA 选择器提取内容");
            }
        }
        
        // 如果还是没有，尝试通配符选择器
        if (element == null || element.text().trim().length() < 50) {
            String wildcardContent = tryWildcardSelectors(doc, selector, true);
            if (!wildcardContent.isBlank()) {
                return wildcardContent;
            }
        }
        
        if (element == null) {
            return "";
        }
        
        element.select("script, style, nav, header, footer, aside, .ad, .advertisement, .share, .comment").remove();
        
        // 优先提取 <p> 标签内容（更精准）
        String pContent = extractParagraphs(element);
        if (pContent.length() > 50) {
            log.debug("提取 <p> 标签内容，长度: {}", pContent.length());
            return pContent;
        }
        
        return element.text().trim();
    }
    
    /**
     * 从元素中提取所有 <p> 标签的文字内容
     */
    private String extractParagraphs(Element element) {
        Elements paragraphs = element.select("p");
        if (paragraphs.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (Element p : paragraphs) {
            String text = p.text().trim();
            if (!text.isBlank() && text.length() > 10) { // 过滤太短的段落
                sb.append(text).append("\n");
            }
        }
        return sb.toString().trim();
    }
    
    /**
     * 尝试通配符类选择器匹配
     */
    private String tryWildcardSelectors(Document doc, String selector, boolean isContent) {
        // 从选择器中提取关键词，生成通配符选择器
        String[] keywords = isContent 
            ? new String[]{"content", "article", "text", "body", "detail", "main", "post"}
            : new String[]{"title", "headline", "name", "author", "date", "time", "source"};
        
        for (String keyword : keywords) {
            // 尝试 class 包含关键词
            Element el = doc.selectFirst("[class*='" + keyword + "']");
            if (el != null) {
                String text = el.text().trim();
                // 内容需要足够长，标题等短文本不需要
                if (isContent && text.length() > 100) {
                    el.select("script, style, nav, header, footer, aside").remove();
                    return el.text().trim();
                } else if (!isContent && !text.isBlank() && text.length() < 200) {
                    return text;
                }
            }
            // 尝试 id 包含关键词
            el = doc.selectFirst("[id*='" + keyword + "']");
            if (el != null) {
                String text = el.text().trim();
                if (isContent && text.length() > 100) {
                    el.select("script, style, nav, header, footer, aside").remove();
                    return el.text().trim();
                } else if (!isContent && !text.isBlank() && text.length() < 200) {
                    return text;
                }
            }
        }
        return "";
    }
    
    /**
     * 尝试常见的 SPA 内容选择器（凤凰网、网易、腾讯等）
     */
    private Element tryCommonContentSelectors(Document doc) {
        String[] spaSelectors = {
            // 凤凰网（CSS Modules 带哈希后缀）
            "[class*='index_text']", "[class*='article_text']", "[class*='main_text']",
            "[class*='news_text']", "[class*='detail_text']", "[class*='text_']",
            // 通用 SPA
            "[class*='richText']", "[class*='rich-text']", "[class*='RichText']",
            "[class*='articleBody']", "[class*='article-body']",
            "[class*='newsBody']", "[class*='news-body']",
            "[class*='postContent']", "[class*='post-content']",
            // React/Vue 常见命名
            "[class*='Content_']", "[class*='Article_']", "[class*='Text_']",
            "[class*='content_']", "[class*='article_']",
            // data 属性
            "[data-article-content]", "[data-content]", "[data-text]",
            // 语义标签
            "article", "main", "[role='main']", "[role='article']"
        };
        
        for (String sel : spaSelectors) {
            Element el = doc.selectFirst(sel);
            if (el != null) {
                // 尝试提取 <p> 标签内容
                String pContent = extractParagraphs(el);
                if (pContent.length() > 50) {
                    log.debug("SPA选择器匹配成功: {}, 内容长度: {}", sel, pContent.length());
                    return el;
                }
                // 回退到整体文本
                if (el.text().trim().length() > 100) {
                    log.debug("SPA选择器匹配成功(整体): {}, 内容长度: {}", sel, el.text().trim().length());
                    return el;
                }
            }
        }
        return null;
    }

    private List<String> extractImages(Document doc, String selector) {
        Elements images = doc.select(selector);
        return images.stream()
                .map(img -> img.absUrl("src"))
                .filter(src -> !src.isBlank())
                .distinct()
                .collect(Collectors.toList());
    }

    private LocalDateTime parseDateString(String dateStr) {
        if (dateStr == null || dateStr.isBlank()) {
            return null;
        }
        return LocalDateTime.now();
    }

    private String getBaseUrl(String url) {
        try {
            URI uri = new URI(url);
            return uri.getScheme() + "://" + uri.getHost();
        } catch (Exception e) {
            return url;
        }
    }

    /**
     * 获取根域名（如 ifeng.com）
     */
    private String getRootDomain(String url) {
        try {
            URI uri = new URI(url);
            String host = uri.getHost();
            if (host == null) {
                return null;
            }
            String[] parts = host.split("\\.");
            if (parts.length >= 2) {
                if (parts.length >= 3 && (parts[parts.length - 2].equals("com") || 
                    parts[parts.length - 2].equals("co") || 
                    parts[parts.length - 2].equals("org") ||
                    parts[parts.length - 2].equals("net"))) {
                    return parts[parts.length - 3] + "." + parts[parts.length - 2] + "." + parts[parts.length - 1];
                } else {
                    return parts[parts.length - 2] + "." + parts[parts.length - 1];
                }
            }
            return host;
        } catch (Exception e) {
            return null;
        }
    }

    private boolean isValidArticleUrl(String url, String baseUrl) {
        if (url == null || url.isBlank()) {
            return false;
        }
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
        
        // 判断是否为 SPA 网站（凤凰网等）
        String urlPath = lowerUrl.split("\\?")[0];
        boolean isSpaUrl = urlPath.matches(".*/c/[0-9a-zA-Z]+$") ||  // 凤凰网 SPA 格式: /c/8Wxxxx
                           urlPath.matches(".*/[a-z]/[0-9a-zA-Z_-]{6,}$"); // 通用 SPA 路由（至少6位ID）
        
        // SPA 网站：只抓取 SPA 路由，排除 .html/.shtml 静态页面
        if (isSpaUrl) {
            return true;
        }
        
        // 排除 SPA 网站的静态页面（如 index.shtml, ask.html 等）
        boolean isStaticPage = urlPath.endsWith(".html") || urlPath.endsWith(".htm") || urlPath.endsWith(".shtml");
        if (isStaticPage && lowerUrl.contains("ifeng.com")) {
            return false; // 凤凰网的静态页面不是文章
        }
        
        // 传统网站：抓取 .html 等文章页
        boolean isArticlePage = isStaticPage ||
                                urlPath.matches(".*/(\\d+|article|news|detail|c_\\d+)/.*") ||
                                urlPath.matches(".*/[a-z]\\d+-\\d+.*"); // 人民网格式
        
        // 如果不是文章页，跳过
        if (!isArticlePage) {
            return false;
        }
        
        // 相对路径直接有效
        if (url.startsWith("/")) {
            return true;
        }
        
        // 同域名
        if (url.startsWith(baseUrl)) {
            return true;
        }
        
        // 同根域名（支持子域名，如 news.ifeng.com）
        String baseRootDomain = getRootDomain(baseUrl);
        String urlRootDomain = getRootDomain(url);
        return baseRootDomain != null && baseRootDomain.equals(urlRootDomain);
    }

    private record UrlWithDepth(String url, int depth) {}
}
