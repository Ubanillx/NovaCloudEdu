package com.novacloudedu.backend.interfaces.rest.feedback.assembler;

import com.novacloudedu.backend.application.feedback.command.CreateFeedbackCommand;
import com.novacloudedu.backend.application.feedback.command.CreateReplyCommand;
import com.novacloudedu.backend.application.feedback.command.UpdateFeedbackStatusCommand;
import com.novacloudedu.backend.application.feedback.query.FeedbackQuery;
import com.novacloudedu.backend.domain.feedback.entity.FeedbackReply;
import com.novacloudedu.backend.domain.feedback.entity.UserFeedback;
import com.novacloudedu.backend.domain.feedback.repository.UserFeedbackRepository.FeedbackPage;
import com.novacloudedu.backend.interfaces.rest.feedback.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.feedback.dto.response.*;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 反馈装配器
 */
@Component
public class FeedbackAssembler {

    /**
     * 转换为创建反馈命令
     */
    public CreateFeedbackCommand toCreateCommand(CreateFeedbackRequest request) {
        return new CreateFeedbackCommand(
                request.feedbackType(),
                request.title(),
                request.content(),
                request.attachment()
        );
    }

    /**
     * 转换为创建回复命令
     */
    public CreateReplyCommand toReplyCommand(CreateReplyRequest request) {
        return new CreateReplyCommand(
                request.feedbackId(),
                request.content(),
                request.attachment()
        );
    }

    /**
     * 转换为更新状态命令
     */
    public UpdateFeedbackStatusCommand toUpdateStatusCommand(UpdateFeedbackStatusRequest request) {
        return new UpdateFeedbackStatusCommand(
                request.feedbackId(),
                request.status()
        );
    }

    /**
     * 转换为查询条件
     */
    public FeedbackQuery toQuery(QueryFeedbackRequest request) {
        return new FeedbackQuery(
                request.userId(),
                request.feedbackType(),
                request.status(),
                request.getPageNum(),
                request.getPageSize()
        );
    }

    /**
     * 转换为反馈响应
     */
    public FeedbackResponse toResponse(UserFeedback feedback) {
        return new FeedbackResponse(
                feedback.getId().value(),
                feedback.getUserId().value(),
                feedback.getFeedbackType(),
                feedback.getTitle(),
                feedback.getContent(),
                feedback.getAttachment(),
                feedback.getStatus().getCode(),
                feedback.getStatus().getDescription(),
                feedback.getAdminId() != null ? feedback.getAdminId().value() : null,
                feedback.getProcessTime(),
                feedback.getCreateTime(),
                feedback.getUpdateTime()
        );
    }

    /**
     * 转换为回复响应
     */
    public FeedbackReplyResponse toReplyResponse(FeedbackReply reply) {
        return new FeedbackReplyResponse(
                reply.getId().value(),
                reply.getFeedbackId().value(),
                reply.getSenderId().value(),
                reply.getSenderRole().getCode(),
                reply.getSenderRole().getDescription(),
                reply.getContent(),
                reply.getAttachment(),
                reply.isRead(),
                reply.getCreateTime(),
                reply.getUpdateTime()
        );
    }

    /**
     * 转换为反馈详情响应
     */
    public FeedbackDetailResponse toDetailResponse(UserFeedback feedback, List<FeedbackReply> replies) {
        List<FeedbackReplyResponse> replyResponses = replies.stream()
                .map(this::toReplyResponse)
                .toList();

        return new FeedbackDetailResponse(
                feedback.getId().value(),
                feedback.getUserId().value(),
                feedback.getFeedbackType(),
                feedback.getTitle(),
                feedback.getContent(),
                feedback.getAttachment(),
                feedback.getStatus().getCode(),
                feedback.getStatus().getDescription(),
                feedback.getAdminId() != null ? feedback.getAdminId().value() : null,
                feedback.getProcessTime(),
                feedback.getCreateTime(),
                feedback.getUpdateTime(),
                replyResponses
        );
    }

    /**
     * 转换为分页响应
     */
    public FeedbackPageResponse toPageResponse(FeedbackPage page) {
        List<FeedbackResponse> feedbacks = page.feedbacks().stream()
                .map(this::toResponse)
                .toList();

        return new FeedbackPageResponse(
                feedbacks,
                page.total(),
                page.pageNum(),
                page.pageSize(),
                page.getTotalPages()
        );
    }
}
