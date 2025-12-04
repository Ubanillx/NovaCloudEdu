package com.novacloudedu.backend.interfaces.rest.user.dto.request;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.util.List;

/**
 * 批量封禁/解封用户请求
 */
public record BatchBanUserRequest(
        @NotEmpty(message = "用户ID列表不能为空")
        List<Long> userIds,

        @NotNull(message = "封禁状态不能为空")
        Boolean banned
) {
}
