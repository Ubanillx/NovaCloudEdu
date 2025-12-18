package com.novacloudedu.backend.interfaces.rest.dailylearning;

import com.novacloudedu.backend.application.dailylearning.command.CreateDailyArticleCommand;
import com.novacloudedu.backend.application.dailylearning.command.DeleteDailyArticleCommand;
import com.novacloudedu.backend.application.dailylearning.command.UpdateDailyArticleCommand;
import com.novacloudedu.backend.application.dailylearning.query.GetDailyArticleQuery;
import com.novacloudedu.backend.application.recommendation.service.KnowledgeGraphRecommendationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.dailylearning.assembler.DailyLearningAssembler;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.CreateDailyArticleRequest;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.DailyArticleResponse;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.UpdateDailyArticleRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/daily-article")
@RequiredArgsConstructor
@Tag(name = "每日文章管理", description = "每日文章相关接口")
public class DailyArticleController {

    private final CreateDailyArticleCommand createDailyArticleCommand;
    private final UpdateDailyArticleCommand updateDailyArticleCommand;
    private final DeleteDailyArticleCommand deleteDailyArticleCommand;
    private final GetDailyArticleQuery getDailyArticleQuery;
    private final KnowledgeGraphRecommendationService knowledgeGraphRecommendationService;
    private final DailyLearningAssembler assembler;

    @PostMapping
    @Operation(summary = "创建每日文章（管理员）")
    public BaseResponse<Long> createDailyArticle(@Valid @RequestBody CreateDailyArticleRequest request,
                                                 Authentication authentication) {
        Long adminId = Long.parseLong(authentication.getName());
        Long articleId = createDailyArticleCommand.execute(
                request.getTitle(),
                request.getContent(),
                request.getSummary(),
                request.getCoverImage(),
                request.getAuthor(),
                request.getSource(),
                request.getSourceUrl(),
                request.getCategory(),
                request.getTags(),
                request.getDifficulty(),
                request.getReadTime(),
                request.getPublishDate(),
                adminId
        );
        return ResultUtils.success(articleId);
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新每日文章（管理员）")
    public BaseResponse<Void> updateDailyArticle(@PathVariable @Parameter(description = "文章ID") Long id,
                                                 @Valid @RequestBody UpdateDailyArticleRequest request) {
        updateDailyArticleCommand.execute(
                id,
                request.getTitle(),
                request.getContent(),
                request.getSummary(),
                request.getCoverImage(),
                request.getAuthor(),
                request.getSource(),
                request.getSourceUrl(),
                request.getCategory(),
                request.getTags(),
                request.getDifficulty(),
                request.getReadTime(),
                request.getPublishDate()
        );
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除每日文章（管理员）")
    public BaseResponse<Void> deleteDailyArticle(@PathVariable @Parameter(description = "文章ID") Long id) {
        deleteDailyArticleCommand.execute(id);
        return ResultUtils.success(null);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取文章详情")
    public BaseResponse<DailyArticleResponse> getDailyArticle(@PathVariable @Parameter(description = "文章ID") Long id) {
        DailyArticle article = getDailyArticleQuery.execute(id)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        return ResultUtils.success(assembler.toDailyArticleResponse(article));
    }

    @GetMapping("/today")
    @Operation(summary = "获取今日推荐文章（个性化推荐）")
    public BaseResponse<List<DailyArticleResponse>> getTodayArticles(
            @RequestParam(defaultValue = "10") @Parameter(description = "推荐数量") int size,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        List<DailyArticle> articles = knowledgeGraphRecommendationService.recommendArticles(userId, size);
        List<DailyArticleResponse> responses = articles.stream()
                .map(assembler::toDailyArticleResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/date/{date}")
    @Operation(summary = "获取指定日期文章")
    public BaseResponse<List<DailyArticleResponse>> getArticlesByDate(
            @PathVariable @Parameter(description = "日期") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        List<DailyArticle> articles = getDailyArticleQuery.executeByPublishDate(date);
        List<DailyArticleResponse> responses = articles.stream()
                .map(assembler::toDailyArticleResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/list")
    @Operation(summary = "获取文章列表")
    public BaseResponse<List<DailyArticleResponse>> listArticles(
            @RequestParam(required = false) @Parameter(description = "分类") String category,
            @RequestParam(required = false) @Parameter(description = "难度等级") Integer difficulty,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {

        List<DailyArticle> articles;
        if (category != null && !category.isEmpty()) {
            articles = getDailyArticleQuery.executeByCategory(category, page, size);
        } else if (difficulty != null) {
            articles = getDailyArticleQuery.executeByDifficulty(difficulty, page, size);
        } else {
            articles = getDailyArticleQuery.executeList(page, size);
        }

        List<DailyArticleResponse> responses = articles.stream()
                .map(assembler::toDailyArticleResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/search")
    @Operation(summary = "搜索文章")
    public BaseResponse<List<DailyArticleResponse>> searchArticles(
            @RequestParam @Parameter(description = "关键词") String keyword,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {

        List<DailyArticle> articles = getDailyArticleQuery.searchByKeyword(keyword, page, size);
        List<DailyArticleResponse> responses = articles.stream()
                .map(assembler::toDailyArticleResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }
}
