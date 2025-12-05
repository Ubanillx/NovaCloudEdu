package com.novacloudedu.backend.announcement;

import com.novacloudedu.backend.application.announcement.command.CreateAnnouncementCommand;
import com.novacloudedu.backend.application.announcement.command.UpdateAnnouncementCommand;
import com.novacloudedu.backend.application.announcement.query.AnnouncementQuery;
import com.novacloudedu.backend.application.service.AnnouncementApplicationService;
import com.novacloudedu.backend.application.service.AnnouncementApplicationService.AnnouncementPageWithReadStatus;
import com.novacloudedu.backend.application.service.UserApplicationService;
import com.novacloudedu.backend.domain.announcement.entity.Announcement;
import com.novacloudedu.backend.domain.announcement.entity.AnnouncementRead;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementReadRepository;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementRepository;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementRepository.AnnouncementPage;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementId;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementStatus;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.exception.BusinessException;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 公告应用服务单元测试
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class AnnouncementApplicationServiceTest {

    @Mock
    private AnnouncementRepository announcementRepository;

    @Mock
    private AnnouncementReadRepository announcementReadRepository;

    @Mock
    private UserApplicationService userApplicationService;

    @InjectMocks
    private AnnouncementApplicationService announcementApplicationService;

    private static final Long ADMIN_ID = 1L;
    private static final Long USER_ID = 100L;
    private static final Long ANNOUNCEMENT_ID = 1L;

    private User mockAdmin;
    private User mockUser;
    private Announcement mockAnnouncement;

    @BeforeEach
    void setUp() {
        // 创建模拟的管理员用户
        mockAdmin = mock(User.class);
        UserId adminUserId = mock(UserId.class);
        when(adminUserId.value()).thenReturn(ADMIN_ID);
        when(mockAdmin.getId()).thenReturn(adminUserId);

        // 创建模拟的普通用户
        mockUser = mock(User.class);
        UserId userId = mock(UserId.class);
        when(userId.value()).thenReturn(USER_ID);
        when(mockUser.getId()).thenReturn(userId);

        // 创建模拟的公告
        mockAnnouncement = Announcement.reconstruct(
                AnnouncementId.of(ANNOUNCEMENT_ID),
                "测试公告",
                "测试内容",
                10,
                AnnouncementStatus.PUBLISHED,
                LocalDateTime.now().minusDays(1),
                LocalDateTime.now().plusDays(7),
                "http://cover.jpg",
                ADMIN_ID,
                100,
                LocalDateTime.now().minusDays(2),
                LocalDateTime.now()
        );
    }

    // ==================== 管理员功能测试 ====================

    @Test
    @Order(1)
    @DisplayName("创建公告 - 成功")
    void createAnnouncement_Success() {
        when(userApplicationService.getCurrentUser()).thenReturn(mockAdmin);
        when(announcementRepository.save(any(Announcement.class))).thenAnswer(invocation -> {
            Announcement ann = invocation.getArgument(0);
            ann.assignId(AnnouncementId.of(ANNOUNCEMENT_ID));
            return ann;
        });

        CreateAnnouncementCommand command = new CreateAnnouncementCommand(
                "新公告标题",
                "新公告内容",
                5,
                LocalDateTime.now(),
                LocalDateTime.now().plusDays(30),
                "http://cover.jpg"
        );

        Long id = announcementApplicationService.createAnnouncement(command);

        assertEquals(ANNOUNCEMENT_ID, id);
        verify(announcementRepository, times(1)).save(any(Announcement.class));
    }

    @Test
    @Order(2)
    @DisplayName("更新公告 - 成功")
    void updateAnnouncement_Success() {
        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.of(mockAnnouncement));
        when(announcementRepository.save(any(Announcement.class))).thenReturn(mockAnnouncement);

        UpdateAnnouncementCommand command = new UpdateAnnouncementCommand(
                ANNOUNCEMENT_ID,
                "更新后的标题",
                "更新后的内容",
                20,
                null,
                null,
                null,
                null
        );

        assertDoesNotThrow(() -> announcementApplicationService.updateAnnouncement(command));
        verify(announcementRepository, times(1)).save(any(Announcement.class));
    }

    @Test
    @Order(3)
    @DisplayName("更新公告 - 公告不存在抛异常")
    void updateAnnouncement_NotFound_ThrowsException() {
        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.empty());

        UpdateAnnouncementCommand command = new UpdateAnnouncementCommand(
                999L, "标题", "内容", null, null, null, null, null
        );

        assertThrows(BusinessException.class, () -> 
            announcementApplicationService.updateAnnouncement(command)
        );
    }

    @Test
    @Order(4)
    @DisplayName("删除公告 - 成功")
    void deleteAnnouncement_Success() {
        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.of(mockAnnouncement));
        doNothing().when(announcementRepository).delete(any(AnnouncementId.class));

        assertDoesNotThrow(() -> announcementApplicationService.deleteAnnouncement(ANNOUNCEMENT_ID));
        verify(announcementRepository, times(1)).delete(any(AnnouncementId.class));
    }

    @Test
    @Order(5)
    @DisplayName("删除公告 - 公告不存在抛异常")
    void deleteAnnouncement_NotFound_ThrowsException() {
        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.empty());

        assertThrows(BusinessException.class, () -> 
            announcementApplicationService.deleteAnnouncement(999L)
        );
    }

    @Test
    @Order(6)
    @DisplayName("发布公告 - 成功")
    void publishAnnouncement_Success() {
        Announcement draftAnnouncement = Announcement.reconstruct(
                AnnouncementId.of(ANNOUNCEMENT_ID),
                "草稿公告", "内容", 0, AnnouncementStatus.DRAFT,
                null, null, null, ADMIN_ID, 0,
                LocalDateTime.now(), LocalDateTime.now()
        );

        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.of(draftAnnouncement));
        when(announcementRepository.save(any(Announcement.class))).thenReturn(draftAnnouncement);

        assertDoesNotThrow(() -> announcementApplicationService.publishAnnouncement(ANNOUNCEMENT_ID));
        verify(announcementRepository, times(1)).save(any(Announcement.class));
    }

    @Test
    @Order(7)
    @DisplayName("下线公告 - 成功")
    void offlineAnnouncement_Success() {
        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.of(mockAnnouncement));
        when(announcementRepository.save(any(Announcement.class))).thenReturn(mockAnnouncement);

        assertDoesNotThrow(() -> announcementApplicationService.offlineAnnouncement(ANNOUNCEMENT_ID));
        verify(announcementRepository, times(1)).save(any(Announcement.class));
    }

    @Test
    @Order(8)
    @DisplayName("获取公告详情（管理员）- 成功")
    void getAnnouncementById_Success() {
        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.of(mockAnnouncement));

        Announcement result = announcementApplicationService.getAnnouncementById(ANNOUNCEMENT_ID);

        assertNotNull(result);
        assertEquals(ANNOUNCEMENT_ID, result.getId().value());
    }

    @Test
    @Order(9)
    @DisplayName("分页查询公告（管理员）- 成功")
    void queryAnnouncements_Success() {
        AnnouncementPage mockPage = new AnnouncementPage(
                List.of(mockAnnouncement),
                1L, 1, 10
        );
        when(announcementRepository.findByCondition(any())).thenReturn(mockPage);

        AnnouncementQuery query = new AnnouncementQuery(null, null, null, 1, 10);
        AnnouncementPage result = announcementApplicationService.queryAnnouncements(query);

        assertNotNull(result);
        assertEquals(1, result.announcements().size());
        assertEquals(1L, result.total());
    }

    @Test
    @Order(10)
    @DisplayName("获取阅读统计")
    void getReadCount_Success() {
        when(announcementReadRepository.countByAnnouncementId(ANNOUNCEMENT_ID)).thenReturn(50L);

        long count = announcementApplicationService.getReadCount(ANNOUNCEMENT_ID);

        assertEquals(50L, count);
    }

    // ==================== 用户功能测试 ====================

    @Test
    @Order(11)
    @DisplayName("获取可见公告列表 - 已登录用户")
    void getVisibleAnnouncements_LoggedIn() {
        AnnouncementPage mockPage = new AnnouncementPage(
                List.of(mockAnnouncement),
                1L, 1, 10
        );
        when(announcementRepository.findVisibleAnnouncements(1, 10)).thenReturn(mockPage);
        when(userApplicationService.getCurrentUser()).thenReturn(mockUser);
        when(announcementReadRepository.findReadAnnouncementIds(eq(USER_ID), anyList()))
                .thenReturn(List.of(ANNOUNCEMENT_ID));

        AnnouncementPageWithReadStatus result = 
                announcementApplicationService.getVisibleAnnouncements(1, 10);

        assertNotNull(result);
        assertEquals(1, result.page().announcements().size());
        assertTrue(result.isRead(ANNOUNCEMENT_ID));
    }

    @Test
    @Order(12)
    @DisplayName("获取可见公告列表 - 未登录用户")
    void getVisibleAnnouncements_NotLoggedIn() {
        AnnouncementPage mockPage = new AnnouncementPage(
                List.of(mockAnnouncement),
                1L, 1, 10
        );
        when(announcementRepository.findVisibleAnnouncements(1, 10)).thenReturn(mockPage);
        when(userApplicationService.getCurrentUser()).thenThrow(new BusinessException(ErrorCode.NOT_LOGIN_ERROR));

        AnnouncementPageWithReadStatus result = 
                announcementApplicationService.getVisibleAnnouncements(1, 10);

        assertNotNull(result);
        assertFalse(result.isRead(ANNOUNCEMENT_ID));
    }

    @Test
    @Order(13)
    @DisplayName("获取公告详情（用户）- 成功")
    void getAnnouncementDetail_Success() {
        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.of(mockAnnouncement));
        doNothing().when(announcementRepository).incrementViewCount(any(AnnouncementId.class));

        Announcement result = announcementApplicationService.getAnnouncementDetail(ANNOUNCEMENT_ID);

        assertNotNull(result);
        verify(announcementRepository, times(1)).incrementViewCount(any(AnnouncementId.class));
    }

    @Test
    @Order(14)
    @DisplayName("获取公告详情（用户）- 公告已过期抛异常")
    void getAnnouncementDetail_Expired_ThrowsException() {
        Announcement expiredAnnouncement = Announcement.reconstruct(
                AnnouncementId.of(ANNOUNCEMENT_ID),
                "过期公告", "内容", 0, AnnouncementStatus.PUBLISHED,
                LocalDateTime.now().minusDays(30),
                LocalDateTime.now().minusDays(1), // 已过期
                null, ADMIN_ID, 0,
                LocalDateTime.now().minusDays(30), LocalDateTime.now()
        );

        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.of(expiredAnnouncement));

        assertThrows(BusinessException.class, () -> 
            announcementApplicationService.getAnnouncementDetail(ANNOUNCEMENT_ID)
        );
    }

    @Test
    @Order(15)
    @DisplayName("标记公告已读 - 成功")
    void markAsRead_Success() {
        when(userApplicationService.getCurrentUser()).thenReturn(mockUser);
        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.of(mockAnnouncement));
        when(announcementReadRepository.existsByAnnouncementIdAndUserId(ANNOUNCEMENT_ID, USER_ID))
                .thenReturn(false);
        when(announcementReadRepository.save(any(AnnouncementRead.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> announcementApplicationService.markAsRead(ANNOUNCEMENT_ID));
        verify(announcementReadRepository, times(1)).save(any(AnnouncementRead.class));
    }

    @Test
    @Order(16)
    @DisplayName("标记公告已读 - 已读则跳过")
    void markAsRead_AlreadyRead_Skip() {
        when(userApplicationService.getCurrentUser()).thenReturn(mockUser);
        when(announcementRepository.findById(any(AnnouncementId.class)))
                .thenReturn(Optional.of(mockAnnouncement));
        when(announcementReadRepository.existsByAnnouncementIdAndUserId(ANNOUNCEMENT_ID, USER_ID))
                .thenReturn(true);

        assertDoesNotThrow(() -> announcementApplicationService.markAsRead(ANNOUNCEMENT_ID));
        verify(announcementReadRepository, never()).save(any(AnnouncementRead.class));
    }

    @Test
    @Order(17)
    @DisplayName("检查公告是否已读 - 已读")
    void isRead_True() {
        when(userApplicationService.getCurrentUser()).thenReturn(mockUser);
        when(announcementReadRepository.existsByAnnouncementIdAndUserId(ANNOUNCEMENT_ID, USER_ID))
                .thenReturn(true);

        assertTrue(announcementApplicationService.isRead(ANNOUNCEMENT_ID));
    }

    @Test
    @Order(18)
    @DisplayName("检查公告是否已读 - 未读")
    void isRead_False() {
        when(userApplicationService.getCurrentUser()).thenReturn(mockUser);
        when(announcementReadRepository.existsByAnnouncementIdAndUserId(ANNOUNCEMENT_ID, USER_ID))
                .thenReturn(false);

        assertFalse(announcementApplicationService.isRead(ANNOUNCEMENT_ID));
    }

    @Test
    @Order(19)
    @DisplayName("获取未读公告数量")
    void getUnreadCount_Success() {
        AnnouncementPage mockPage = new AnnouncementPage(
                List.of(mockAnnouncement, 
                        Announcement.reconstruct(
                                AnnouncementId.of(2L), "公告2", "内容", 0, AnnouncementStatus.PUBLISHED,
                                null, null, null, ADMIN_ID, 0,
                                LocalDateTime.now(), LocalDateTime.now()
                        ),
                        Announcement.reconstruct(
                                AnnouncementId.of(3L), "公告3", "内容", 0, AnnouncementStatus.PUBLISHED,
                                null, null, null, ADMIN_ID, 0,
                                LocalDateTime.now(), LocalDateTime.now()
                        )
                ),
                3L, 1, 1000
        );

        when(userApplicationService.getCurrentUser()).thenReturn(mockUser);
        when(announcementRepository.findVisibleAnnouncements(1, 1000)).thenReturn(mockPage);
        when(announcementReadRepository.findReadAnnouncementIds(eq(USER_ID), anyList()))
                .thenReturn(List.of(ANNOUNCEMENT_ID)); // 只读了1条

        long count = announcementApplicationService.getUnreadCount();

        assertEquals(2L, count); // 3条公告，读了1条，未读2条
    }

    @Test
    @Order(20)
    @DisplayName("获取未读公告数量 - 未登录返回0")
    void getUnreadCount_NotLoggedIn_ReturnsZero() {
        when(userApplicationService.getCurrentUser()).thenThrow(new BusinessException(ErrorCode.NOT_LOGIN_ERROR));

        long count = announcementApplicationService.getUnreadCount();

        assertEquals(0L, count);
    }
}
