package com.novacloudedu.backend.interfaces.rest.scraper;

import com.novacloudedu.backend.application.scraper.command.ScraperConfigCommand;
import com.novacloudedu.backend.application.scraper.service.ScraperConfigApplicationService;
import com.novacloudedu.backend.application.scraper.service.ScraperSchedulerService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.scraper.entity.ScraperSourceConfig;
import com.novacloudedu.backend.domain.scraper.entity.ScraperTask;
import com.novacloudedu.backend.interfaces.rest.scraper.assembler.ScraperConfigAssembler;
import com.novacloudedu.backend.domain.scraper.repository.ScraperSourceConfigRepository.ConfigPage;
import com.novacloudedu.backend.domain.scraper.repository.ScraperTaskRepository.TaskPage;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.request.ExecuteTaskRequest;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.request.ScraperConfigRequest;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ScraperConfigPageResponse;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ScraperConfigResponse;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ScraperTaskPageResponse;
import com.novacloudedu.backend.interfaces.rest.scraper.dto.response.ScraperTaskResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 抓取配置管理控制器
 */
@Tag(name = "抓取配置管理", description = "管理抓取源配置和任务执行")
@RestController
@RequestMapping("/api/admin/scraper/config")
@RequiredArgsConstructor
@Slf4j
public class ScraperConfigController {

    private final ScraperConfigApplicationService configService;
    private final ScraperSchedulerService schedulerService;
    private final ScraperConfigAssembler assembler;

    // ==================== 配置管理 ====================

    /**
     * 创建抓取配置
     */
    @Operation(summary = "创建抓取配置", description = "创建新的抓取源配置")
    @PostMapping
    public BaseResponse<ScraperConfigResponse> createConfig(@Valid @RequestBody ScraperConfigRequest request) {
        log.info("创建抓取配置: {}", request.getName());
        ScraperConfigCommand command = assembler.toCommand(request);
        // TODO: 从当前用户获取 creatorId
        Long creatorId = 1L;
        ScraperSourceConfig config = configService.createConfig(command, creatorId);
        return ResultUtils.success(assembler.toResponse(config));
    }

    /**
     * 更新抓取配置
     */
    @Operation(summary = "更新抓取配置", description = "更新已有的抓取源配置")
    @PutMapping("/{id}")
    public BaseResponse<ScraperConfigResponse> updateConfig(
            @PathVariable Long id,
            @Valid @RequestBody ScraperConfigRequest request) {
        log.info("更新抓取配置: {}", id);
        request.setId(id);
        ScraperConfigCommand command = assembler.toCommand(request);
        ScraperSourceConfig config = configService.updateConfig(command);
        return ResultUtils.success(assembler.toResponse(config));
    }

    /**
     * 获取配置详情
     */
    @Operation(summary = "获取配置详情", description = "获取指定抓取配置的详细信息")
    @GetMapping("/{id}")
    public BaseResponse<ScraperConfigResponse> getConfig(@PathVariable Long id) {
        return configService.getConfig(id)
                .map(config -> ResultUtils.success(assembler.toResponse(config)))
                .orElse(ResultUtils.success(null));
    }

    /**
     * 获取所有配置
     */
    @Operation(summary = "获取所有配置", description = "获取所有抓取源配置列表")
    @GetMapping
    public BaseResponse<List<ScraperConfigResponse>> getAllConfigs() {
        List<ScraperSourceConfig> configs = configService.getAllConfigs();
        return ResultUtils.success(assembler.toResponseList(configs));
    }

    /**
     * 分页获取配置
     */
    @Operation(summary = "分页获取配置", description = "分页获取抓取源配置列表")
    @GetMapping("/page")
    public BaseResponse<ScraperConfigPageResponse> getConfigsByPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        ConfigPage configPage = configService.getConfigsByPageWithTotal(page, size);
        return ResultUtils.success(assembler.toConfigPageResponse(configPage));
    }

    /**
     * 启用配置
     */
    @Operation(summary = "启用配置", description = "启用指定的抓取配置")
    @PostMapping("/{id}/enable")
    public BaseResponse<Void> enableConfig(@PathVariable Long id) {
        log.info("启用抓取配置: {}", id);
        configService.enableConfig(id);
        return ResultUtils.success(null);
    }

    /**
     * 禁用配置
     */
    @Operation(summary = "禁用配置", description = "禁用指定的抓取配置")
    @PostMapping("/{id}/disable")
    public BaseResponse<Void> disableConfig(@PathVariable Long id) {
        log.info("禁用抓取配置: {}", id);
        configService.disableConfig(id);
        return ResultUtils.success(null);
    }

    /**
     * 删除配置
     */
    @Operation(summary = "删除配置", description = "删除指定的抓取配置")
    @DeleteMapping("/{id}")
    public BaseResponse<Void> deleteConfig(@PathVariable Long id) {
        log.info("删除抓取配置: {}", id);
        configService.deleteConfig(id);
        return ResultUtils.success(null);
    }

    // ==================== 任务执行 ====================

    /**
     * 手动执行抓取任务
     */
    @Operation(summary = "执行抓取任务", description = "手动触发指定配置的抓取任务")
    @PostMapping("/execute")
    public BaseResponse<ScraperTaskResponse> executeTask(@Valid @RequestBody ExecuteTaskRequest request) {
        log.info("手动执行抓取任务, 配置ID: {}", request.getConfigId());
        // TODO: 从当前用户获取 adminId
        Long adminId = 1L;
        ScraperTask task = configService.executeScraperTask(request.getConfigId(), request.getMaxArticles(), adminId);
        return ResultUtils.success(assembler.toTaskResponse(task));
    }

    /**
     * 触发所有启用配置的抓取
     */
    @Operation(summary = "触发所有抓取", description = "手动触发所有启用配置的抓取任务")
    @PostMapping("/execute-all")
    public BaseResponse<Void> executeAllTasks() {
        log.info("手动触发所有抓取任务");
        schedulerService.triggerAllScrape();
        return ResultUtils.success(null);
    }

    // ==================== 任务查询 ====================

    /**
     * 获取任务详情
     */
    @Operation(summary = "获取任务详情", description = "获取指定抓取任务的详细信息")
    @GetMapping("/task/{taskId}")
    public BaseResponse<ScraperTaskResponse> getTask(@PathVariable Long taskId) {
        return configService.getTask(taskId)
                .map(task -> ResultUtils.success(assembler.toTaskResponse(task)))
                .orElse(ResultUtils.success(null));
    }

    /**
     * 获取配置的任务列表
     */
    @Operation(summary = "获取配置的任务列表", description = "获取指定配置的任务执行历史")
    @GetMapping("/{configId}/tasks")
    public BaseResponse<ScraperTaskPageResponse> getTasksByConfig(
            @PathVariable Long configId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        TaskPage taskPage = configService.getTasksByConfigWithTotal(configId, page, size);
        return ResultUtils.success(assembler.toTaskPageResponse(taskPage));
    }

    /**
     * 获取所有任务
     */
    @Operation(summary = "获取所有任务", description = "获取所有抓取任务列表")
    @GetMapping("/tasks")
    public BaseResponse<ScraperTaskPageResponse> getAllTasks(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        TaskPage taskPage = configService.getAllTasksWithTotal(page, size);
        return ResultUtils.success(assembler.toTaskPageResponse(taskPage));
    }
}
