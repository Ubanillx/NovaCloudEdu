package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.feedback.command.CreateFeedbackCommand;
import com.novacloudedu.backend.application.feedback.command.CreateReplyCommand;
import com.novacloudedu.backend.application.feedback.command.UpdateFeedbackStatusCommand;
import com.novacloudedu.backend.application.feedback.query.FeedbackQuery;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.feedback.entity.FeedbackReply;
import com.novacloudedu.backend.domain.feedback.entity.UserFeedback;
import com.novacloudedu.backend.domain.feedback.repository.FeedbackReplyRepository;
import com.novacloudedu.backend.domain.feedback.repository.FeedbackReplyRepository.ReplyPage;
import com.novacloudedu.backend.domain.feedback.repository.UserFeedbackRepository;
import com.novacloudedu.backend.domain.feedback.repository.UserFeedbackRepository.FeedbackPage;
import com.novacloudedu.backend.domain.feedback.repository.UserFeedbackRepository.FeedbackQueryCondition;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackId;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackStatus;
import com.novacloudedu.backend.domain.feedback.valueobject.SenderRole;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 反馈应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class FeedbackApplicationService {

    private final UserFeedbackRepository feedbackRepository;
    private final FeedbackReplyRepository replyRepository;
    private final UserApplicationService userApplicationService;

    // ==================== 用户反馈操作 ====================

    /**
     * 创建反馈（用户）
     */
    @Transactional
    public Long createFeedback(CreateFeedbackCommand command) {
        User currentUser = userApplicationService.getCurrentUser();
        UserId userId = currentUser.getId();

        UserFeedback feedback = UserFeedback.create(
                userId,
                command.feedbackType(),
                command.title(),
                command.content(),
                command.attachment()
        );

        feedbackRepository.save(feedback);
        log.info("用户创建反馈成功: userId={}, feedbackId={}", userId.value(), feedback.getId().value());
        return feedback.getId().value();
    }

    /**
     * 获取当前用户的反馈列表
     */
    @Transactional(readOnly = true)
    public FeedbackPage getMyFeedbacks(int pageNum, int pageSize) {
        User currentUser = userApplicationService.getCurrentUser();
        return feedbackRepository.findByUserId(currentUser.getId(), pageNum, pageSize);
    }

    /**
     * 获取反馈详情（用户）
     */
    @Transactional(readOnly = true)
    public UserFeedback getFeedbackDetail(Long feedbackId) {
        User currentUser = userApplicationService.getCurrentUser();
        UserFeedback feedback = feedbackRepository.findById(FeedbackId.of(feedbackId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));

        // 检查是否为反馈所有者
        if (!feedback.isOwner(currentUser.getId())) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR, "无权查看此反馈");
        }

        return feedback;
    }

    /**
     * 用户回复反馈
     */
    @Transactional
    public Long replyFeedback(CreateReplyCommand command) {
        User currentUser = userApplicationService.getCurrentUser();
        FeedbackId feedbackId = FeedbackId.of(command.feedbackId());

        UserFeedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));

        // 检查是否为反馈所有者
        if (!feedback.isOwner(currentUser.getId())) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR, "无权回复此反馈");
        }

        FeedbackReply reply = FeedbackReply.create(
                feedbackId,
                currentUser.getId(),
                SenderRole.USER,
                command.content(),
                command.attachment()
        );

        replyRepository.save(reply);
        log.info("用户回复反馈成功: feedbackId={}, replyId={}", feedbackId.value(), reply.getId().value());
        return reply.getId().value();
    }

    /**
     * 获取反馈的回复列表（用户）
     */
    @Transactional(readOnly = true)
    public List<FeedbackReply> getFeedbackReplies(Long feedbackId) {
        User currentUser = userApplicationService.getCurrentUser();
        FeedbackId fId = FeedbackId.of(feedbackId);

        UserFeedback feedback = feedbackRepository.findById(fId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));

        // 检查是否为反馈所有者
        if (!feedback.isOwner(currentUser.getId())) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR, "无权查看此反馈的回复");
        }

        return replyRepository.findByFeedbackId(fId);
    }

    /**
     * 标记回复为已读（用户）
     */
    @Transactional
    public void markRepliesAsRead(Long feedbackId) {
        User currentUser = userApplicationService.getCurrentUser();
        FeedbackId fId = FeedbackId.of(feedbackId);

        UserFeedback feedback = feedbackRepository.findById(fId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));

        if (!feedback.isOwner(currentUser.getId())) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR, "无权操作此反馈");
        }

        replyRepository.markAllAsRead(fId, currentUser.getId());
    }

    /**
     * 删除反馈（用户）
     */
    @Transactional
    public void deleteFeedback(Long feedbackId) {
        User currentUser = userApplicationService.getCurrentUser();
        FeedbackId fId = FeedbackId.of(feedbackId);

        UserFeedback feedback = feedbackRepository.findById(fId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));

        if (!feedback.isOwner(currentUser.getId())) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR, "无权删除此反馈");
        }

        // 删除相关回复
        replyRepository.deleteByFeedbackId(fId);
        // 删除反馈
        feedbackRepository.delete(fId);
        log.info("用户删除反馈成功: feedbackId={}", feedbackId);
    }

    // ==================== 管理员操作 ====================

    /**
     * 分页查询反馈（管理员）
     */
    @Transactional(readOnly = true)
    public FeedbackPage queryFeedbacks(FeedbackQuery query) {
        FeedbackStatus status = query.status() != null ? FeedbackStatus.fromCode(query.status()) : null;
        FeedbackQueryCondition condition = FeedbackQueryCondition.of(
                query.userId(),
                query.feedbackType(),
                status,
                query.pageNum(),
                query.pageSize()
        );
        return feedbackRepository.findByCondition(condition);
    }

    /**
     * 获取反馈详情（管理员）
     */
    @Transactional(readOnly = true)
    public UserFeedback getFeedbackDetailAdmin(Long feedbackId) {
        return feedbackRepository.findById(FeedbackId.of(feedbackId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));
    }

    /**
     * 更新反馈状态（管理员）
     */
    @Transactional
    public void updateFeedbackStatus(UpdateFeedbackStatusCommand command) {
        User currentUser = userApplicationService.getCurrentUser();
        FeedbackId feedbackId = FeedbackId.of(command.feedbackId());

        UserFeedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));

        FeedbackStatus newStatus = FeedbackStatus.fromCode(command.status());
        feedback.updateStatus(newStatus, currentUser.getId());

        feedbackRepository.save(feedback);
        log.info("管理员更新反馈状态: feedbackId={}, status={}", feedbackId.value(), newStatus);
    }

    /**
     * 管理员回复反馈
     */
    @Transactional
    public Long replyFeedbackAdmin(CreateReplyCommand command) {
        User currentUser = userApplicationService.getCurrentUser();
        FeedbackId feedbackId = FeedbackId.of(command.feedbackId());

        UserFeedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));

        // 如果是待处理状态，自动更新为处理中
        if (feedback.getStatus() == FeedbackStatus.PENDING) {
            feedback.startProcessing(currentUser.getId());
            feedbackRepository.save(feedback);
        }

        FeedbackReply reply = FeedbackReply.create(
                feedbackId,
                currentUser.getId(),
                SenderRole.ADMIN,
                command.content(),
                command.attachment()
        );

        replyRepository.save(reply);
        log.info("管理员回复反馈成功: feedbackId={}, replyId={}", feedbackId.value(), reply.getId().value());
        return reply.getId().value();
    }

    /**
     * 获取反馈的回复列表（管理员）
     */
    @Transactional(readOnly = true)
    public List<FeedbackReply> getFeedbackRepliesAdmin(Long feedbackId) {
        FeedbackId fId = FeedbackId.of(feedbackId);
        feedbackRepository.findById(fId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));
        return replyRepository.findByFeedbackId(fId);
    }

    /**
     * 获取反馈回复分页列表（管理员）
     */
    @Transactional(readOnly = true)
    public ReplyPage getFeedbackRepliesPagedAdmin(Long feedbackId, int pageNum, int pageSize) {
        FeedbackId fId = FeedbackId.of(feedbackId);
        feedbackRepository.findById(fId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));
        return replyRepository.findByFeedbackIdPaged(fId, pageNum, pageSize);
    }

    /**
     * 删除反馈（管理员）
     */
    @Transactional
    public void deleteFeedbackAdmin(Long feedbackId) {
        FeedbackId fId = FeedbackId.of(feedbackId);

        feedbackRepository.findById(fId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "反馈不存在"));

        // 删除相关回复
        replyRepository.deleteByFeedbackId(fId);
        // 删除反馈
        feedbackRepository.delete(fId);
        log.info("管理员删除反馈成功: feedbackId={}", feedbackId);
    }
}
