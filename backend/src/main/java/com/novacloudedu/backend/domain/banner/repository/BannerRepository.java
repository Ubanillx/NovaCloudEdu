package com.novacloudedu.backend.domain.banner.repository;

import com.novacloudedu.backend.domain.banner.entity.Banner;
import com.novacloudedu.backend.domain.banner.valueobject.BannerId;
import com.novacloudedu.backend.domain.banner.valueobject.BannerStatus;

import java.util.List;
import java.util.Optional;

/**
 * 轮播图仓储接口
 */
public interface BannerRepository {

    /**
     * 保存轮播图
     */
    Banner save(Banner banner);

    /**
     * 根据ID查找
     */
    Optional<Banner> findById(BannerId id);

    /**
     * 删除轮播图（逻辑删除）
     */
    void delete(BannerId id);

    /**
     * 分页查询（管理员）
     */
    BannerPage findByCondition(BannerQueryCondition condition);

    /**
     * 查询用户可见的轮播图列表（已发布且在展示时间内）
     */
    List<Banner> findVisibleBanners();

    /**
     * 查询条件
     */
    record BannerQueryCondition(
            String title,
            BannerStatus status,
            Long adminId,
            int pageNum,
            int pageSize
    ) {
        public static BannerQueryCondition of(String title, BannerStatus status,
                                               Long adminId, int pageNum, int pageSize) {
            return new BannerQueryCondition(title, status, adminId,
                    Math.max(1, pageNum), Math.max(1, Math.min(100, pageSize)));
        }
    }

    /**
     * 分页结果
     */
    record BannerPage(List<Banner> banners, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
