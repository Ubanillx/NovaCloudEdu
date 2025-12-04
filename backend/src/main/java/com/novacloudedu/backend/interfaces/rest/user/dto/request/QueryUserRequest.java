package com.novacloudedu.backend.interfaces.rest.user.dto.request;

/**
 * 查询用户请求
 */
public record QueryUserRequest(
        String userName,
        String userAccount,
        String userPhone,
        String userEmail,
        String role,
        Boolean banned,
        Integer pageNum,
        Integer pageSize
) {
    public int getPageNum() {
        return pageNum != null ? pageNum : 1;
    }

    public int getPageSize() {
        return pageSize != null ? pageSize : 10;
    }
}
