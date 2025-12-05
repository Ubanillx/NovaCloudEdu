package com.novacloudedu.backend.announcement;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.novacloudedu.backend.application.service.AnnouncementApplicationService;
import com.novacloudedu.backend.application.service.AnnouncementApplicationService.AnnouncementPageWithReadStatus;
import com.novacloudedu.backend.domain.announcement.entity.Announcement;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementRepository.AnnouncementPage;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementId;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementStatus;
import com.novacloudedu.backend.interfaces.rest.announcement.AdminAnnouncementController;
import com.novacloudedu.backend.interfaces.rest.announcement.AnnouncementController;
import com.novacloudedu.backend.interfaces.rest.announcement.assembler.AnnouncementAssembler;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.request.CreateAnnouncementRequest;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.request.QueryAnnouncementRequest;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.request.UpdateAnnouncementRequest;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * 公告控制器单元测试
 */
@ExtendWith(MockitoExtension.class)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class AnnouncementControllerTest {

    @Mock
    private AnnouncementApplicationService announcementApplicationService;

    @Spy
    private AnnouncementAssembler announcementAssembler = new AnnouncementAssembler();

    @InjectMocks
    private AdminAnnouncementController adminAnnouncementController;

    @InjectMocks
    private AnnouncementController announcementController;

    private MockMvc adminMockMvc;
    private MockMvc userMockMvc;
    private ObjectMapper objectMapper;

    private static final Long ANNOUNCEMENT_ID = 1L;
    private static final Long ADMIN_ID = 1L;

    private Announcement mockAnnouncement;

    @BeforeEach
    void setUp() {
        adminMockMvc = MockMvcBuilders.standaloneSetup(adminAnnouncementController).build();
        userMockMvc = MockMvcBuilders.standaloneSetup(announcementController).build();
        
        objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());

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

    // ==================== 管理员接口测试 ====================

    @Test
    @Order(1)
    @DisplayName("管理员 - 创建公告")
    void adminCreateAnnouncement() throws Exception {
        when(announcementApplicationService.createAnnouncement(any())).thenReturn(ANNOUNCEMENT_ID);

        CreateAnnouncementRequest request = new CreateAnnouncementRequest(
                "新公告", "公告内容", 5, null, null, null
        );

        adminMockMvc.perform(post("/api/announcement/admin/create")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").value(ANNOUNCEMENT_ID));
    }

    @Test
    @Order(2)
    @DisplayName("管理员 - 创建公告参数校验失败")
    void adminCreateAnnouncement_ValidationFailed() throws Exception {
        CreateAnnouncementRequest request = new CreateAnnouncementRequest(
                "", "", null, null, null, null // 空标题和内容
        );

        adminMockMvc.perform(post("/api/announcement/admin/create")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @Order(3)
    @DisplayName("管理员 - 更新公告")
    void adminUpdateAnnouncement() throws Exception {
        doNothing().when(announcementApplicationService).updateAnnouncement(any());

        UpdateAnnouncementRequest request = new UpdateAnnouncementRequest(
                ANNOUNCEMENT_ID, "更新标题", "更新内容", 10, null, null, null, null
        );

        adminMockMvc.perform(put("/api/announcement/admin/update")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").value(true));
    }

    @Test
    @Order(4)
    @DisplayName("管理员 - 删除公告")
    void adminDeleteAnnouncement() throws Exception {
        doNothing().when(announcementApplicationService).deleteAnnouncement(ANNOUNCEMENT_ID);

        adminMockMvc.perform(delete("/api/announcement/admin/delete/" + ANNOUNCEMENT_ID))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").value(true));
    }

    @Test
    @Order(5)
    @DisplayName("管理员 - 发布公告")
    void adminPublishAnnouncement() throws Exception {
        doNothing().when(announcementApplicationService).publishAnnouncement(ANNOUNCEMENT_ID);

        adminMockMvc.perform(post("/api/announcement/admin/publish/" + ANNOUNCEMENT_ID))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").value(true));
    }

    @Test
    @Order(6)
    @DisplayName("管理员 - 下线公告")
    void adminOfflineAnnouncement() throws Exception {
        doNothing().when(announcementApplicationService).offlineAnnouncement(ANNOUNCEMENT_ID);

        adminMockMvc.perform(post("/api/announcement/admin/offline/" + ANNOUNCEMENT_ID))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").value(true));
    }

    @Test
    @Order(7)
    @DisplayName("管理员 - 获取公告详情")
    void adminGetAnnouncement() throws Exception {
        when(announcementApplicationService.getAnnouncementById(ANNOUNCEMENT_ID))
                .thenReturn(mockAnnouncement);
        when(announcementApplicationService.getReadCount(ANNOUNCEMENT_ID)).thenReturn(50L);

        adminMockMvc.perform(get("/api/announcement/admin/" + ANNOUNCEMENT_ID))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.id").value(ANNOUNCEMENT_ID))
                .andExpect(jsonPath("$.data.title").value("测试公告"))
                .andExpect(jsonPath("$.data.readCount").value(50));
    }

    @Test
    @Order(8)
    @DisplayName("管理员 - 分页查询公告")
    void adminQueryAnnouncements() throws Exception {
        AnnouncementPage mockPage = new AnnouncementPage(
                List.of(mockAnnouncement), 1L, 1, 10
        );
        when(announcementApplicationService.queryAnnouncements(any())).thenReturn(mockPage);

        QueryAnnouncementRequest request = new QueryAnnouncementRequest(
                null, null, null, 1, 10
        );

        adminMockMvc.perform(post("/api/announcement/admin/list")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.total").value(1))
                .andExpect(jsonPath("$.data.records[0].id").value(ANNOUNCEMENT_ID));
    }

    // ==================== 用户接口测试 ====================

    @Test
    @Order(9)
    @DisplayName("用户 - 获取公告列表")
    void userGetAnnouncementList() throws Exception {
        AnnouncementPage mockPage = new AnnouncementPage(
                List.of(mockAnnouncement), 1L, 1, 10
        );
        AnnouncementPageWithReadStatus pageWithStatus = new AnnouncementPageWithReadStatus(
                mockPage, Set.of(ANNOUNCEMENT_ID)
        );

        when(announcementApplicationService.getVisibleAnnouncements(1, 10))
                .thenReturn(pageWithStatus);
        when(announcementApplicationService.getUnreadCount()).thenReturn(0L);

        userMockMvc.perform(get("/api/announcement/list")
                        .param("pageNum", "1")
                        .param("pageSize", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.total").value(1))
                .andExpect(jsonPath("$.data.records[0].id").value(ANNOUNCEMENT_ID))
                .andExpect(jsonPath("$.data.records[0].isRead").value(true))
                .andExpect(jsonPath("$.data.unreadCount").value(0));
    }

    @Test
    @Order(10)
    @DisplayName("用户 - 获取公告详情")
    void userGetAnnouncementDetail() throws Exception {
        when(announcementApplicationService.getAnnouncementDetail(ANNOUNCEMENT_ID))
                .thenReturn(mockAnnouncement);
        when(announcementApplicationService.isRead(ANNOUNCEMENT_ID)).thenReturn(false);

        userMockMvc.perform(get("/api/announcement/" + ANNOUNCEMENT_ID))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.id").value(ANNOUNCEMENT_ID))
                .andExpect(jsonPath("$.data.title").value("测试公告"))
                .andExpect(jsonPath("$.data.content").value("测试内容"))
                .andExpect(jsonPath("$.data.isRead").value(false));
    }

    @Test
    @Order(11)
    @DisplayName("用户 - 标记公告已读")
    void userMarkAsRead() throws Exception {
        doNothing().when(announcementApplicationService).markAsRead(ANNOUNCEMENT_ID);

        userMockMvc.perform(post("/api/announcement/" + ANNOUNCEMENT_ID + "/read"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").value(true));
    }

    @Test
    @Order(12)
    @DisplayName("用户 - 获取未读公告数量")
    void userGetUnreadCount() throws Exception {
        when(announcementApplicationService.getUnreadCount()).thenReturn(5L);

        userMockMvc.perform(get("/api/announcement/unread-count"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").value(5));
    }
}
