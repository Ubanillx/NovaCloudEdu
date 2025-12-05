package com.novacloudedu.backend.application.social.query;

/**
 * 聊天历史查询
 */
public record ChatHistoryQuery(
        Long userId,
        Long partnerId,
        int page,
        int size
) {
    public ChatHistoryQuery {
        if (page < 1) page = 1;
        if (size < 1) size = 20;
        if (size > 100) size = 100;
    }
}
