package com.novacloudedu.backend.interfaces.rest.announcement;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.service.AnnouncementApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.announcement.entity.Announcement;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementRepository.AnnouncementPage;
import com.novacloudedu.backend.interfaces.rest.announcement.assembler.AnnouncementAssembler;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.request.CreateAnnouncementRequest;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.request.QueryAnnouncementRequest;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.request.UpdateAnnouncementRequest;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.response.AnnouncementPageResponse;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.response.AnnouncementResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 公告管理控制器（管理员）
 */
@Tag(name = "公告管理", description = "管理员公告管理接口")
@RestController
@RequestMapping("/api/announcement/admin")
@RequiredArgsConstructor
@Slf4j
public class AdminAnnouncementController {

    private final AnnouncementApplicationService announcementApplicationService;
    private final AnnouncementAssembler announcementAssembler;

    /**
     * 创建公告
     */
    @Operation(summary = "创建公告", description = "创建新公告，初始状态为草稿")
    @PostMapping("/create")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Long> createAnnouncement(@RequestBody @Valid CreateAnnouncementRequest request) {
        Long id = announcementApplicationService.createAnnouncement(
                announcementAssembler.toCreateCommand(request)
        );
        return ResultUtils.success(id);
    }

    /**
     * 更新公告
     */
    @Operation(summary = "更新公告", description = "更新公告信息")
    @PutMapping("/update")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> updateAnnouncement(@RequestBody @Valid UpdateAnnouncementRequest request) {
        announcementApplicationService.updateAnnouncement(
                announcementAssembler.toUpdateCommand(request)
        );
        return ResultUtils.success(true);
    }

    /**
     * 删除公告
     */
    @Operation(summary = "删除公告", description = "逻辑删除公告")
    @DeleteMapping("/delete/{id}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> deleteAnnouncement(@PathVariable Long id) {
        announcementApplicationService.deleteAnnouncement(id);
        return ResultUtils.success(true);
    }

    /**
     * 发布公告
     */
    @Operation(summary = "发布公告", description = "将公告状态改为已发布")
    @PostMapping("/publish/{id}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> publishAnnouncement(@PathVariable Long id) {
        announcementApplicationService.publishAnnouncement(id);
        return ResultUtils.success(true);
    }

    /**
     * 下线公告
     */
    @Operation(summary = "下线公告", description = "将公告状态改为已下线")
    @PostMapping("/offline/{id}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> offlineAnnouncement(@PathVariable Long id) {
        announcementApplicationService.offlineAnnouncement(id);
        return ResultUtils.success(true);
    }

    /**
     * 获取公告详情
     */
    @Operation(summary = "获取公告详情", description = "获取公告详细信息，包含阅读统计")
    @GetMapping("/{id}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<AnnouncementResponse> getAnnouncement(@PathVariable Long id) {
        Announcement announcement = announcementApplicationService.getAnnouncementById(id);
        long readCount = announcementApplicationService.getReadCount(id);
        return ResultUtils.success(announcementAssembler.toResponse(announcement, readCount));
    }

    /**
     * 分页查询公告
     */
    @Operation(summary = "分页查询公告", description = "管理员分页查询公告列表")
    @PostMapping("/list")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<AnnouncementPageResponse> queryAnnouncements(@RequestBody QueryAnnouncementRequest request) {
        AnnouncementPage page = announcementApplicationService.queryAnnouncements(
                announcementAssembler.toQuery(request)
        );
        return ResultUtils.success(announcementAssembler.toPageResponse(page));
    }
}
