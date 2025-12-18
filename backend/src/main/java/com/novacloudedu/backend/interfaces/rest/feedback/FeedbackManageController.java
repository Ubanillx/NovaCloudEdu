package com.novacloudedu.backend.interfaces.rest.feedback;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.service.FeedbackApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.feedback.entity.FeedbackReply;
import com.novacloudedu.backend.domain.feedback.entity.UserFeedback;
import com.novacloudedu.backend.domain.feedback.repository.UserFeedbackRepository.FeedbackPage;
import com.novacloudedu.backend.interfaces.rest.feedback.assembler.FeedbackAssembler;
import com.novacloudedu.backend.interfaces.rest.feedback.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.feedback.dto.response.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 反馈管理控制器（管理员端）
 */
@Tag(name = "反馈管理", description = "管理员反馈管理接口")
@RestController
@RequestMapping("/api/feedback/admin")
@RequiredArgsConstructor
@Slf4j
public class FeedbackManageController {

    private final FeedbackApplicationService feedbackService;
    private final FeedbackAssembler feedbackAssembler;

    /**
     * 分页查询反馈
     */
    @Operation(summary = "分页查询反馈", description = "管理员分页查询所有反馈")
    @PostMapping("/list")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<FeedbackPageResponse> queryFeedbacks(@RequestBody QueryFeedbackRequest request) {
        FeedbackPage page = feedbackService.queryFeedbacks(
                feedbackAssembler.toQuery(request)
        );
        return ResultUtils.success(feedbackAssembler.toPageResponse(page));
    }

    /**
     * 获取反馈详情
     */
    @Operation(summary = "获取反馈详情", description = "管理员获取反馈详细信息")
    @GetMapping("/{id}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<FeedbackDetailResponse> getFeedbackDetail(@PathVariable Long id) {
        UserFeedback feedback = feedbackService.getFeedbackDetailAdmin(id);
        List<FeedbackReply> replies = feedbackService.getFeedbackRepliesAdmin(id);
        return ResultUtils.success(feedbackAssembler.toDetailResponse(feedback, replies));
    }

    /**
     * 更新反馈状态
     */
    @Operation(summary = "更新反馈状态", description = "管理员更新反馈处理状态")
    @PutMapping("/status")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> updateFeedbackStatus(@RequestBody @Valid UpdateFeedbackStatusRequest request) {
        feedbackService.updateFeedbackStatus(
                feedbackAssembler.toUpdateStatusCommand(request)
        );
        return ResultUtils.success(true);
    }

    /**
     * 回复反馈
     */
    @Operation(summary = "回复反馈", description = "管理员回复用户反馈")
    @PostMapping("/reply")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Long> replyFeedback(@RequestBody @Valid CreateReplyRequest request) {
        Long replyId = feedbackService.replyFeedbackAdmin(
                feedbackAssembler.toReplyCommand(request)
        );
        return ResultUtils.success(replyId);
    }

    /**
     * 获取反馈的回复列表
     */
    @Operation(summary = "获取反馈回复列表", description = "管理员获取反馈的所有回复")
    @GetMapping("/{id}/replies")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<List<FeedbackReplyResponse>> getFeedbackReplies(@PathVariable Long id) {
        List<FeedbackReply> replies = feedbackService.getFeedbackRepliesAdmin(id);
        List<FeedbackReplyResponse> responses = replies.stream()
                .map(feedbackAssembler::toReplyResponse)
                .toList();
        return ResultUtils.success(responses);
    }

    /**
     * 删除反馈
     */
    @Operation(summary = "删除反馈", description = "管理员删除反馈")
    @DeleteMapping("/{id}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> deleteFeedback(@PathVariable Long id) {
        feedbackService.deleteFeedbackAdmin(id);
        return ResultUtils.success(true);
    }
}
