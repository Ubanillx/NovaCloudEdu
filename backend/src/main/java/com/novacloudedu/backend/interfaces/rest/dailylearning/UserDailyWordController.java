package com.novacloudedu.backend.interfaces.rest.dailylearning;

import com.novacloudedu.backend.application.dailylearning.command.StudyWordCommand;
import com.novacloudedu.backend.application.dailylearning.query.GetDailyWordQuery;
import com.novacloudedu.backend.application.dailylearning.query.GetUserDailyWordQuery;
import com.novacloudedu.backend.application.recommendation.service.GraphDataSyncService;
import com.novacloudedu.backend.application.recommendation.service.PreferenceAnalysisService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyWord;
import com.novacloudedu.backend.domain.recommendation.valueobject.BehaviorType;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.interfaces.rest.dailylearning.assembler.DailyLearningAssembler;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.UserDailyWordResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/user/daily-word")
@RequiredArgsConstructor
@Tag(name = "用户每日单词", description = "用户每日单词学习相关接口")
public class UserDailyWordController {

    private final StudyWordCommand studyWordCommand;
    private final GetUserDailyWordQuery getUserDailyWordQuery;
    private final GetDailyWordQuery getDailyWordQuery;
    private final PreferenceAnalysisService preferenceAnalysisService;
    private final GraphDataSyncService graphDataSyncService;
    private final DailyLearningAssembler assembler;

    @PostMapping("/{wordId}/study")
    @Operation(summary = "标记单词为已学习")
    public BaseResponse<Void> studyWord(@PathVariable @Parameter(description = "单词ID") Long wordId,
                                        Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        studyWordCommand.execute(userId, wordId);
        preferenceAnalysisService.recordBehavior(userId, BehaviorType.STUDY, TargetType.WORD, wordId, null, null);
        graphDataSyncService.syncUserStudyWord(userId, wordId);
        return ResultUtils.success(null);
    }

    @PostMapping("/{wordId}/mastery")
    @Operation(summary = "更新单词掌握程度")
    public BaseResponse<Void> updateMastery(@PathVariable @Parameter(description = "单词ID") Long wordId,
                                            @RequestParam @Parameter(description = "掌握程度：0-未知，1-生词，2-熟悉，3-掌握") Integer level,
                                            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        studyWordCommand.updateMastery(userId, wordId, level);
        return ResultUtils.success(null);
    }

    @PostMapping("/{wordId}/collect")
    @Operation(summary = "收藏/取消收藏单词")
    public BaseResponse<Void> toggleCollect(@PathVariable @Parameter(description = "单词ID") Long wordId,
                                            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        studyWordCommand.toggleCollect(userId, wordId);
        preferenceAnalysisService.recordBehavior(userId, BehaviorType.COLLECT, TargetType.WORD, wordId, null, null);
        graphDataSyncService.syncUserCollectWord(userId, wordId);
        return ResultUtils.success(null);
    }

    @GetMapping("/studied")
    @Operation(summary = "获取已学习单词列表")
    public BaseResponse<List<UserDailyWordResponse>> getStudiedWords(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        List<UserDailyWord> userWords = getUserDailyWordQuery.executeStudiedByUserId(userId, page, size);
        
        List<UserDailyWordResponse> responses = userWords.stream()
                .map(uw -> {
                    DailyWord word = getDailyWordQuery.execute(uw.getWordId().value()).orElse(null);
                    return word != null ? assembler.toUserDailyWordResponse(uw, word) : assembler.toUserDailyWordResponse(uw);
                })
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/collected")
    @Operation(summary = "获取收藏单词列表")
    public BaseResponse<List<UserDailyWordResponse>> getCollectedWords(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        List<UserDailyWord> userWords = getUserDailyWordQuery.executeCollectedByUserId(userId, page, size);
        
        List<UserDailyWordResponse> responses = userWords.stream()
                .map(uw -> {
                    DailyWord word = getDailyWordQuery.execute(uw.getWordId().value()).orElse(null);
                    return word != null ? assembler.toUserDailyWordResponse(uw, word) : assembler.toUserDailyWordResponse(uw);
                })
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/stats")
    @Operation(summary = "获取学习统计")
    public BaseResponse<LearningStats> getStats(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        long total = getUserDailyWordQuery.countByUserId(userId);
        long studied = getUserDailyWordQuery.countStudiedByUserId(userId);
        return ResultUtils.success(new LearningStats(total, studied));
    }

    public record LearningStats(long total, long studied) {}
}
