package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.announcement.entity.Announcement;
import com.novacloudedu.backend.domain.announcement.repository.AnnouncementRepository;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementId;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementStatus;
import com.novacloudedu.backend.infrastructure.persistence.converter.AnnouncementConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AnnouncementMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AnnouncementPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * 公告仓储实现
 */
@Repository
@RequiredArgsConstructor
public class AnnouncementRepositoryImpl implements AnnouncementRepository {

    private final AnnouncementMapper announcementMapper;
    private final AnnouncementConverter announcementConverter;

    @Override
    public Announcement save(Announcement announcement) {
        AnnouncementPO po = announcementConverter.toPO(announcement);
        if (announcement.getId() == null) {
            announcementMapper.insert(po);
            announcement.assignId(AnnouncementId.of(po.getId()));
        } else {
            announcementMapper.updateById(po);
        }
        return announcement;
    }

    @Override
    public Optional<Announcement> findById(AnnouncementId id) {
        AnnouncementPO po = announcementMapper.selectById(id.value());
        return Optional.ofNullable(announcementConverter.toDomain(po));
    }

    @Override
    public void delete(AnnouncementId id) {
        announcementMapper.deleteById(id.value());
    }

    @Override
    public AnnouncementPage findByCondition(AnnouncementQueryCondition condition) {
        LambdaQueryWrapper<AnnouncementPO> wrapper = new LambdaQueryWrapper<>();
        
        if (StringUtils.hasText(condition.title())) {
            wrapper.like(AnnouncementPO::getTitle, condition.title());
        }
        if (condition.status() != null) {
            wrapper.eq(AnnouncementPO::getStatus, condition.status().getCode());
        }
        if (condition.adminId() != null) {
            wrapper.eq(AnnouncementPO::getAdminId, condition.adminId());
        }
        
        wrapper.orderByDesc(AnnouncementPO::getSort)
               .orderByDesc(AnnouncementPO::getCreateTime);
        
        Page<AnnouncementPO> page = new Page<>(condition.pageNum(), condition.pageSize());
        Page<AnnouncementPO> resultPage = announcementMapper.selectPage(page, wrapper);
        
        List<Announcement> announcements = resultPage.getRecords().stream()
                .map(announcementConverter::toDomain)
                .toList();
        
        return new AnnouncementPage(announcements, resultPage.getTotal(), 
                condition.pageNum(), condition.pageSize());
    }

    @Override
    public AnnouncementPage findVisibleAnnouncements(int pageNum, int pageSize) {
        LocalDateTime now = LocalDateTime.now();
        
        LambdaQueryWrapper<AnnouncementPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnnouncementPO::getStatus, AnnouncementStatus.PUBLISHED.getCode())
               .and(w -> w.isNull(AnnouncementPO::getStartTime)
                       .or()
                       .le(AnnouncementPO::getStartTime, now))
               .and(w -> w.isNull(AnnouncementPO::getEndTime)
                       .or()
                       .ge(AnnouncementPO::getEndTime, now))
               .orderByDesc(AnnouncementPO::getSort)
               .orderByDesc(AnnouncementPO::getCreateTime);
        
        Page<AnnouncementPO> page = new Page<>(pageNum, pageSize);
        Page<AnnouncementPO> resultPage = announcementMapper.selectPage(page, wrapper);
        
        List<Announcement> announcements = resultPage.getRecords().stream()
                .map(announcementConverter::toDomain)
                .toList();
        
        return new AnnouncementPage(announcements, resultPage.getTotal(), pageNum, pageSize);
    }

    @Override
    public void incrementViewCount(AnnouncementId id) {
        announcementMapper.incrementViewCount(id.value());
    }
}
