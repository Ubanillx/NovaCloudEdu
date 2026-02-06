package com.novacloudedu.backend.application.scraper.service;

import com.novacloudedu.backend.application.scraper.command.ScraperConfigCommand;
import com.novacloudedu.backend.application.dailylearning.service.ArticleAiApplicationService;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.scraper.entity.ScrapedArticle;
import com.novacloudedu.backend.domain.scraper.entity.ScraperSourceConfig;
import com.novacloudedu.backend.domain.scraper.entity.ScraperTask;
import com.novacloudedu.backend.domain.scraper.repository.ScraperSourceConfigRepository;
import com.novacloudedu.backend.domain.scraper.repository.ScraperTaskRepository;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperConfigId;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperTaskId;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeConfig;
import com.novacloudedu.backend.domain.scraper.valueobject.ScrapeResult;
import com.novacloudedu.backend.domain.scraper.service.WebScraperService;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.scraper.SeleniumWebScraperService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * 抓取配置管理应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ScraperConfigApplicationService {

    private final ScraperSourceConfigRepository configRepository;
    private final ScraperTaskRepository taskRepository;
    private final DailyArticleRepository dailyArticleRepository;
    private final WebScraperService webScraperService;
    private final SeleniumWebScraperService seleniumWebScraperService;
    private final ArticleAiApplicationService articleAiApplicationService;

    /**
     * 创建抓取配置
     */
    @Transactional
    public ScraperSourceConfig createConfig(ScraperConfigCommand command, Long creatorId) {
        log.info("创建抓取配置: {}", command.name());
        
        // 检查 sourceCode 是否已存在
        if (configRepository.findBySourceCode(command.sourceCode()).isPresent()) {
            throw new IllegalArgumentException("来源代码已存在: " + command.sourceCode());
        }
        
        ScraperSourceConfig config = ScraperSourceConfig.create(
                command.name(),
                command.sourceCode(),
                command.baseUrl(),
                command.description(),
                command.titleSelector(),
                command.authorSelector(),
                command.sourceSelector(),
                command.contentSelector(),
                command.dateSelector(),
                command.imageSelector(),
                command.linkSelector(),
                command.maxDepth(),
                command.maxPages(),
                command.delayMs(),
                command.useDynamic(),
                command.waitForJsMs(),
                command.cronExpression(),
                command.enabled(),
                command.defaultMaxArticles(),
                command.defaultCategory(),
                command.defaultDifficulty(),
                UserId.of(creatorId)
        );
        
        return configRepository.save(config);
    }

    /**
     * 更新抓取配置
     */
    @Transactional
    public ScraperSourceConfig updateConfig(ScraperConfigCommand command) {
        log.info("更新抓取配置: {}", command.id());
        
        ScraperSourceConfig config = configRepository.findById(ScraperConfigId.of(command.id()))
                .orElseThrow(() -> new IllegalArgumentException("配置不存在: " + command.id()));
        
        config.updateConfig(
                command.name(),
                command.baseUrl(),
                command.description(),
                command.titleSelector(),
                command.authorSelector(),
                command.sourceSelector(),
                command.contentSelector(),
                command.dateSelector(),
                command.imageSelector(),
                command.linkSelector(),
                command.maxDepth(),
                command.maxPages(),
                command.delayMs(),
                command.useDynamic(),
                command.waitForJsMs(),
                command.cronExpression(),
                command.enabled(),
                command.defaultMaxArticles(),
                command.defaultCategory(),
                command.defaultDifficulty()
        );
        
        return configRepository.save(config);
    }

    /**
     * 获取配置详情
     */
    public Optional<ScraperSourceConfig> getConfig(Long configId) {
        return configRepository.findById(ScraperConfigId.of(configId));
    }

    /**
     * 获取所有配置
     */
    public List<ScraperSourceConfig> getAllConfigs() {
        return configRepository.findAll();
    }

    /**
     * 获取所有启用的配置
     */
    public List<ScraperSourceConfig> getEnabledConfigs() {
        return configRepository.findAllEnabled();
    }

    /**
     * 分页获取配置
     */
    public List<ScraperSourceConfig> getConfigsByPage(int page, int size) {
        return configRepository.findByPage(page, size);
    }

    /**
     * 分页获取配置（带完整分页信息）
     */
    public ScraperSourceConfigRepository.ConfigPage getConfigsByPageWithTotal(int page, int size) {
        return configRepository.findByPageWithTotal(page, size);
    }

    /**
     * 启用配置
     */
    @Transactional
    public void enableConfig(Long configId) {
        ScraperSourceConfig config = configRepository.findById(ScraperConfigId.of(configId))
                .orElseThrow(() -> new IllegalArgumentException("配置不存在: " + configId));
        config.enable();
        configRepository.save(config);
    }

    /**
     * 禁用配置
     */
    @Transactional
    public void disableConfig(Long configId) {
        ScraperSourceConfig config = configRepository.findById(ScraperConfigId.of(configId))
                .orElseThrow(() -> new IllegalArgumentException("配置不存在: " + configId));
        config.disable();
        configRepository.save(config);
    }

    /**
     * 删除配置
     */
    @Transactional
    public void deleteConfig(Long configId) {
        configRepository.deleteById(ScraperConfigId.of(configId));
    }

    /**
     * 手动执行抓取任务
     */
    @Transactional
    public ScraperTask executeScraperTask(Long configId, Integer maxArticles, Long adminId) {
        log.info("手动执行抓取任务, 配置ID: {}, 最大文章数: {}", configId, maxArticles);
        
        ScraperSourceConfig config = configRepository.findById(ScraperConfigId.of(configId))
                .orElseThrow(() -> new IllegalArgumentException("配置不存在: " + configId));
        
        return executeTask(config, maxArticles != null ? maxArticles : config.getDefaultMaxArticles(), adminId);
    }

    /**
     * 执行抓取任务（内部方法）
     * 注意：不使用 @Transactional，因为抓取过程很长，需要分段提交状态
     */
    public ScraperTask executeTask(ScraperSourceConfig config, int maxArticles, Long adminId) {
        // 创建并启动任务（独立事务，立即提交）
        ScraperTask task = createAndStartTask(config);
        
        try {
            // 构建抓取配置
            ScrapeConfig scrapeConfig = buildScrapeConfig(config, maxArticles);
            
            // 执行抓取（不在事务中）
            ScrapeResult result;
            if (config.isDynamic()) {
                result = seleniumWebScraperService.scrapeDynamicRecursively(
                        config.getBaseUrl(), scrapeConfig, config.getWaitForJsMs());
            } else {
                result = webScraperService.scrapeRecursively(config.getBaseUrl(), scrapeConfig);
            }
            
            // 保存文章并完成任务（独立事务）
            completeTaskWithArticles(task, result, config, adminId);
            log.info("抓取任务完成, 配置: {}, 成功创建 {} 篇文章", config.getName(), task.getSuccessCount());
            
        } catch (Exception e) {
            String errorMessage = buildErrorMessage(e);
            log.error("抓取任务失败, 配置: {}, 错误: {}", config.getName(), errorMessage, e);
            failTask(task, errorMessage);
        }
        
        return task;
    }
    
    /**
     * 创建并启动任务（独立事务，立即提交）
     */
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public ScraperTask createAndStartTask(ScraperSourceConfig config) {
        ScraperTask task = ScraperTask.create(config.getId(), config.getName());
        task = taskRepository.save(task);
        task.start();
        return taskRepository.save(task);
    }
    
    /**
     * 保存文章并完成任务（独立事务）
     */
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void completeTaskWithArticles(ScraperTask task, ScrapeResult result, 
                                          ScraperSourceConfig config, Long adminId) {
        List<Long> createdArticleIds = new ArrayList<>();
        List<String> errors = new ArrayList<>();
        
        for (ScrapedArticle scrapedArticle : result.getArticles()) {
            try {
                DailyArticle dailyArticle = convertToDailyArticle(scrapedArticle, config, adminId);
                dailyArticle = dailyArticleRepository.save(dailyArticle);
                createdArticleIds.add(dailyArticle.getId().value());
            } catch (Exception e) {
                String errorMsg = String.format("保存文章[%s]失败: %s", 
                        scrapedArticle.getTitle(), e.getMessage());
                log.warn(errorMsg);
                errors.add(errorMsg);
            }
        }
        
        // 完成任务
        int totalArticles = result.getArticles().size();
        int failCount = totalArticles - createdArticleIds.size();
        task.complete(totalArticles, createdArticleIds.size(), failCount, createdArticleIds);
        
        if (!errors.isEmpty()) {
            String errorSummary = String.join("; ", errors);
            if (errorSummary.length() > 2000) {
                errorSummary = errorSummary.substring(0, 2000) + "...";
            }
            task.setPartialErrors(errorSummary);
        }
        
        taskRepository.save(task);
        
        // 异步触发 AI 处理（格式化内容和生成摘要）
        if (!createdArticleIds.isEmpty()) {
            triggerAiProcessAsync(createdArticleIds);
        }
    }
    
    /**
     * 异步触发 AI 处理文章
     */
    private void triggerAiProcessAsync(List<Long> articleIds) {
        // 使用新线程异步处理，避免阻塞抓取流程
        new Thread(() -> {
            log.info("开始异步 AI 处理 {} 篇文章", articleIds.size());
            try {
                int successCount = articleAiApplicationService.batchProcessArticles(
                        articleIds, true, true);
                log.info("AI 处理完成: 成功 {}/{} 篇", successCount, articleIds.size());
            } catch (Exception e) {
                log.error("AI 处理文章失败", e);
            }
        }).start();
    }
    
    /**
     * 标记任务失败（独立事务）
     */
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void failTask(ScraperTask task, String errorMessage) {
        task.fail(errorMessage);
        taskRepository.save(task);
    }
    
    /**
     * 构建错误消息（包含异常类型和详细信息）
     */
    private String buildErrorMessage(Exception e) {
        StringBuilder sb = new StringBuilder();
        sb.append("[").append(e.getClass().getSimpleName()).append("] ");
        
        String message = e.getMessage();
        if (message == null || message.isBlank()) {
            message = "未知错误";
        }
        sb.append(message);
        
        // 添加根因（如果有）
        Throwable cause = e.getCause();
        if (cause != null && cause != e) {
            sb.append(" <- [").append(cause.getClass().getSimpleName()).append("] ");
            String causeMsg = cause.getMessage();
            if (causeMsg != null && !causeMsg.isBlank()) {
                sb.append(causeMsg);
            }
        }
        
        // 限制长度
        String result = sb.toString();
        if (result.length() > 2000) {
            result = result.substring(0, 2000) + "...";
        }
        return result;
    }

    /**
     * 获取任务详情
     */
    public Optional<ScraperTask> getTask(Long taskId) {
        return taskRepository.findById(ScraperTaskId.of(taskId));
    }

    /**
     * 获取配置的任务列表
     */
    public List<ScraperTask> getTasksByConfig(Long configId, int page, int size) {
        return taskRepository.findByConfigId(ScraperConfigId.of(configId), page, size);
    }

    /**
     * 获取配置的任务列表（带完整分页信息）
     */
    public ScraperTaskRepository.TaskPage getTasksByConfigWithTotal(Long configId, int page, int size) {
        return taskRepository.findByConfigIdWithTotal(ScraperConfigId.of(configId), page, size);
    }

    /**
     * 获取所有任务
     */
    public List<ScraperTask> getAllTasks(int page, int size) {
        return taskRepository.findAll(page, size);
    }

    /**
     * 获取所有任务（带完整分页信息）
     */
    public ScraperTaskRepository.TaskPage getAllTasksWithTotal(int page, int size) {
        return taskRepository.findAllWithTotal(page, size);
    }

    /**
     * 构建抓取配置
     */
    private ScrapeConfig buildScrapeConfig(ScraperSourceConfig config, int maxArticles) {
        ScrapeConfig.Builder builder = ScrapeConfig.builder();
        
        if (config.getTitleSelector() != null && !config.getTitleSelector().isBlank()) {
            builder.titleSelector(config.getTitleSelector());
        }
        if (config.getAuthorSelector() != null && !config.getAuthorSelector().isBlank()) {
            builder.authorSelector(config.getAuthorSelector());
        }
        if (config.getSourceSelector() != null && !config.getSourceSelector().isBlank()) {
            builder.sourceSelector(config.getSourceSelector());
        }
        if (config.getContentSelector() != null && !config.getContentSelector().isBlank()) {
            builder.contentSelector(config.getContentSelector());
        }
        if (config.getDateSelector() != null && !config.getDateSelector().isBlank()) {
            builder.dateSelector(config.getDateSelector());
        }
        if (config.getImageSelector() != null && !config.getImageSelector().isBlank()) {
            builder.imageSelector(config.getImageSelector());
        }
        if (config.getLinkSelector() != null && !config.getLinkSelector().isBlank()) {
            builder.linkSelector(config.getLinkSelector());
        }
        
        builder.maxDepth(config.getMaxDepth() != null ? config.getMaxDepth() : 2);
        builder.maxPages(maxArticles);
        builder.delayMs(config.getDelayMs() != null ? config.getDelayMs() : 1500L);
        
        return builder.build();
    }

    /**
     * 将抓取的文章转换为每日文章
     */
    private DailyArticle convertToDailyArticle(ScrapedArticle scrapedArticle, ScraperSourceConfig config, Long adminId) {
        // 处理摘要（数据库限制 512 字符）
        String summary = scrapedArticle.getSummary(200);
        if (summary == null || summary.isBlank()) {
            summary = scrapedArticle.getContent();
            if (summary != null && summary.length() > 500) {
                summary = summary.substring(0, 500) + "...";
            }
        }
        summary = truncate(summary, 500);
        
        // 估算阅读时间（假设每分钟阅读200字）
        int readTime = 1;
        if (scrapedArticle.getContent() != null) {
            readTime = Math.max(1, scrapedArticle.getContent().length() / 200);
        }
        
        Difficulty difficulty = Difficulty.fromCode(
                config.getDefaultDifficulty() != null ? config.getDefaultDifficulty() : 2);
        
        // 对各字段进行长度限制，防止数据库插入失败
        String title = truncate(scrapedArticle.getTitle(), 250);
        String coverImage = truncate(scrapedArticle.getCoverImage(), 1000);
        String author = truncate(scrapedArticle.getAuthor(), 120);
        String source = truncate(config.getName(), 250);
        String sourceUrl = truncate(scrapedArticle.getUrl(), 1000);
        String category = truncate(config.getDefaultCategory(), 60);
        
        // 处理图片列表（转为 JSON 后限制在 500 字符内）
        List<String> images = scrapedArticle.getImages();
        if (images != null && !images.isEmpty()) {
            // 只保留前几张图片，确保不超限
            List<String> limitedImages = new ArrayList<>();
            int totalLength = 2; // []
            for (String img : images) {
                int imgLength = img.length() + 3; // "img",
                if (totalLength + imgLength > 500) break;
                limitedImages.add(img);
                totalLength += imgLength;
            }
            images = limitedImages;
        }
        
        return DailyArticle.create(
                title,
                scrapedArticle.getContent(),
                summary,
                coverImage,
                author,
                source,
                sourceUrl,
                category,
                new ArrayList<>(),  // tags 为空，images 字段被错误传入了 tags 参数
                difficulty,
                readTime,
                LocalDate.now(),
                UserId.of(adminId)
        );
    }
    
    /**
     * 截断字符串到指定长度
     */
    private String truncate(String str, int maxLength) {
        if (str == null) return null;
        if (str.length() <= maxLength) return str;
        return str.substring(0, maxLength - 3) + "...";
    }
}
