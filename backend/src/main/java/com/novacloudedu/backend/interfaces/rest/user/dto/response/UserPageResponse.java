package com.novacloudedu.backend.interfaces.rest.user.dto.response;

import java.util.List;

/**
 * 用户分页响应
 */
public record UserPageResponse(
        List<UserDetailResponse> users,
        long total,
        int pageNum,
        int pageSize,
        int totalPages
) {
}
