package com.novacloudedu.backend.interfaces.rest.feedback;

import com.novacloudedu.backend.application.service.FeedbackApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.feedback.entity.FeedbackReply;
import com.novacloudedu.backend.domain.feedback.entity.UserFeedback;
import com.novacloudedu.backend.domain.feedback.repository.UserFeedbackRepository.FeedbackPage;
import com.novacloudedu.backend.interfaces.rest.feedback.assembler.FeedbackAssembler;
import com.novacloudedu.backend.interfaces.rest.feedback.dto.request.CreateFeedbackRequest;
import com.novacloudedu.backend.interfaces.rest.feedback.dto.request.CreateReplyRequest;
import com.novacloudedu.backend.interfaces.rest.feedback.dto.response.FeedbackDetailResponse;
import com.novacloudedu.backend.interfaces.rest.feedback.dto.response.FeedbackPageResponse;
import com.novacloudedu.backend.interfaces.rest.feedback.dto.response.FeedbackReplyResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户反馈控制器（用户端）
 */
@Tag(name = "用户反馈", description = "用户反馈相关接口")
@RestController
@RequestMapping("/api/feedback")
@RequiredArgsConstructor
@Slf4j
public class FeedbackController {

    private final FeedbackApplicationService feedbackService;
    private final FeedbackAssembler feedbackAssembler;

    /**
     * 创建反馈
     */
    @Operation(summary = "创建反馈", description = "用户提交新的反馈")
    @PostMapping
    public BaseResponse<Long> createFeedback(@RequestBody @Valid CreateFeedbackRequest request) {
        Long feedbackId = feedbackService.createFeedback(
                feedbackAssembler.toCreateCommand(request)
        );
        return ResultUtils.success(feedbackId);
    }

    /**
     * 获取我的反馈列表
     */
    @Operation(summary = "获取我的反馈列表", description = "分页获取当前用户的反馈列表")
    @GetMapping("/my")
    public BaseResponse<FeedbackPageResponse> getMyFeedbacks(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        FeedbackPage page = feedbackService.getMyFeedbacks(pageNum, pageSize);
        return ResultUtils.success(feedbackAssembler.toPageResponse(page));
    }

    /**
     * 获取反馈详情
     */
    @Operation(summary = "获取反馈详情", description = "获取指定反馈的详细信息及回复列表")
    @GetMapping("/{id}")
    public BaseResponse<FeedbackDetailResponse> getFeedbackDetail(@PathVariable Long id) {
        UserFeedback feedback = feedbackService.getFeedbackDetail(id);
        List<FeedbackReply> replies = feedbackService.getFeedbackReplies(id);
        return ResultUtils.success(feedbackAssembler.toDetailResponse(feedback, replies));
    }

    /**
     * 回复反馈
     */
    @Operation(summary = "回复反馈", description = "用户回复自己的反馈")
    @PostMapping("/reply")
    public BaseResponse<Long> replyFeedback(@RequestBody @Valid CreateReplyRequest request) {
        Long replyId = feedbackService.replyFeedback(
                feedbackAssembler.toReplyCommand(request)
        );
        return ResultUtils.success(replyId);
    }

    /**
     * 获取反馈的回复列表
     */
    @Operation(summary = "获取反馈回复列表", description = "获取指定反馈的所有回复")
    @GetMapping("/{id}/replies")
    public BaseResponse<List<FeedbackReplyResponse>> getFeedbackReplies(@PathVariable Long id) {
        List<FeedbackReply> replies = feedbackService.getFeedbackReplies(id);
        List<FeedbackReplyResponse> responses = replies.stream()
                .map(feedbackAssembler::toReplyResponse)
                .toList();
        return ResultUtils.success(responses);
    }

    /**
     * 标记回复为已读
     */
    @Operation(summary = "标记回复为已读", description = "将反馈的所有回复标记为已读")
    @PostMapping("/{id}/read")
    public BaseResponse<Boolean> markRepliesAsRead(@PathVariable Long id) {
        feedbackService.markRepliesAsRead(id);
        return ResultUtils.success(true);
    }

    /**
     * 删除反馈
     */
    @Operation(summary = "删除反馈", description = "用户删除自己的反馈")
    @DeleteMapping("/{id}")
    public BaseResponse<Boolean> deleteFeedback(@PathVariable Long id) {
        feedbackService.deleteFeedback(id);
        return ResultUtils.success(true);
    }
}
