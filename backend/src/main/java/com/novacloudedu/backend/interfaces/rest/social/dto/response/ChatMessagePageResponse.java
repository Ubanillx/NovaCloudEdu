package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import com.novacloudedu.backend.interfaces.websocket.dto.ChatMessageResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 聊天消息分页响应 DTO
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatMessagePageResponse {

    /**
     * 消息列表
     */
    private List<ChatMessageResponse> messages;

    /**
     * 总记录数
     */
    private long total;

    /**
     * 当前页
     */
    private int page;

    /**
     * 每页大小
     */
    private int size;

    /**
     * 总页数
     */
    private int totalPages;

    /**
     * 是否有更多
     */
    private boolean hasMore;
}
