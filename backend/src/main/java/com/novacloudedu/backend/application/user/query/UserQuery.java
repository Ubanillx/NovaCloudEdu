package com.novacloudedu.backend.application.user.query;

/**
 * 用户查询命令
 */
public record UserQuery(
        String userName,
        String userAccount,
        String userPhone,
        String userEmail,
        String role,
        Boolean banned,
        int pageNum,
        int pageSize
) {
    public UserQuery {
        pageNum = Math.max(1, pageNum);
        pageSize = Math.max(1, Math.min(100, pageSize));
    }
}
