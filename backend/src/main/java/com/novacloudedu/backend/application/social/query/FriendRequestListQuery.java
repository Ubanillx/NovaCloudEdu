package com.novacloudedu.backend.application.social.query;

/**
 * 好友申请列表查询
 */
public record FriendRequestListQuery(
        String status,
        int pageNum,
        int pageSize
) {
    public static FriendRequestListQuery of(String status, int pageNum, int pageSize) {
        return new FriendRequestListQuery(
                status,
                Math.max(1, pageNum),
                Math.max(1, Math.min(50, pageSize))
        );
    }
}
