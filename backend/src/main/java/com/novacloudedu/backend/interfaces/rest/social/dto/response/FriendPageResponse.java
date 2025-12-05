package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

/**
 * 好友列表分页响应
 */
@Schema(description = "好友列表分页响应")
public record FriendPageResponse(
        @Schema(description = "好友列表")
        List<FriendResponse> records,

        @Schema(description = "总数")
        Long total,

        @Schema(description = "当前页码")
        Integer pageNum,

        @Schema(description = "每页数量")
        Integer pageSize,

        @Schema(description = "总页数")
        Integer totalPages
) {
}
