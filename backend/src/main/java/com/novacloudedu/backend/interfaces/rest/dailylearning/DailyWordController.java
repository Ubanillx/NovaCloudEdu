package com.novacloudedu.backend.interfaces.rest.dailylearning;

import com.novacloudedu.backend.application.dailylearning.command.CreateDailyWordCommand;
import com.novacloudedu.backend.application.dailylearning.command.DeleteDailyWordCommand;
import com.novacloudedu.backend.application.dailylearning.command.UpdateDailyWordCommand;
import com.novacloudedu.backend.application.dailylearning.query.GetDailyWordQuery;
import com.novacloudedu.backend.application.recommendation.service.KnowledgeGraphRecommendationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.dailylearning.assembler.DailyLearningAssembler;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.CreateDailyWordRequest;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.DailyWordResponse;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.UpdateDailyWordRequest;
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
@RequestMapping("/api/daily-word")
@RequiredArgsConstructor
@Tag(name = "每日单词管理", description = "每日单词相关接口")
public class DailyWordController {

    private final CreateDailyWordCommand createDailyWordCommand;
    private final UpdateDailyWordCommand updateDailyWordCommand;
    private final DeleteDailyWordCommand deleteDailyWordCommand;
    private final GetDailyWordQuery getDailyWordQuery;
    private final KnowledgeGraphRecommendationService knowledgeGraphRecommendationService;
    private final DailyLearningAssembler assembler;

    @PostMapping
    @Operation(summary = "创建每日单词（管理员）")
    public BaseResponse<Long> createDailyWord(@Valid @RequestBody CreateDailyWordRequest request,
                                              Authentication authentication) {
        Long adminId = Long.parseLong(authentication.getName());
        Long wordId = createDailyWordCommand.execute(
                request.getWord(),
                request.getPronunciation(),
                request.getAudioUrl(),
                request.getTranslation(),
                request.getExample(),
                request.getExampleTranslation(),
                request.getDifficulty(),
                request.getCategory(),
                request.getNotes(),
                request.getPublishDate(),
                adminId
        );
        return ResultUtils.success(wordId);
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新每日单词（管理员）")
    public BaseResponse<Void> updateDailyWord(@PathVariable @Parameter(description = "单词ID") Long id,
                                              @Valid @RequestBody UpdateDailyWordRequest request) {
        updateDailyWordCommand.execute(
                id,
                request.getWord(),
                request.getPronunciation(),
                request.getAudioUrl(),
                request.getTranslation(),
                request.getExample(),
                request.getExampleTranslation(),
                request.getDifficulty(),
                request.getCategory(),
                request.getNotes(),
                request.getPublishDate()
        );
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除每日单词（管理员）")
    public BaseResponse<Void> deleteDailyWord(@PathVariable @Parameter(description = "单词ID") Long id) {
        deleteDailyWordCommand.execute(id);
        return ResultUtils.success(null);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取单词详情")
    public BaseResponse<DailyWordResponse> getDailyWord(@PathVariable @Parameter(description = "单词ID") Long id) {
        DailyWord word = getDailyWordQuery.execute(id)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        return ResultUtils.success(assembler.toDailyWordResponse(word));
    }

    @GetMapping("/today")
    @Operation(summary = "获取今日推荐单词（个性化推荐）")
    public BaseResponse<List<DailyWordResponse>> getTodayWords(
            @RequestParam(defaultValue = "10") @Parameter(description = "推荐数量") int size,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        List<DailyWord> words = knowledgeGraphRecommendationService.recommendWords(userId, size);
        List<DailyWordResponse> responses = words.stream()
                .map(assembler::toDailyWordResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/date/{date}")
    @Operation(summary = "获取指定日期单词")
    public BaseResponse<List<DailyWordResponse>> getWordsByDate(
            @PathVariable @Parameter(description = "日期") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        List<DailyWord> words = getDailyWordQuery.executeByPublishDate(date);
        List<DailyWordResponse> responses = words.stream()
                .map(assembler::toDailyWordResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/list")
    @Operation(summary = "获取单词列表")
    public BaseResponse<List<DailyWordResponse>> listWords(
            @RequestParam(required = false) @Parameter(description = "分类") String category,
            @RequestParam(required = false) @Parameter(description = "难度等级") Integer difficulty,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {

        List<DailyWord> words;
        if (category != null && !category.isEmpty()) {
            words = getDailyWordQuery.executeByCategory(category, page, size);
        } else if (difficulty != null) {
            words = getDailyWordQuery.executeByDifficulty(difficulty, page, size);
        } else {
            words = getDailyWordQuery.executeList(page, size);
        }

        List<DailyWordResponse> responses = words.stream()
                .map(assembler::toDailyWordResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/search")
    @Operation(summary = "搜索单词")
    public BaseResponse<List<DailyWordResponse>> searchWords(
            @RequestParam @Parameter(description = "关键词") String keyword,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {

        List<DailyWord> words = getDailyWordQuery.searchByWord(keyword, page, size);
        List<DailyWordResponse> responses = words.stream()
                .map(assembler::toDailyWordResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }
}
