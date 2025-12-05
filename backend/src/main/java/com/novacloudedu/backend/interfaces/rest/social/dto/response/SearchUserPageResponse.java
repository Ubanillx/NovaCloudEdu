package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

/**
 * 搜索用户分页响应
 */
@Schema(description = "搜索用户分页响应")
public record SearchUserPageResponse(
        @Schema(description = "用户列表")
        List<SearchUserResponse> records,

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
