package com.novacloudedu.backend.domain.announcement.repository;

import com.novacloudedu.backend.domain.announcement.entity.AnnouncementRead;

import java.util.List;
import java.util.Optional;

/**
 * 公告阅读记录仓储接口
 */
public interface AnnouncementReadRepository {

    /**
     * 保存阅读记录
     */
    AnnouncementRead save(AnnouncementRead read);

    /**
     * 查找用户对某公告的阅读记录
     */
    Optional<AnnouncementRead> findByAnnouncementIdAndUserId(Long announcementId, Long userId);

    /**
     * 检查用户是否已读某公告
     */
    boolean existsByAnnouncementIdAndUserId(Long announcementId, Long userId);

    /**
     * 获取用户已读的公告ID列表
     */
    List<Long> findReadAnnouncementIdsByUserId(Long userId);

    /**
     * 统计公告的阅读人数
     */
    long countByAnnouncementId(Long announcementId);

    /**
     * 批量检查用户是否已读
     */
    List<Long> findReadAnnouncementIds(Long userId, List<Long> announcementIds);
}
