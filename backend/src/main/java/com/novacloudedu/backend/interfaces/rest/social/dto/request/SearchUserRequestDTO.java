package com.novacloudedu.backend.interfaces.rest.social.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 搜索用户请求
 */
@Schema(description = "搜索用户请求")
public record SearchUserRequestDTO(
        @Schema(description = "搜索关键词（用户名或账号）")
        String keyword,

        @Schema(description = "页码", defaultValue = "1")
        Integer pageNum,

        @Schema(description = "每页数量", defaultValue = "10")
        Integer pageSize
) {
    public int getPageNum() {
        return pageNum != null && pageNum > 0 ? pageNum : 1;
    }

    public int getPageSize() {
        return pageSize != null && pageSize > 0 ? Math.min(pageSize, 50) : 10;
    }
}
