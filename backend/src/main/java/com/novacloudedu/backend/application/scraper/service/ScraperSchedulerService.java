package com.novacloudedu.backend.application.scraper.service;

import com.novacloudedu.backend.domain.scraper.entity.ScraperSourceConfig;
import com.novacloudedu.backend.domain.scraper.entity.ScraperTask;
import com.novacloudedu.backend.domain.scraper.repository.ScraperSourceConfigRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 抓取调度服务
 * 负责定时执行抓取任务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ScraperSchedulerService {

    private final ScraperSourceConfigRepository configRepository;
    private final ScraperConfigApplicationService scraperConfigApplicationService;

    private static final Long SYSTEM_ADMIN_ID = 1L;

    /**
     * 每天早上6点执行抓取任务
     */
    @Scheduled(cron = "0 0 6 * * ?")
    public void scheduledDailyScrape() {
        log.info("开始执行每日定时抓取任务");
        executeAllEnabledConfigs();
    }

    /**
     * 每小时检查需要执行的配置（根据 cron 表达式）
     */
    @Scheduled(cron = "0 0 * * * ?")
    public void scheduleHourlyCheck() {
        log.debug("检查定时抓取任务");
        // 这里可以根据配置的 cron 表达式来判断是否需要执行
        // 简化实现：仅在每天6点执行
    }

    /**
     * 执行所有启用的配置
     */
    public void executeAllEnabledConfigs() {
        List<ScraperSourceConfig> enabledConfigs = configRepository.findAllEnabled();
        log.info("找到 {} 个启用的抓取配置", enabledConfigs.size());
        
        for (ScraperSourceConfig config : enabledConfigs) {
            try {
                log.info("开始执行抓取配置: {}", config.getName());
                ScraperTask task = scraperConfigApplicationService.executeTask(
                        config, config.getDefaultMaxArticles(), SYSTEM_ADMIN_ID);
                log.info("抓取配置 {} 执行完成, 状态: {}, 成功: {} 篇", 
                        config.getName(), task.getStatus(), task.getSuccessCount());
            } catch (Exception e) {
                log.error("执行抓取配置 {} 失败: {}", config.getName(), e.getMessage());
            }
        }
        
        log.info("每日定时抓取任务执行完成");
    }

    /**
     * 手动触发所有抓取
     */
    public void triggerAllScrape() {
        log.info("手动触发所有抓取任务");
        executeAllEnabledConfigs();
    }

    /**
     * 手动触发指定配置的抓取
     */
    public ScraperTask triggerScrape(Long configId, Integer maxArticles) {
        log.info("手动触发抓取任务, 配置ID: {}", configId);
        return scraperConfigApplicationService.executeScraperTask(configId, maxArticles, SYSTEM_ADMIN_ID);
    }
}
