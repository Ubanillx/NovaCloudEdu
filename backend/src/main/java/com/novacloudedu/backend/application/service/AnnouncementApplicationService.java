package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.announcement.command.CreateAnnouncementCommand;
import com.novacloudedu.backend.application.announcement.command.UpdateAnnouncementCommand;
import com.novacloudedu.backend.application.announcement.query.AnnouncementQuery;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.announcement.entity.Announcement;
import com.novacloudedu.backend.domain.announcement.entity.AnnouncementRead;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementReadRepository;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementRepository;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementRepository.AnnouncementPage;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementRepository.AnnouncementQueryCondition;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementId;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementStatus;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 公告应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class AnnouncementApplicationService {

    private final AnnouncementRepository announcementRepository;
    private final AnnouncementReadRepository announcementReadRepository;
    private final UserApplicationService userApplicationService;

    // ==================== 管理员功能 ====================

    /**
     * 创建公告
     */
    @Transactional
    public Long createAnnouncement(CreateAnnouncementCommand command) {
        User admin = userApplicationService.getCurrentUser();
        
        Announcement announcement = Announcement.create(
                command.title(),
                command.content(),
                command.sort(),
                command.startTime(),
                command.endTime(),
                command.coverImage(),
                admin.getId().value()
        );
        
        announcementRepository.save(announcement);
        log.info("管理员[{}]创建公告: {}", admin.getId().value(), announcement.getId().value());
        return announcement.getId().value();
    }

    /**
     * 更新公告
     */
    @Transactional
    public void updateAnnouncement(UpdateAnnouncementCommand command) {
        Announcement announcement = announcementRepository.findById(AnnouncementId.of(command.id()))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "公告不存在"));
        
        announcement.update(
                command.title(),
                command.content(),
                command.sort(),
                command.startTime(),
                command.endTime(),
                command.coverImage()
        );
        
        // 如果提供了状态，更新状态
        if (command.status() != null) {
            announcement.updateStatus(AnnouncementStatus.fromCode(command.status()));
        }
        
        announcementRepository.save(announcement);
        log.info("更新公告: {}", command.id());
    }

    /**
     * 删除公告
     */
    @Transactional
    public void deleteAnnouncement(Long id) {
        AnnouncementId announcementId = AnnouncementId.of(id);
        announcementRepository.findById(announcementId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "公告不存在"));
        
        announcementRepository.delete(announcementId);
        log.info("删除公告: {}", id);
    }

    /**
     * 发布公告
     */
    @Transactional
    public void publishAnnouncement(Long id) {
        Announcement announcement = announcementRepository.findById(AnnouncementId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "公告不存在"));
        
        announcement.publish();
        announcementRepository.save(announcement);
        log.info("发布公告: {}", id);
    }

    /**
     * 下线公告
     */
    @Transactional
    public void offlineAnnouncement(Long id) {
        Announcement announcement = announcementRepository.findById(AnnouncementId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "公告不存在"));
        
        announcement.offline();
        announcementRepository.save(announcement);
        log.info("下线公告: {}", id);
    }

    /**
     * 获取公告详情（管理员）
     */
    @Transactional(readOnly = true)
    public Announcement getAnnouncementById(Long id) {
        return announcementRepository.findById(AnnouncementId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "公告不存在"));
    }

    /**
     * 分页查询公告（管理员）
     */
    @Transactional(readOnly = true)
    public AnnouncementPage queryAnnouncements(AnnouncementQuery query) {
        AnnouncementStatus status = query.status() != null 
                ? AnnouncementStatus.fromCode(query.status()) 
                : null;
        
        AnnouncementQueryCondition condition = AnnouncementQueryCondition.of(
                query.title(),
                status,
                query.adminId(),
                query.pageNum(),
                query.pageSize()
        );
        return announcementRepository.findByCondition(condition);
    }

    /**
     * 获取公告阅读统计
     */
    @Transactional(readOnly = true)
    public long getReadCount(Long announcementId) {
        return announcementReadRepository.countByAnnouncementId(announcementId);
    }

    // ==================== 用户功能 ====================

    /**
     * 获取用户可见的公告列表
     */
    @Transactional(readOnly = true)
    public AnnouncementPageWithReadStatus getVisibleAnnouncements(int pageNum, int pageSize) {
        AnnouncementPage page = announcementRepository.findVisibleAnnouncements(pageNum, pageSize);
        
        // 获取当前用户的已读状态
        Set<Long> readIds = Set.of();
        try {
            User user = userApplicationService.getCurrentUser();
            List<Long> announcementIds = page.announcements().stream()
                    .map(a -> a.getId().value())
                    .toList();
            readIds = announcementReadRepository.findReadAnnouncementIds(user.getId().value(), announcementIds)
                    .stream()
                    .collect(Collectors.toSet());
        } catch (Exception e) {
            // 未登录用户，所有公告都显示为未读
            log.debug("用户未登录，无法获取已读状态");
        }
        
        return new AnnouncementPageWithReadStatus(page, readIds);
    }

    /**
     * 获取公告详情（用户）
     */
    @Transactional
    public Announcement getAnnouncementDetail(Long id) {
        Announcement announcement = announcementRepository.findById(AnnouncementId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "公告不存在"));
        
        // 检查公告是否可见
        if (!announcement.isInDisplayPeriod()) {
            throw new BusinessException(ErrorCode.NOT_FOUND_ERROR, "公告不存在或已过期");
        }
        
        // 增加浏览量
        announcementRepository.incrementViewCount(announcement.getId());
        
        return announcement;
    }

    /**
     * 标记公告已读
     */
    @Transactional
    public void markAsRead(Long announcementId) {
        User user = userApplicationService.getCurrentUser();
        
        // 检查公告是否存在
        announcementRepository.findById(AnnouncementId.of(announcementId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "公告不存在"));
        
        // 检查是否已读
        if (announcementReadRepository.existsByAnnouncementIdAndUserId(announcementId, user.getId().value())) {
            return; // 已经标记过了
        }
        
        // 创建阅读记录
        AnnouncementRead read = AnnouncementRead.create(announcementId, user.getId().value());
        announcementReadRepository.save(read);
        log.debug("用户[{}]阅读公告[{}]", user.getId().value(), announcementId);
    }

    /**
     * 检查公告是否已读
     */
    @Transactional(readOnly = true)
    public boolean isRead(Long announcementId) {
        try {
            User user = userApplicationService.getCurrentUser();
            return announcementReadRepository.existsByAnnouncementIdAndUserId(announcementId, user.getId().value());
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 获取用户未读公告数量
     */
    @Transactional(readOnly = true)
    public long getUnreadCount() {
        try {
            User user = userApplicationService.getCurrentUser();
            
            // 获取所有可见公告
            AnnouncementPage visiblePage = announcementRepository.findVisibleAnnouncements(1, 1000);
            List<Long> visibleIds = visiblePage.announcements().stream()
                    .map(a -> a.getId().value())
                    .toList();
            
            if (visibleIds.isEmpty()) {
                return 0;
            }
            
            // 获取已读的公告ID
            List<Long> readIds = announcementReadRepository.findReadAnnouncementIds(user.getId().value(), visibleIds);
            
            return visibleIds.size() - readIds.size();
        } catch (Exception e) {
            return 0;
        }
    }

    /**
     * 带已读状态的公告分页结果
     */
    public record AnnouncementPageWithReadStatus(
            AnnouncementPage page,
            Set<Long> readAnnouncementIds
    ) {
        public boolean isRead(Long announcementId) {
            return readAnnouncementIds.contains(announcementId);
        }
    }
}
