package com.novacloudedu.backend.interfaces.rest.exam;

import com.novacloudedu.backend.application.exam.service.AiQuestionGenerationService;
import com.novacloudedu.backend.application.exam.service.QuestionBankApplicationService;
import com.novacloudedu.backend.application.service.UserApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.exam.entity.Question;
import com.novacloudedu.backend.domain.exam.repository.QuestionRepository.QuestionPage;
import com.novacloudedu.backend.interfaces.rest.exam.assembler.ExamAssembler;
import com.novacloudedu.backend.interfaces.rest.exam.dto.request.AiGenerateQuestionsRequest;
import com.novacloudedu.backend.interfaces.rest.exam.dto.request.CreateQuestionRequest;
import com.novacloudedu.backend.interfaces.rest.exam.dto.request.QueryQuestionRequest;
import com.novacloudedu.backend.interfaces.rest.exam.dto.request.UpdateQuestionRequest;
import com.novacloudedu.backend.interfaces.rest.exam.dto.response.QuestionPageResponse;
import com.novacloudedu.backend.interfaces.rest.exam.dto.response.QuestionResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

/**
 * 题库管理控制器
 */
@Tag(name = "题库管理", description = "题目创建、查询、编辑、删除")
@RestController
@RequestMapping("/api/questions")
@RequiredArgsConstructor
@Slf4j
public class QuestionBankController {

    private final QuestionBankApplicationService questionBankApplicationService;
    private final AiQuestionGenerationService aiQuestionGenerationService;
    private final UserApplicationService userApplicationService;
    private final ExamAssembler examAssembler;

    /**
     * 创建题目
     */
    @Operation(summary = "创建题目")
    @PostMapping
    public BaseResponse<Long> createQuestion(@RequestBody @Valid CreateQuestionRequest request) {
        Long id = questionBankApplicationService.createQuestion(
                examAssembler.toCreateQuestionCommand(request)
        );
        return ResultUtils.success(id);
    }

    /**
     * 更新题目
     */
    @Operation(summary = "更新题目")
    @PutMapping
    public BaseResponse<Boolean> updateQuestion(@RequestBody @Valid UpdateQuestionRequest request) {
        questionBankApplicationService.updateQuestion(
                examAssembler.toUpdateQuestionCommand(request)
        );
        return ResultUtils.success(true);
    }

    /**
     * 删除题目
     */
    @Operation(summary = "删除题目")
    @DeleteMapping("/{id}")
    public BaseResponse<Boolean> deleteQuestion(@PathVariable Long id) {
        questionBankApplicationService.deleteQuestion(id);
        return ResultUtils.success(true);
    }

    /**
     * 获取题目详情
     */
    @Operation(summary = "获取题目详情")
    @GetMapping("/{id}")
    public BaseResponse<QuestionResponse> getQuestion(@PathVariable Long id) {
        Question question = questionBankApplicationService.getQuestionById(id);
        return ResultUtils.success(examAssembler.toQuestionResponse(question));
    }

    /**
     * 分页查询题目
     */
    @Operation(summary = "分页查询题目")
    @GetMapping
    public BaseResponse<QuestionPageResponse> queryQuestions(QueryQuestionRequest request) {
        QuestionPage page = questionBankApplicationService.queryQuestions(
                examAssembler.toQuestionQuery(request)
        );
        return ResultUtils.success(examAssembler.toQuestionPageResponse(page));
    }

    /**
     * 查询我的题目
     */
    @Operation(summary = "查询我的题目")
    @GetMapping("/mine")
    public BaseResponse<QuestionPageResponse> queryMyQuestions(QueryQuestionRequest request) {
        QuestionPage page = questionBankApplicationService.queryMyQuestions(
                examAssembler.toQuestionQuery(request)
        );
        return ResultUtils.success(examAssembler.toQuestionPageResponse(page));
    }

    /**
     * AI 智能出题（SSE 流式）
     */
    @Operation(summary = "AI 智能出题", description = "支持联网搜索热点、几何图形渲染、文生图配图")
    @PostMapping(value = "/ai-generate", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter aiGenerateQuestions(@RequestBody @Valid AiGenerateQuestionsRequest request) {
        Long userId = userApplicationService.getCurrentUser().getId().value();

        AiQuestionGenerationService.GenerateParams params = new AiQuestionGenerationService.GenerateParams(
                request.subject(),
                request.type(),
                request.difficulty(),
                request.grade(),
                request.count(),
                request.topic(),
                request.withDiagram(),
                request.withImage(),
                request.enableWebSearch(),
                request.modelId(),
                request.userInput()
        );

        log.info("AI 出题请求: subject={}, type={}, count={}, webSearch={}, userId={}",
                request.subject(), request.type(), request.count(), request.enableWebSearch(), userId);

        return aiQuestionGenerationService.generateQuestions(params, userId);
    }
}
