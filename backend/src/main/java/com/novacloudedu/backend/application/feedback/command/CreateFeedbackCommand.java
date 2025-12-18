package com.novacloudedu.backend.application.feedback.command;

/**
 * 创建反馈命令
 */
public record CreateFeedbackCommand(
        String feedbackType,
        String title,
        String content,
        String attachment
) {
}
