package com.novacloudedu.backend.application.social.query;

/**
 * 好友列表查询
 */
public record FriendListQuery(
        int pageNum,
        int pageSize
) {
    public static FriendListQuery of(int pageNum, int pageSize) {
        return new FriendListQuery(
                Math.max(1, pageNum),
                Math.max(1, Math.min(50, pageSize))
        );
    }
}
