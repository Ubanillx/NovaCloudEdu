package com.novacloudedu.backend.application.exam.command;

import java.util.List;

/**
 * 创建题目命令
 */
public record CreateQuestionCommand(
        String type,
        String subject,
        String grade,
        Integer difficulty,
        String content,
        String options,
        String answer,
        String explanation,
        List<String> knowledgeTags,
        String imageUrl,
        String source
) {
}
