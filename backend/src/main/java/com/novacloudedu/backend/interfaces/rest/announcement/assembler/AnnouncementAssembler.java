package com.novacloudedu.backend.interfaces.rest.announcement.assembler;

import com.novacloudedu.backend.application.announcement.command.CreateAnnouncementCommand;
import com.novacloudedu.backend.application.announcement.command.UpdateAnnouncementCommand;
import com.novacloudedu.backend.application.announcement.query.AnnouncementQuery;
import com.novacloudedu.backend.application.service.AnnouncementApplicationService.AnnouncementPageWithReadStatus;
import com.novacloudedu.backend.domain.announcement.entity.Announcement;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementRepository.AnnouncementPage;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.request.CreateAnnouncementRequest;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.request.QueryAnnouncementRequest;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.request.UpdateAnnouncementRequest;
import com.novacloudedu.backend.interfaces.rest.announcement.dto.response.*;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 公告组装器
 */
@Component
public class AnnouncementAssembler {

    /**
     * 转换为创建命令
     */
    public CreateAnnouncementCommand toCreateCommand(CreateAnnouncementRequest request) {
        return new CreateAnnouncementCommand(
                request.title(),
                request.content(),
                request.sort(),
                request.startTime(),
                request.endTime(),
                request.coverImage()
        );
    }

    /**
     * 转换为更新命令
     */
    public UpdateAnnouncementCommand toUpdateCommand(UpdateAnnouncementRequest request) {
        return new UpdateAnnouncementCommand(
                request.id(),
                request.title(),
                request.content(),
                request.sort(),
                request.status(),
                request.startTime(),
                request.endTime(),
                request.coverImage()
        );
    }

    /**
     * 转换为查询参数
     */
    public AnnouncementQuery toQuery(QueryAnnouncementRequest request) {
        return new AnnouncementQuery(
                request.title(),
                request.status(),
                request.adminId(),
                request.getPageNum(),
                request.getPageSize()
        );
    }

    /**
     * 转换为管理员响应
     */
    public AnnouncementResponse toResponse(Announcement announcement, Long readCount) {
        return new AnnouncementResponse(
                announcement.getId().value(),
                announcement.getTitle(),
                announcement.getContent(),
                announcement.getSort(),
                announcement.getStatus().getCode(),
                announcement.getStatus().getDescription(),
                announcement.getStartTime(),
                announcement.getEndTime(),
                announcement.getCoverImage(),
                announcement.getAdminId(),
                announcement.getViewCount(),
                readCount,
                announcement.getCreateTime(),
                announcement.getUpdateTime()
        );
    }

    /**
     * 转换为管理员响应（无阅读计数）
     */
    public AnnouncementResponse toResponse(Announcement announcement) {
        return toResponse(announcement, null);
    }

    /**
     * 转换为管理员分页响应
     */
    public AnnouncementPageResponse toPageResponse(AnnouncementPage page) {
        List<AnnouncementResponse> records = page.announcements().stream()
                .map(this::toResponse)
                .toList();
        
        return new AnnouncementPageResponse(
                records,
                page.total(),
                page.pageNum(),
                page.pageSize(),
                page.getTotalPages()
        );
    }

    /**
     * 转换为用户详情响应
     */
    public AnnouncementDetailResponse toDetailResponse(Announcement announcement, boolean isRead) {
        return new AnnouncementDetailResponse(
                announcement.getId().value(),
                announcement.getTitle(),
                announcement.getContent(),
                announcement.getCoverImage(),
                announcement.getViewCount(),
                isRead,
                announcement.getCreateTime()
        );
    }

    /**
     * 转换为用户列表响应
     */
    public AnnouncementListResponse toListResponse(Announcement announcement, boolean isRead) {
        return new AnnouncementListResponse(
                announcement.getId().value(),
                announcement.getTitle(),
                announcement.getCoverImage(),
                announcement.getViewCount(),
                isRead,
                announcement.getCreateTime()
        );
    }

    /**
     * 转换为用户分页响应
     */
    public UserAnnouncementPageResponse toUserPageResponse(AnnouncementPageWithReadStatus pageWithStatus, 
                                                            long unreadCount) {
        List<AnnouncementListResponse> records = pageWithStatus.page().announcements().stream()
                .map(a -> toListResponse(a, pageWithStatus.isRead(a.getId().value())))
                .toList();
        
        return new UserAnnouncementPageResponse(
                records,
                pageWithStatus.page().total(),
                pageWithStatus.page().pageNum(),
                pageWithStatus.page().pageSize(),
                pageWithStatus.page().getTotalPages(),
                unreadCount
        );
    }
}
