package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import com.novacloudedu.backend.application.service.UserFollowApplicationService;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

/**
 * 关注统计响应
 */
@Data
@Builder
@Schema(description = "关注统计响应")
public class FollowStatsResponse {

    @Schema(description = "关注数")
    private Long followingCount;

    @Schema(description = "粉丝数")
    private Long followerCount;

    public static FollowStatsResponse from(UserFollowApplicationService.FollowStats stats) {
        return FollowStatsResponse.builder()
                .followingCount(stats.followingCount())
                .followerCount(stats.followerCount())
                .build();
    }
}
