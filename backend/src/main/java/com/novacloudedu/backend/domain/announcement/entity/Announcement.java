package com.novacloudedu.backend.domain.announcement.entity;

import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementId;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementStatus;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 公告聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Announcement {

    private AnnouncementId id;
    private String title;
    private String content;
    private Integer sort;
    private AnnouncementStatus status;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String coverImage;
    private Long adminId;
    private Integer viewCount;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新公告（草稿状态）
     */
    public static Announcement create(String title, String content, Integer sort,
                                       LocalDateTime startTime, LocalDateTime endTime,
                                       String coverImage, Long adminId) {
        validateTitle(title);
        validateContent(content);
        
        Announcement announcement = new Announcement();
        announcement.title = title;
        announcement.content = content;
        announcement.sort = sort != null ? sort : 0;
        announcement.status = AnnouncementStatus.DRAFT;
        announcement.startTime = startTime;
        announcement.endTime = endTime;
        announcement.coverImage = coverImage;
        announcement.adminId = adminId;
        announcement.viewCount = 0;
        announcement.createTime = LocalDateTime.now();
        announcement.updateTime = LocalDateTime.now();
        return announcement;
    }

    /**
     * 从持久化数据重建
     */
    public static Announcement reconstruct(AnnouncementId id, String title, String content,
                                           Integer sort, AnnouncementStatus status,
                                           LocalDateTime startTime, LocalDateTime endTime,
                                           String coverImage, Long adminId, Integer viewCount,
                                           LocalDateTime createTime, LocalDateTime updateTime) {
        Announcement announcement = new Announcement();
        announcement.id = id;
        announcement.title = title;
        announcement.content = content;
        announcement.sort = sort;
        announcement.status = status;
        announcement.startTime = startTime;
        announcement.endTime = endTime;
        announcement.coverImage = coverImage;
        announcement.adminId = adminId;
        announcement.viewCount = viewCount;
        announcement.createTime = createTime;
        announcement.updateTime = updateTime;
        return announcement;
    }

    /**
     * 分配ID
     */
    public void assignId(AnnouncementId id) {
        if (this.id != null) {
            throw new IllegalStateException("公告ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 更新公告信息
     */
    public void update(String title, String content, Integer sort,
                       LocalDateTime startTime, LocalDateTime endTime, String coverImage) {
        validateTitle(title);
        validateContent(content);
        
        this.title = title;
        this.content = content;
        this.sort = sort != null ? sort : this.sort;
        this.startTime = startTime;
        this.endTime = endTime;
        this.coverImage = coverImage;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 发布公告
     */
    public void publish() {
        if (this.status == AnnouncementStatus.PUBLISHED) {
            throw new IllegalStateException("公告已发布");
        }
        this.status = AnnouncementStatus.PUBLISHED;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 下线公告
     */
    public void offline() {
        if (this.status == AnnouncementStatus.OFFLINE) {
            throw new IllegalStateException("公告已下线");
        }
        this.status = AnnouncementStatus.OFFLINE;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 设置为草稿
     */
    public void setDraft() {
        this.status = AnnouncementStatus.DRAFT;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新状态
     */
    public void updateStatus(AnnouncementStatus newStatus) {
        this.status = newStatus;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 增加浏览量
     */
    public void incrementViewCount() {
        this.viewCount = this.viewCount + 1;
    }

    /**
     * 检查公告是否在有效展示时间内
     */
    public boolean isInDisplayPeriod() {
        if (status != AnnouncementStatus.PUBLISHED) {
            return false;
        }
        LocalDateTime now = LocalDateTime.now();
        boolean afterStart = startTime == null || !now.isBefore(startTime);
        boolean beforeEnd = endTime == null || !now.isAfter(endTime);
        return afterStart && beforeEnd;
    }

    private static void validateTitle(String title) {
        if (title == null || title.isBlank()) {
            throw new IllegalArgumentException("公告标题不能为空");
        }
        if (title.length() > 256) {
            throw new IllegalArgumentException("公告标题不能超过256个字符");
        }
    }

    private static void validateContent(String content) {
        if (content == null || content.isBlank()) {
            throw new IllegalArgumentException("公告内容不能为空");
        }
    }
}
