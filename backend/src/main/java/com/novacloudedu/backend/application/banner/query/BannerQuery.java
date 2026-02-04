package com.novacloudedu.backend.application.banner.query;

/**
 * 轮播图查询条件
 */
public record BannerQuery(
        String title,
        Integer status,
        Long adminId,
        int pageNum,
        int pageSize
) {
    public static BannerQuery of(String title, Integer status, Long adminId, int pageNum, int pageSize) {
        return new BannerQuery(title, status, adminId, 
                Math.max(1, pageNum), Math.max(1, Math.min(100, pageSize)));
    }
}
