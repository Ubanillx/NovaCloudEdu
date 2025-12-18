package com.novacloudedu.backend.interfaces.rest.dailylearning;

import com.novacloudedu.backend.application.dailylearning.command.WordBookCommand;
import com.novacloudedu.backend.application.dailylearning.query.GetDailyWordQuery;
import com.novacloudedu.backend.application.dailylearning.query.GetUserWordBookQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.entity.UserWordBook;
import com.novacloudedu.backend.interfaces.rest.dailylearning.assembler.DailyLearningAssembler;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.UserWordBookResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/user/word-book")
@RequiredArgsConstructor
@Tag(name = "用户生词本", description = "用户生词本相关接口")
public class UserWordBookController {

    private final WordBookCommand wordBookCommand;
    private final GetUserWordBookQuery getUserWordBookQuery;
    private final GetDailyWordQuery getDailyWordQuery;
    private final DailyLearningAssembler assembler;

    @PostMapping("/add/{wordId}")
    @Operation(summary = "添加单词到生词本")
    public BaseResponse<Long> addToWordBook(@PathVariable @Parameter(description = "单词ID") Long wordId,
                                            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        Long wordBookId = wordBookCommand.addToWordBook(userId, wordId);
        return ResultUtils.success(wordBookId);
    }

    @PutMapping("/{wordBookId}/status")
    @Operation(summary = "更新学习状态")
    public BaseResponse<Void> updateLearningStatus(
            @PathVariable @Parameter(description = "生词本记录ID") Long wordBookId,
            @RequestParam @Parameter(description = "学习状态：0-未学习，1-已学习，2-已掌握") Integer status,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        wordBookCommand.updateLearningStatus(userId, wordBookId, status);
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{wordBookId}")
    @Operation(summary = "从生词本移除单词")
    public BaseResponse<Void> removeFromWordBook(
            @PathVariable @Parameter(description = "生词本记录ID") Long wordBookId,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        wordBookCommand.removeFromWordBook(userId, wordBookId);
        return ResultUtils.success(null);
    }

    @GetMapping("/list")
    @Operation(summary = "获取生词本列表")
    public BaseResponse<List<UserWordBookResponse>> getWordBookList(
            @RequestParam(required = false) @Parameter(description = "学习状态：0-未学习，1-已学习，2-已掌握") Integer status,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        
        List<UserWordBook> wordBooks;
        if (status != null) {
            wordBooks = getUserWordBookQuery.executeByUserIdAndStatus(userId, status, page, size);
        } else {
            wordBooks = getUserWordBookQuery.executeByUserId(userId, page, size);
        }
        
        List<UserWordBookResponse> responses = wordBooks.stream()
                .map(wb -> {
                    DailyWord word = getDailyWordQuery.execute(wb.getWordId().value()).orElse(null);
                    return word != null ? assembler.toUserWordBookResponse(wb, word) : assembler.toUserWordBookResponse(wb);
                })
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/stats")
    @Operation(summary = "获取生词本统计")
    public BaseResponse<WordBookStats> getStats(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        long total = getUserWordBookQuery.countByUserId(userId);
        long notLearned = getUserWordBookQuery.countByUserIdAndStatus(userId, 0);
        long learned = getUserWordBookQuery.countByUserIdAndStatus(userId, 1);
        long mastered = getUserWordBookQuery.countByUserIdAndStatus(userId, 2);
        return ResultUtils.success(new WordBookStats(total, notLearned, learned, mastered));
    }

    public record WordBookStats(long total, long notLearned, long learned, long mastered) {}
}
