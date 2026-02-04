package com.novacloudedu.backend.domain.banner.entity;

import com.novacloudedu.backend.domain.banner.valueobject.BannerId;
import com.novacloudedu.backend.domain.banner.valueobject.BannerStatus;
import com.novacloudedu.backend.domain.banner.valueobject.LinkType;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 轮播图聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Banner {

    private BannerId id;
    private String title;
    private String imageUrl;
    private LinkType linkType;
    private String linkUrl;
    private Integer sort;
    private BannerStatus status;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Long adminId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新轮播图（草稿状态）
     */
    public static Banner create(String title, String imageUrl, LinkType linkType,
                                 String linkUrl, Integer sort,
                                 LocalDateTime startTime, LocalDateTime endTime,
                                 Long adminId) {
        validateTitle(title);
        validateImageUrl(imageUrl);
        validateLink(linkType, linkUrl);

        Banner banner = new Banner();
        banner.title = title;
        banner.imageUrl = imageUrl;
        banner.linkType = linkType != null ? linkType : LinkType.NONE;
        banner.linkUrl = linkUrl;
        banner.sort = sort != null ? sort : 0;
        banner.status = BannerStatus.DRAFT;
        banner.startTime = startTime;
        banner.endTime = endTime;
        banner.adminId = adminId;
        banner.createTime = LocalDateTime.now();
        banner.updateTime = LocalDateTime.now();
        return banner;
    }

    /**
     * 从持久化数据重建
     */
    public static Banner reconstruct(BannerId id, String title, String imageUrl,
                                      LinkType linkType, String linkUrl, Integer sort,
                                      BannerStatus status, LocalDateTime startTime,
                                      LocalDateTime endTime, Long adminId,
                                      LocalDateTime createTime, LocalDateTime updateTime) {
        Banner banner = new Banner();
        banner.id = id;
        banner.title = title;
        banner.imageUrl = imageUrl;
        banner.linkType = linkType;
        banner.linkUrl = linkUrl;
        banner.sort = sort;
        banner.status = status;
        banner.startTime = startTime;
        banner.endTime = endTime;
        banner.adminId = adminId;
        banner.createTime = createTime;
        banner.updateTime = updateTime;
        return banner;
    }

    /**
     * 分配ID
     */
    public void assignId(BannerId id) {
        if (this.id != null) {
            throw new IllegalStateException("轮播图ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 更新轮播图信息
     */
    public void update(String title, String imageUrl, LinkType linkType,
                       String linkUrl, Integer sort,
                       LocalDateTime startTime, LocalDateTime endTime) {
        validateTitle(title);
        validateImageUrl(imageUrl);
        validateLink(linkType, linkUrl);

        this.title = title;
        this.imageUrl = imageUrl;
        this.linkType = linkType != null ? linkType : LinkType.NONE;
        this.linkUrl = linkUrl;
        this.sort = sort != null ? sort : this.sort;
        this.startTime = startTime;
        this.endTime = endTime;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 发布轮播图
     */
    public void publish() {
        if (this.status == BannerStatus.PUBLISHED) {
            throw new IllegalStateException("轮播图已发布");
        }
        this.status = BannerStatus.PUBLISHED;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 下线轮播图
     */
    public void offline() {
        if (this.status == BannerStatus.OFFLINE) {
            throw new IllegalStateException("轮播图已下线");
        }
        this.status = BannerStatus.OFFLINE;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 设置为草稿
     */
    public void setDraft() {
        this.status = BannerStatus.DRAFT;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新状态
     */
    public void updateStatus(BannerStatus newStatus) {
        this.status = newStatus;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 检查轮播图是否在有效展示时间内
     */
    public boolean isInDisplayPeriod() {
        if (status != BannerStatus.PUBLISHED) {
            return false;
        }
        LocalDateTime now = LocalDateTime.now();
        boolean afterStart = startTime == null || !now.isBefore(startTime);
        boolean beforeEnd = endTime == null || !now.isAfter(endTime);
        return afterStart && beforeEnd;
    }

    private static void validateTitle(String title) {
        if (title == null || title.isBlank()) {
            throw new IllegalArgumentException("轮播图标题不能为空");
        }
        if (title.length() > 128) {
            throw new IllegalArgumentException("轮播图标题不能超过128个字符");
        }
    }

    private static void validateImageUrl(String imageUrl) {
        if (imageUrl == null || imageUrl.isBlank()) {
            throw new IllegalArgumentException("轮播图图片URL不能为空");
        }
    }

    private static void validateLink(LinkType linkType, String linkUrl) {
        if (linkType != null && linkType != LinkType.NONE) {
            if (linkUrl == null || linkUrl.isBlank()) {
                throw new IllegalArgumentException("跳转类型非空时，跳转URL不能为空");
            }
        }
    }
}
