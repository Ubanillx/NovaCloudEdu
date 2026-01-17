package com.novacloudedu.backend.interfaces.rest.book;

import com.novacloudedu.backend.application.book.service.AiQuestionApplicationService;
import com.novacloudedu.backend.application.book.service.ChapterSummaryApplicationService;
import com.novacloudedu.backend.application.book.service.KnowledgePointApplicationService;
import com.novacloudedu.backend.application.book.service.ReadingQuizApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.book.entity.AiConversation;
import com.novacloudedu.backend.domain.book.entity.ChapterSummary;
import com.novacloudedu.backend.domain.book.entity.KnowledgePoint;
import com.novacloudedu.backend.domain.book.entity.ReadingQuiz;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * AI电子书功能控制器
 */
@Slf4j
@Tag(name = "AI电子书功能", description = "AI辅助阅读功能接口")
@RestController
@RequestMapping("/api/books/{bookId}/ai")
@RequiredArgsConstructor
public class AiBookController {

    private final ChapterSummaryApplicationService summaryService;
    private final AiQuestionApplicationService questionService;
    private final KnowledgePointApplicationService knowledgeService;
    private final ReadingQuizApplicationService quizService;

    // ==================== 章节总结 ====================

    @Operation(summary = "生成章节总结")
    @PostMapping("/chapters/{chapterId}/summary")
    public BaseResponse<ChapterSummary> generateSummary(
            @PathVariable Long bookId,
            @PathVariable Long chapterId,
            @RequestParam(defaultValue = "DETAILED") String summaryType) {
        try {
            ChapterSummary summary = summaryService.generateSummary(chapterId, summaryType);
            return ResultUtils.success(summary);
        } catch (Exception e) {
            log.error("生成章节总结失败", e);
            return (BaseResponse<ChapterSummary>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @Operation(summary = "获取章节总结")
    @GetMapping("/chapters/{chapterId}/summary")
    public BaseResponse<ChapterSummary> getSummary(
            @PathVariable Long bookId,
            @PathVariable Long chapterId,
            @RequestParam(defaultValue = "DETAILED") String summaryType) {
        Optional<ChapterSummary> summary = summaryService.getSummary(chapterId, summaryType);
        if (summary.isPresent()) {
            return ResultUtils.success(summary.get());
        } else {
            return (BaseResponse<ChapterSummary>) (BaseResponse<?>) ResultUtils.error(40400, "总结不存在");
        }
    }

    @Operation(summary = "获取章节所有总结")
    @GetMapping("/chapters/{chapterId}/summaries")
    public BaseResponse<List<ChapterSummary>> getAllSummaries(
            @PathVariable Long bookId,
            @PathVariable Long chapterId) {
        List<ChapterSummary> summaries = summaryService.getAllSummaries(chapterId);
        return ResultUtils.success(summaries);
    }

    @Operation(summary = "重新生成总结")
    @PostMapping("/chapters/{chapterId}/summary/regenerate")
    public BaseResponse<ChapterSummary> regenerateSummary(
            @PathVariable Long bookId,
            @PathVariable Long chapterId,
            @RequestParam(defaultValue = "DETAILED") String summaryType) {
        try {
            ChapterSummary summary = summaryService.regenerateSummary(chapterId, summaryType);
            return ResultUtils.success(summary);
        } catch (Exception e) {
            log.error("重新生成总结失败", e);
            return (BaseResponse<ChapterSummary>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    // ==================== 智能问答 ====================

    @Operation(summary = "提问（新对话）")
    @PostMapping("/chat")
    public BaseResponse<Map<String, Object>> askQuestion(
            @PathVariable Long bookId,
            @RequestBody Map<String, Object> request) {
        try {
            Long userId = ((Number) request.get("userId")).longValue();
            String question = (String) request.get("question");
            Long chapterId = request.containsKey("chapterId") ? 
                    ((Number) request.get("chapterId")).longValue() : null;
            
            Map<String, Object> result = questionService.askQuestion(userId, bookId, question, chapterId);
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("AI问答失败", e);
            return (BaseResponse<Map<String, Object>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @Operation(summary = "继续对话")
    @PostMapping("/chat/{conversationId}")
    public BaseResponse<Map<String, Object>> continueConversation(
            @PathVariable Long bookId,
            @PathVariable Long conversationId,
            @RequestBody Map<String, String> request) {
        try {
            String question = request.get("question");
            Map<String, Object> result = questionService.continueConversation(conversationId, question);
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("继续对话失败", e);
            return (BaseResponse<Map<String, Object>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @Operation(summary = "获取对话历史")
    @GetMapping("/chat/{conversationId}")
    public BaseResponse<AiConversation> getConversation(
            @PathVariable Long bookId,
            @PathVariable Long conversationId) {
        try {
            AiConversation conversation = questionService.getConversation(conversationId);
            return ResultUtils.success(conversation);
        } catch (Exception e) {
            log.error("获取对话失败", e);
            return (BaseResponse<AiConversation>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @Operation(summary = "获取用户对话列表")
    @GetMapping("/conversations")
    public BaseResponse<List<AiConversation>> getUserConversations(
            @PathVariable Long bookId,
            @RequestParam Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        List<AiConversation> conversations = questionService.getUserConversations(userId, page, size);
        return ResultUtils.success(conversations);
    }

    // ==================== 知识点提取 ====================

    @Operation(summary = "提取章节知识点")
    @PostMapping("/chapters/{chapterId}/knowledge-points")
    public BaseResponse<List<KnowledgePoint>> extractKnowledgePoints(
            @PathVariable Long bookId,
            @PathVariable Long chapterId) {
        try {
            List<KnowledgePoint> points = knowledgeService.extractKnowledgePoints(chapterId);
            return ResultUtils.success(points);
        } catch (Exception e) {
            log.error("提取知识点失败", e);
            return (BaseResponse<List<KnowledgePoint>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @Operation(summary = "获取章节知识点")
    @GetMapping("/chapters/{chapterId}/knowledge-points")
    public BaseResponse<List<KnowledgePoint>> getKnowledgePoints(
            @PathVariable Long bookId,
            @PathVariable Long chapterId,
            @RequestParam(required = false) String type) {
        List<KnowledgePoint> points;
        if (type != null) {
            points = knowledgeService.getKnowledgePointsByType(chapterId, type);
        } else {
            points = knowledgeService.getKnowledgePoints(chapterId);
        }
        return ResultUtils.success(points);
    }

    @Operation(summary = "搜索知识点")
    @GetMapping("/knowledge-points/search")
    public BaseResponse<List<KnowledgePoint>> searchKnowledgePoints(
            @PathVariable Long bookId,
            @RequestParam String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        List<KnowledgePoint> points = knowledgeService.searchKnowledgePoints(keyword, page, size);
        return ResultUtils.success(points);
    }

    @Operation(summary = "重新提取知识点")
    @PostMapping("/chapters/{chapterId}/knowledge-points/regenerate")
    public BaseResponse<List<KnowledgePoint>> regenerateKnowledgePoints(
            @PathVariable Long bookId,
            @PathVariable Long chapterId) {
        try {
            List<KnowledgePoint> points = knowledgeService.regenerateKnowledgePoints(chapterId);
            return ResultUtils.success(points);
        } catch (Exception e) {
            log.error("重新提取知识点失败", e);
            return (BaseResponse<List<KnowledgePoint>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    // ==================== 阅读测试 ====================

    @Operation(summary = "生成阅读测试")
    @PostMapping("/chapters/{chapterId}/quiz")
    public BaseResponse<ReadingQuiz> generateQuiz(
            @PathVariable Long bookId,
            @PathVariable Long chapterId,
            @RequestParam(required = false) Integer questionCount,
            @RequestParam(required = false) String difficulty) {
        try {
            ReadingQuiz quiz = quizService.generateQuiz(chapterId, questionCount, difficulty);
            return ResultUtils.success(quiz);
        } catch (Exception e) {
            log.error("生成测试失败", e);
            return (BaseResponse<ReadingQuiz>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @Operation(summary = "获取测试")
    @GetMapping("/quiz/{quizId}")
    public BaseResponse<ReadingQuiz> getQuiz(
            @PathVariable Long bookId,
            @PathVariable Long quizId) {
        Optional<ReadingQuiz> quiz = quizService.getQuiz(quizId);
        if (quiz.isPresent()) {
            return ResultUtils.success(quiz.get());
        } else {
            return (BaseResponse<ReadingQuiz>) (BaseResponse<?>) ResultUtils.error(40400, "测试不存在");
        }
    }

    @Operation(summary = "获取章节最新测试")
    @GetMapping("/chapters/{chapterId}/quiz/latest")
    public BaseResponse<ReadingQuiz> getLatestQuiz(
            @PathVariable Long bookId,
            @PathVariable Long chapterId) {
        Optional<ReadingQuiz> quiz = quizService.getLatestQuiz(chapterId);
        if (quiz.isPresent()) {
            return ResultUtils.success(quiz.get());
        } else {
            return (BaseResponse<ReadingQuiz>) (BaseResponse<?>) ResultUtils.error(40400, "测试不存在");
        }
    }

    @Operation(summary = "提交答案并评分")
    @PostMapping("/quiz/{quizId}/submit")
    public BaseResponse<Map<String, Object>> submitAnswers(
            @PathVariable Long bookId,
            @PathVariable Long quizId,
            @RequestBody Map<String, List<String>> request) {
        try {
            List<String> answers = request.get("answers");
            int score = quizService.submitAnswers(quizId, answers);
            return ResultUtils.success(Map.of("score", score));
        } catch (Exception e) {
            log.error("提交答案失败", e);
            return (BaseResponse<Map<String, Object>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }
}
