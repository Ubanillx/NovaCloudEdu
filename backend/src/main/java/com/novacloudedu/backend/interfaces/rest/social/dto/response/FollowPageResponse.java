package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import com.novacloudedu.backend.domain.social.repository.UserFollowRepository;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.util.List;

/**
 * 关注分页响应
 */
@Data
@Builder
@Schema(description = "关注分页响应")
public class FollowPageResponse {

    @Schema(description = "用户列表")
    private List<FollowUserResponse> users;

    @Schema(description = "总数")
    private Long total;

    @Schema(description = "当前页码")
    private Integer pageNum;

    @Schema(description = "每页数量")
    private Integer pageSize;

    @Schema(description = "总页数")
    private Integer totalPages;

    public static FollowPageResponse from(UserFollowRepository.FollowPage page, boolean isFollowing) {
        List<FollowUserResponse> users = page.follows().stream()
                .map(follow -> isFollowing 
                        ? FollowUserResponse.fromFollowing(follow) 
                        : FollowUserResponse.fromFollower(follow))
                .toList();

        return FollowPageResponse.builder()
                .users(users)
                .total(page.total())
                .pageNum(page.pageNum())
                .pageSize(page.pageSize())
                .totalPages(page.getTotalPages())
                .build();
    }
}
