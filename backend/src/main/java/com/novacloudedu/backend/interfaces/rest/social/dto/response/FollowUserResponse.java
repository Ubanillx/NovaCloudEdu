package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import com.novacloudedu.backend.domain.social.entity.UserFollow;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 关注用户响应
 */
@Data
@Builder
@Schema(description = "关注用户响应")
public class FollowUserResponse {

    @Schema(description = "用户ID")
    private Long userId;

    @Schema(description = "关注时间")
    private LocalDateTime followTime;

    public static FollowUserResponse fromFollowing(UserFollow follow) {
        return FollowUserResponse.builder()
                .userId(follow.getFollowingId().value())
                .followTime(follow.getCreateTime())
                .build();
    }

    public static FollowUserResponse fromFollower(UserFollow follow) {
        return FollowUserResponse.builder()
                .userId(follow.getFollowerId().value())
                .followTime(follow.getCreateTime())
                .build();
    }
}
