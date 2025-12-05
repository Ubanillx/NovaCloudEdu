package com.novacloudedu.backend.announcement;

import com.novacloudedu.backend.domain.announcement.entity.Announcement;
import com.novacloudedu.backend.domain.announcement.entity.AnnouncementRead;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementId;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementStatus;
import org.junit.jupiter.api.*;

import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 公告领域实体单元测试
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class AnnouncementEntityTest {

    private static final Long ADMIN_ID = 1L;

    // ==================== Announcement 实体测试 ====================

    @Test
    @Order(1)
    @DisplayName("创建公告 - 成功")
    void createAnnouncement_Success() {
        Announcement announcement = Announcement.create(
                "测试公告标题",
                "测试公告内容",
                10,
                LocalDateTime.now(),
                LocalDateTime.now().plusDays(7),
                "http://example.com/cover.jpg",
                ADMIN_ID
        );

        assertNotNull(announcement);
        assertEquals("测试公告标题", announcement.getTitle());
        assertEquals("测试公告内容", announcement.getContent());
        assertEquals(10, announcement.getSort());
        assertEquals(AnnouncementStatus.DRAFT, announcement.getStatus());
        assertEquals(ADMIN_ID, announcement.getAdminId());
        assertEquals(0, announcement.getViewCount());
        assertNotNull(announcement.getCreateTime());
    }

    @Test
    @Order(2)
    @DisplayName("创建公告 - 标题为空抛异常")
    void createAnnouncement_EmptyTitle_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> 
            Announcement.create("", "内容", null, null, null, null, ADMIN_ID)
        );
        
        assertThrows(IllegalArgumentException.class, () -> 
            Announcement.create(null, "内容", null, null, null, null, ADMIN_ID)
        );
    }

    @Test
    @Order(3)
    @DisplayName("创建公告 - 内容为空抛异常")
    void createAnnouncement_EmptyContent_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> 
            Announcement.create("标题", "", null, null, null, null, ADMIN_ID)
        );
    }

    @Test
    @Order(4)
    @DisplayName("更新公告信息")
    void updateAnnouncement_Success() {
        Announcement announcement = Announcement.create(
                "原标题", "原内容", 0, null, null, null, ADMIN_ID
        );

        announcement.update(
                "新标题",
                "新内容",
                20,
                LocalDateTime.now(),
                LocalDateTime.now().plusDays(30),
                "http://new-cover.jpg"
        );

        assertEquals("新标题", announcement.getTitle());
        assertEquals("新内容", announcement.getContent());
        assertEquals(20, announcement.getSort());
        assertNotNull(announcement.getStartTime());
        assertNotNull(announcement.getEndTime());
    }

    @Test
    @Order(5)
    @DisplayName("发布公告")
    void publishAnnouncement_Success() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0, null, null, null, ADMIN_ID
        );

        assertEquals(AnnouncementStatus.DRAFT, announcement.getStatus());

        announcement.publish();

        assertEquals(AnnouncementStatus.PUBLISHED, announcement.getStatus());
    }

    @Test
    @Order(6)
    @DisplayName("发布公告 - 已发布再发布抛异常")
    void publishAnnouncement_AlreadyPublished_ThrowsException() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0, null, null, null, ADMIN_ID
        );
        announcement.publish();

        assertThrows(IllegalStateException.class, announcement::publish);
    }

    @Test
    @Order(7)
    @DisplayName("下线公告")
    void offlineAnnouncement_Success() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0, null, null, null, ADMIN_ID
        );
        announcement.publish();
        announcement.offline();

        assertEquals(AnnouncementStatus.OFFLINE, announcement.getStatus());
    }

    @Test
    @Order(8)
    @DisplayName("检查公告是否在展示时间内 - 无时间限制")
    void isInDisplayPeriod_NoTimeLimit() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0, null, null, null, ADMIN_ID
        );
        announcement.publish();

        assertTrue(announcement.isInDisplayPeriod());
    }

    @Test
    @Order(9)
    @DisplayName("检查公告是否在展示时间内 - 在时间范围内")
    void isInDisplayPeriod_WithinTimeRange() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0,
                LocalDateTime.now().minusDays(1),
                LocalDateTime.now().plusDays(1),
                null, ADMIN_ID
        );
        announcement.publish();

        assertTrue(announcement.isInDisplayPeriod());
    }

    @Test
    @Order(10)
    @DisplayName("检查公告是否在展示时间内 - 未到开始时间")
    void isInDisplayPeriod_BeforeStartTime() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0,
                LocalDateTime.now().plusDays(1),
                LocalDateTime.now().plusDays(7),
                null, ADMIN_ID
        );
        announcement.publish();

        assertFalse(announcement.isInDisplayPeriod());
    }

    @Test
    @Order(11)
    @DisplayName("检查公告是否在展示时间内 - 已过结束时间")
    void isInDisplayPeriod_AfterEndTime() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0,
                LocalDateTime.now().minusDays(7),
                LocalDateTime.now().minusDays(1),
                null, ADMIN_ID
        );
        announcement.publish();

        assertFalse(announcement.isInDisplayPeriod());
    }

    @Test
    @Order(12)
    @DisplayName("检查公告是否在展示时间内 - 草稿状态")
    void isInDisplayPeriod_DraftStatus() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0, null, null, null, ADMIN_ID
        );

        assertFalse(announcement.isInDisplayPeriod());
    }

    @Test
    @Order(13)
    @DisplayName("增加浏览量")
    void incrementViewCount() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0, null, null, null, ADMIN_ID
        );

        assertEquals(0, announcement.getViewCount());
        announcement.incrementViewCount();
        assertEquals(1, announcement.getViewCount());
        announcement.incrementViewCount();
        assertEquals(2, announcement.getViewCount());
    }

    @Test
    @Order(14)
    @DisplayName("分配ID - 成功")
    void assignId_Success() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0, null, null, null, ADMIN_ID
        );

        assertNull(announcement.getId());
        announcement.assignId(AnnouncementId.of(100L));
        assertEquals(100L, announcement.getId().value());
    }

    @Test
    @Order(15)
    @DisplayName("分配ID - 重复分配抛异常")
    void assignId_AlreadyAssigned_ThrowsException() {
        Announcement announcement = Announcement.create(
                "标题", "内容", 0, null, null, null, ADMIN_ID
        );
        announcement.assignId(AnnouncementId.of(100L));

        assertThrows(IllegalStateException.class, () -> 
            announcement.assignId(AnnouncementId.of(200L))
        );
    }

    // ==================== AnnouncementRead 实体测试 ====================

    @Test
    @Order(16)
    @DisplayName("创建阅读记录 - 成功")
    void createAnnouncementRead_Success() {
        AnnouncementRead read = AnnouncementRead.create(1L, 100L);

        assertNotNull(read);
        assertEquals(1L, read.getAnnouncementId());
        assertEquals(100L, read.getUserId());
        assertNotNull(read.getCreateTime());
    }

    @Test
    @Order(17)
    @DisplayName("创建阅读记录 - 公告ID为空抛异常")
    void createAnnouncementRead_NullAnnouncementId_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> 
            AnnouncementRead.create(null, 100L)
        );
    }

    @Test
    @Order(18)
    @DisplayName("创建阅读记录 - 用户ID为空抛异常")
    void createAnnouncementRead_NullUserId_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> 
            AnnouncementRead.create(1L, null)
        );
    }

    // ==================== AnnouncementStatus 值对象测试 ====================

    @Test
    @Order(19)
    @DisplayName("公告状态 - 从代码转换")
    void announcementStatus_FromCode() {
        assertEquals(AnnouncementStatus.DRAFT, AnnouncementStatus.fromCode(0));
        assertEquals(AnnouncementStatus.PUBLISHED, AnnouncementStatus.fromCode(1));
        assertEquals(AnnouncementStatus.OFFLINE, AnnouncementStatus.fromCode(2));
    }

    @Test
    @Order(20)
    @DisplayName("公告状态 - 无效代码抛异常")
    void announcementStatus_InvalidCode_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> 
            AnnouncementStatus.fromCode(99)
        );
    }

    // ==================== AnnouncementId 值对象测试 ====================

    @Test
    @Order(21)
    @DisplayName("公告ID - 创建成功")
    void announcementId_CreateSuccess() {
        AnnouncementId id = AnnouncementId.of(1L);
        assertEquals(1L, id.value());
    }

    @Test
    @Order(22)
    @DisplayName("公告ID - 无效值抛异常")
    void announcementId_InvalidValue_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> AnnouncementId.of(null));
        assertThrows(IllegalArgumentException.class, () -> AnnouncementId.of(0L));
        assertThrows(IllegalArgumentException.class, () -> AnnouncementId.of(-1L));
    }
}
