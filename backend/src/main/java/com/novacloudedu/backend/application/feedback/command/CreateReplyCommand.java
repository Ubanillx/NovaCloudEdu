package com.novacloudedu.backend.application.feedback.command;

/**
 * 创建回复命令
 */
public record CreateReplyCommand(
        Long feedbackId,
        String content,
        String attachment
) {
}
