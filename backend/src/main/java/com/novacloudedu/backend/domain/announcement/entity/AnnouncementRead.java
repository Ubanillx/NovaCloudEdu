package com.novacloudedu.backend.domain.announcement.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 公告阅读记录实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AnnouncementRead {

    private Long id;
    private Long announcementId;
    private Long userId;
    private LocalDateTime createTime;

    /**
     * 创建阅读记录
     */
    public static AnnouncementRead create(Long announcementId, Long userId) {
        if (announcementId == null || announcementId <= 0) {
            throw new IllegalArgumentException("公告ID不能为空");
        }
        if (userId == null || userId <= 0) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        
        AnnouncementRead read = new AnnouncementRead();
        read.announcementId = announcementId;
        read.userId = userId;
        read.createTime = LocalDateTime.now();
        return read;
    }

    /**
     * 从持久化数据重建
     */
    public static AnnouncementRead reconstruct(Long id, Long announcementId, 
                                               Long userId, LocalDateTime createTime) {
        AnnouncementRead read = new AnnouncementRead();
        read.id = id;
        read.announcementId = announcementId;
        read.userId = userId;
        read.createTime = createTime;
        return read;
    }

    /**
     * 分配ID
     */
    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("阅读记录ID已分配");
        }
        this.id = id;
    }
}
