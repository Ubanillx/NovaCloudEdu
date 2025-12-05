package com.novacloudedu.backend.interfaces.rest.announcement;

import com.novacloudedu.backend.application.service.AnnouncementApplicationService;
import com.novacloudedu.backend.application.service.AnnouncementApplicationService.AnnouncementPageWithReadStatus;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.announcement.entity.Announcement;
import com.novacloudedu.backend.interfaces.rest.announcement.assembler.AnnouncementAssembler;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.response.AnnouncementDetailResponse;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.response.UserAnnouncementPageResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 公告控制器（用户端）
 */
@Tag(name = "公告", description = "用户端公告接口")
@RestController
@RequestMapping("/api/announcement")
@RequiredArgsConstructor
@Slf4j
public class AnnouncementController {

    private final AnnouncementApplicationService announcementApplicationService;
    private final AnnouncementAssembler announcementAssembler;

    /**
     * 获取公告列表
     */
    @Operation(summary = "获取公告列表", description = "获取用户可见的公告列表，包含已读状态")
    @GetMapping("/list")
    public BaseResponse<UserAnnouncementPageResponse> getAnnouncementList(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        
        AnnouncementPageWithReadStatus pageWithStatus = 
                announcementApplicationService.getVisibleAnnouncements(pageNum, pageSize);
        long unreadCount = announcementApplicationService.getUnreadCount();
        
        return ResultUtils.success(
                announcementAssembler.toUserPageResponse(pageWithStatus, unreadCount)
        );
    }

    /**
     * 获取公告详情
     */
    @Operation(summary = "获取公告详情", description = "获取公告详细内容")
    @GetMapping("/{id}")
    public BaseResponse<AnnouncementDetailResponse> getAnnouncementDetail(@PathVariable Long id) {
        Announcement announcement = announcementApplicationService.getAnnouncementDetail(id);
        boolean isRead = announcementApplicationService.isRead(id);
        return ResultUtils.success(announcementAssembler.toDetailResponse(announcement, isRead));
    }

    /**
     * 标记公告已读
     */
    @Operation(summary = "标记公告已读", description = "将公告标记为已读")
    @PostMapping("/{id}/read")
    public BaseResponse<Boolean> markAsRead(@PathVariable Long id) {
        announcementApplicationService.markAsRead(id);
        return ResultUtils.success(true);
    }

    /**
     * 获取未读公告数量
     */
    @Operation(summary = "获取未读公告数量", description = "获取当前用户未读公告的数量")
    @GetMapping("/unread-count")
    public BaseResponse<Long> getUnreadCount() {
        long count = announcementApplicationService.getUnreadCount();
        return ResultUtils.success(count);
    }
}
