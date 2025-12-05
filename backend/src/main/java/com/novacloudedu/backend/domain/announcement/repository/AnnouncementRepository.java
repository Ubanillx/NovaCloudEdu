package com.novacloudedu.backend.domain.announcement.repository;

import com.novacloudedu.backend.domain.announcement.entity.Announcement;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementId;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementStatus;

import java.util.List;
import java.util.Optional;

/**
 * 公告仓储接口
 */
public interface AnnouncementRepository {

    /**
     * 保存公告
     */
    Announcement save(Announcement announcement);

    /**
     * 根据ID查找
     */
    Optional<Announcement> findById(AnnouncementId id);

    /**
     * 删除公告（逻辑删除）
     */
    void delete(AnnouncementId id);

    /**
     * 分页查询（管理员）
     */
    AnnouncementPage findByCondition(AnnouncementQueryCondition condition);

    /**
     * 查询用户可见的公告列表（已发布且在展示时间内）
     */
    AnnouncementPage findVisibleAnnouncements(int pageNum, int pageSize);

    /**
     * 增加浏览量
     */
    void incrementViewCount(AnnouncementId id);

    /**
     * 查询条件
     */
    record AnnouncementQueryCondition(
            String title,
            AnnouncementStatus status,
            Long adminId,
            int pageNum,
            int pageSize
    ) {
        public static AnnouncementQueryCondition of(String title, AnnouncementStatus status,
                                                     Long adminId, int pageNum, int pageSize) {
            return new AnnouncementQueryCondition(title, status, adminId,
                    Math.max(1, pageNum), Math.max(1, Math.min(100, pageSize)));
        }
    }

    /**
     * 分页结果
     */
    record AnnouncementPage(List<Announcement> announcements, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
