package com.novacloudedu.backend.interfaces.rest.social.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 好友列表请求
 */
@Schema(description = "好友列表请求")
public record FriendListRequestDTO(
        @Schema(description = "页码", defaultValue = "1")
        Integer pageNum,

        @Schema(description = "每页数量", defaultValue = "20")
        Integer pageSize
) {
    public int getPageNum() {
        return pageNum != null && pageNum > 0 ? pageNum : 1;
    }

    public int getPageSize() {
        return pageSize != null && pageSize > 0 ? Math.min(pageSize, 50) : 20;
    }
}
