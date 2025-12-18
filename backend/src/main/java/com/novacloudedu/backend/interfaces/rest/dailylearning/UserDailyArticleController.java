package com.novacloudedu.backend.interfaces.rest.dailylearning;

import com.novacloudedu.backend.application.dailylearning.command.ArticleInteractionCommand;
import com.novacloudedu.backend.application.dailylearning.query.GetDailyArticleQuery;
import com.novacloudedu.backend.application.dailylearning.query.GetUserDailyArticleQuery;
import com.novacloudedu.backend.application.recommendation.service.GraphDataSyncService;
import com.novacloudedu.backend.application.recommendation.service.PreferenceAnalysisService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyArticle;
import com.novacloudedu.backend.domain.recommendation.valueobject.BehaviorType;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.interfaces.rest.dailylearning.assembler.DailyLearningAssembler;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.AddCommentRequest;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.UserDailyArticleResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/user/daily-article")
@RequiredArgsConstructor
@Tag(name = "用户每日文章", description = "用户每日文章阅读相关接口")
public class UserDailyArticleController {

    private final ArticleInteractionCommand articleInteractionCommand;
    private final GetUserDailyArticleQuery getUserDailyArticleQuery;
    private final GetDailyArticleQuery getDailyArticleQuery;
    private final PreferenceAnalysisService preferenceAnalysisService;
    private final GraphDataSyncService graphDataSyncService;
    private final DailyLearningAssembler assembler;

    @PostMapping("/{articleId}/read")
    @Operation(summary = "标记文章为已阅读")
    public BaseResponse<Void> markAsRead(@PathVariable @Parameter(description = "文章ID") Long articleId,
                                         Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        articleInteractionCommand.markAsRead(userId, articleId);
        preferenceAnalysisService.recordBehavior(userId, BehaviorType.READ, TargetType.ARTICLE, articleId, null, null);
        graphDataSyncService.syncUserReadArticle(userId, articleId);
        return ResultUtils.success(null);
    }

    @PostMapping("/{articleId}/like")
    @Operation(summary = "点赞/取消点赞文章")
    public BaseResponse<Void> toggleLike(@PathVariable @Parameter(description = "文章ID") Long articleId,
                                         Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        articleInteractionCommand.toggleLike(userId, articleId);
        preferenceAnalysisService.recordBehavior(userId, BehaviorType.LIKE, TargetType.ARTICLE, articleId, null, null);
        graphDataSyncService.syncUserLikeArticle(userId, articleId);
        return ResultUtils.success(null);
    }

    @PostMapping("/{articleId}/collect")
    @Operation(summary = "收藏/取消收藏文章")
    public BaseResponse<Void> toggleCollect(@PathVariable @Parameter(description = "文章ID") Long articleId,
                                            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        articleInteractionCommand.toggleCollect(userId, articleId);
        preferenceAnalysisService.recordBehavior(userId, BehaviorType.COLLECT, TargetType.ARTICLE, articleId, null, null);
        graphDataSyncService.syncUserCollectArticle(userId, articleId);
        return ResultUtils.success(null);
    }

    @PostMapping("/{articleId}/comment")
    @Operation(summary = "添加评论")
    public BaseResponse<Void> addComment(@PathVariable @Parameter(description = "文章ID") Long articleId,
                                         @Valid @RequestBody AddCommentRequest request,
                                         Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        articleInteractionCommand.addComment(userId, articleId, request.getContent());
        return ResultUtils.success(null);
    }

    @GetMapping("/read")
    @Operation(summary = "获取已阅读文章列表")
    public BaseResponse<List<UserDailyArticleResponse>> getReadArticles(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        List<UserDailyArticle> userArticles = getUserDailyArticleQuery.executeReadByUserId(userId, page, size);
        
        List<UserDailyArticleResponse> responses = userArticles.stream()
                .map(ua -> {
                    DailyArticle article = getDailyArticleQuery.execute(ua.getArticleId().value()).orElse(null);
                    return article != null ? assembler.toUserDailyArticleResponse(ua, article) : assembler.toUserDailyArticleResponse(ua);
                })
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/liked")
    @Operation(summary = "获取点赞文章列表")
    public BaseResponse<List<UserDailyArticleResponse>> getLikedArticles(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        List<UserDailyArticle> userArticles = getUserDailyArticleQuery.executeLikedByUserId(userId, page, size);
        
        List<UserDailyArticleResponse> responses = userArticles.stream()
                .map(ua -> {
                    DailyArticle article = getDailyArticleQuery.execute(ua.getArticleId().value()).orElse(null);
                    return article != null ? assembler.toUserDailyArticleResponse(ua, article) : assembler.toUserDailyArticleResponse(ua);
                })
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/collected")
    @Operation(summary = "获取收藏文章列表")
    public BaseResponse<List<UserDailyArticleResponse>> getCollectedArticles(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        List<UserDailyArticle> userArticles = getUserDailyArticleQuery.executeCollectedByUserId(userId, page, size);
        
        List<UserDailyArticleResponse> responses = userArticles.stream()
                .map(ua -> {
                    DailyArticle article = getDailyArticleQuery.execute(ua.getArticleId().value()).orElse(null);
                    return article != null ? assembler.toUserDailyArticleResponse(ua, article) : assembler.toUserDailyArticleResponse(ua);
                })
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/stats")
    @Operation(summary = "获取阅读统计")
    public BaseResponse<ReadingStats> getStats(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        long total = getUserDailyArticleQuery.countByUserId(userId);
        long read = getUserDailyArticleQuery.countReadByUserId(userId);
        return ResultUtils.success(new ReadingStats(total, read));
    }

    public record ReadingStats(long total, long read) {}
}
