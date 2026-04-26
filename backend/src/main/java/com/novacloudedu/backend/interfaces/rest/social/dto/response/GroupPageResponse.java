package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import com.novacloudedu.backend.domain.social.repository.ChatGroupRepository;
import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

/**
 * 群聊搜索分页响应
 */
@Schema(description = "群聊搜索分页响应")
public record GroupPageResponse(
        @Schema(description = "群聊列表")
        List<GroupResponse> groups,

        @Schema(description = "总数")
        long total,

        @Schema(description = "当前页码")
        int pageNum,

        @Schema(description = "每页数量")
        int pageSize,

        @Schema(description = "总页数")
        int totalPages
) {
    public static GroupPageResponse from(ChatGroupRepository.GroupPage page) {
        return new GroupPageResponse(
                page.groups().stream().map(GroupResponse::from).toList(),
                page.total(),
                page.pageNum(),
                page.pageSize(),
                page.getTotalPages()
        );
    }
}
