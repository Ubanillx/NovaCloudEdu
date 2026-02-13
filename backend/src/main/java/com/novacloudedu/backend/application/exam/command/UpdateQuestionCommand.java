package com.novacloudedu.backend.application.exam.command;

import java.util.List;

/**
 * 更新题目命令
 */
public record UpdateQuestionCommand(
        Long id,
        String type,
        String subject,
        String grade,
        Integer difficulty,
        String content,
        String options,
        String answer,
        String explanation,
        List<String> knowledgeTags,
        String imageUrl
) {
}
