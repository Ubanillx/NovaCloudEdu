package com.novacloudedu.backend.interfaces.rest.scraper.assembler;

import com.novacloudedu.backend.application.scraper.command.ScraperConfigCommand;
import com.novacloudedu.backend.domain.scraper.entity.ScraperSourceConfig;
import com.novacloudedu.backend.domain.scraper.entity.ScraperTask;
import com.novacloudedu.backend.domain.scraper.repository.ScraperSourceConfigRepository.ConfigPage;
import com.novacloudedu.backend.domain.scraper.repository.ScraperTaskRepository.TaskPage;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.request.ScraperConfigRequest;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ScraperConfigPageResponse;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ScraperConfigResponse;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ScraperTaskPageResponse;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ScraperTaskResponse;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 抓取配置装配器
 */
@Component
public class ScraperConfigAssembler {

    public ScraperConfigCommand toCommand(ScraperConfigRequest request) {
        return new ScraperConfigCommand(
                request.getId(),
                request.getName(),
                request.getSourceCode(),
                request.getBaseUrl(),
                request.getDescription(),
                request.getTitleSelector(),
                request.getAuthorSelector(),
                request.getSourceSelector(),
                request.getContentSelector(),
                request.getDateSelector(),
                request.getImageSelector(),
                request.getLinkSelector(),
                request.getMaxDepth(),
                request.getMaxPages(),
                request.getDelayMs(),
                request.getUseDynamic(),
                request.getWaitForJsMs(),
                request.getCronExpression(),
                request.getEnabled(),
                request.getDefaultMaxArticles(),
                request.getDefaultCategory(),
                request.getDefaultDifficulty()
        );
    }

    public ScraperConfigResponse toResponse(ScraperSourceConfig config) {
        if (config == null) {
            return null;
        }
        return ScraperConfigResponse.builder()
                .id(config.getId().value())
                .name(config.getName())
                .sourceCode(config.getSourceCode())
                .baseUrl(config.getBaseUrl())
                .description(config.getDescription())
                .titleSelector(config.getTitleSelector())
                .authorSelector(config.getAuthorSelector())
                .sourceSelector(config.getSourceSelector())
                .contentSelector(config.getContentSelector())
                .dateSelector(config.getDateSelector())
                .imageSelector(config.getImageSelector())
                .linkSelector(config.getLinkSelector())
                .maxDepth(config.getMaxDepth())
                .maxPages(config.getMaxPages())
                .delayMs(config.getDelayMs())
                .useDynamic(config.getUseDynamic())
                .waitForJsMs(config.getWaitForJsMs())
                .cronExpression(config.getCronExpression())
                .enabled(config.getEnabled())
                .defaultMaxArticles(config.getDefaultMaxArticles())
                .defaultCategory(config.getDefaultCategory())
                .defaultDifficulty(config.getDefaultDifficulty())
                .creatorId(config.getCreatorId() != null ? config.getCreatorId().value() : null)
                .createTime(config.getCreateTime())
                .updateTime(config.getUpdateTime())
                .build();
    }

    public List<ScraperConfigResponse> toResponseList(List<ScraperSourceConfig> configs) {
        return configs.stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    public ScraperTaskResponse toTaskResponse(ScraperTask task) {
        if (task == null) {
            return null;
        }
        return ScraperTaskResponse.builder()
                .id(task.getId().value())
                .configId(task.getConfigId().value())
                .configName(task.getConfigName())
                .status(task.getStatus().name())
                .statusDescription(task.getStatus().getDescription())
                .totalArticles(task.getTotalArticles())
                .successCount(task.getSuccessCount())
                .failCount(task.getFailCount())
                .createdArticleIds(task.getCreatedArticleIds())
                .errorMessage(task.getErrorMessage())
                .startTime(task.getStartTime())
                .endTime(task.getEndTime())
                .durationMs(task.getDurationMs())
                .createTime(task.getCreateTime())
                .build();
    }

    public List<ScraperTaskResponse> toTaskResponseList(List<ScraperTask> tasks) {
        return tasks.stream()
                .map(this::toTaskResponse)
                .collect(Collectors.toList());
    }

    // ==================== 分页响应转换 ====================

    public ScraperConfigPageResponse toConfigPageResponse(ConfigPage page) {
        List<ScraperConfigResponse> records = page.configs().stream()
                .map(this::toResponse)
                .toList();
        return new ScraperConfigPageResponse(
                records,
                page.total(),
                page.pageNum(),
                page.pageSize(),
                page.getTotalPages()
        );
    }

    public ScraperTaskPageResponse toTaskPageResponse(TaskPage page) {
        List<ScraperTaskResponse> records = page.tasks().stream()
                .map(this::toTaskResponse)
                .toList();
        return new ScraperTaskPageResponse(
                records,
                page.total(),
                page.pageNum(),
                page.pageSize(),
                page.getTotalPages()
        );
    }
}
