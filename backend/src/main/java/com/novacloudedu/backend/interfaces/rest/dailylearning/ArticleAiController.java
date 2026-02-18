package com.novacloudedu.backend.interfaces.rest.dailylearning;

import com.novacloudedu.backend.application.dailylearning.command.AiProcessArticleCommand;
import com.novacloudedu.backend.application.service.ArticleAiApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.service.ArticleAiService;
import com.novacloudedu.backend.interfaces.rest.dailylearning.assembler.DailyLearningAssembler;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.request.AiProcessArticleRequest;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.request.BatchAiProcessRequest;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.request.PreviewAiProcessRequest;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.response.AiProcessResultResponse;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.DailyArticleResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 文章 AI 处理接口
 */
@Slf4j
@RestController
@RequestMapping("/api/admin/articles/ai")
@RequiredArgsConstructor
@Tag(name = "文章AI处理", description = "文章内容AI排版和摘要生成接口")
public class ArticleAiController {

    private final ArticleAiApplicationService articleAiApplicationService;
    private final DailyLearningAssembler dailyLearningAssembler;

    @PostMapping("/process")
    @Operation(summary = "AI处理单篇文章", description = "对指定文章进行AI内容排版和摘要生成")
    public BaseResponse<DailyArticleResponse> processArticle(@Valid @RequestBody AiProcessArticleRequest request) {
        log.info("AI 处理文章请求: articleId={}", request.getArticleId());
        
        AiProcessArticleCommand command = AiProcessArticleCommand.builder()
                .articleId(request.getArticleId())
                .formatContent(Boolean.TRUE.equals(request.getFormatContent()))
                .generateSummary(Boolean.TRUE.equals(request.getGenerateSummary()))
                .summaryMaxLength(request.getSummaryMaxLength() != null ? request.getSummaryMaxLength() : 150)
                .build();
        
        DailyArticle article = articleAiApplicationService.processExistingArticle(command);
        return ResultUtils.success(dailyLearningAssembler.toDailyArticleResponse(article));
    }

    @PostMapping("/batch-process")
    @Operation(summary = "批量AI处理文章", description = "批量对多篇文章进行AI处理")
    public BaseResponse<Map<String, Object>> batchProcessArticles(@Valid @RequestBody BatchAiProcessRequest request) {
        log.info("批量 AI 处理文章请求: 文章数={}", request.getArticleIds().size());
        
        int successCount = articleAiApplicationService.batchProcessArticles(
                request.getArticleIds(),
                Boolean.TRUE.equals(request.getFormatContent()),
                Boolean.TRUE.equals(request.getGenerateSummary())
        );
        
        return ResultUtils.success(Map.of(
                "total", request.getArticleIds().size(),
                "successCount", successCount,
                "failCount", request.getArticleIds().size() - successCount
        ));
    }

    @PostMapping("/preview")
    @Operation(summary = "预览AI处理结果", description = "预览AI处理结果，不保存到数据库")
    public BaseResponse<AiProcessResultResponse> previewAiProcess(@Valid @RequestBody PreviewAiProcessRequest request) {
        log.info("预览 AI 处理结果请求");
        
        ArticleAiService.AiProcessResult result = articleAiApplicationService.previewAiProcess(
                request.getContent(), request.getTitle());
        
        return ResultUtils.success(AiProcessResultResponse.builder()
                .formattedContent(result.formattedContent())
                .summary(result.summary())
                .build());
    }
}
