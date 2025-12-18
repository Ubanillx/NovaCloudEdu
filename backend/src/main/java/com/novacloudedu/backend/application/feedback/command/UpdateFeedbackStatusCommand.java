package com.novacloudedu.backend.application.feedback.command;

/**
 * 更新反馈状态命令
 */
public record UpdateFeedbackStatusCommand(
        Long feedbackId,
        Integer status
) {
}
