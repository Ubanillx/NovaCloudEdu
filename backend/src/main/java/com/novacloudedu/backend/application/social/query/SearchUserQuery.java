package com.novacloudedu.backend.application.social.query;

/**
 * 搜索用户查询
 */
public record SearchUserQuery(
        String keyword,
        int pageNum,
        int pageSize
) {
    public static SearchUserQuery of(String keyword, int pageNum, int pageSize) {
        return new SearchUserQuery(
                keyword,
                Math.max(1, pageNum),
                Math.max(1, Math.min(50, pageSize))
        );
    }
}
