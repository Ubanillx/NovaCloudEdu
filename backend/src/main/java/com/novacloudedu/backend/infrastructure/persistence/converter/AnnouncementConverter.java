package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.announcement.entity.Announcement;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementId;
import com.novacloudedu.backend.domain.announcement.valueobject.AnnouncementStatus;
import com.novacloudedu.backend.infrastructure.persistence.po.AnnouncementPO;
import org.springframework.stereotype.Component;

/**
 * 公告转换器
 */
@Component
public class AnnouncementConverter {

    /**
     * PO -> Domain
     */
    public Announcement toDomain(AnnouncementPO po) {
        if (po == null) {
            return null;
        }
        return Announcement.reconstruct(
                AnnouncementId.of(po.getId()),
                po.getTitle(),
                po.getContent(),
                po.getSort(),
                AnnouncementStatus.fromCode(po.getStatus()),
                po.getStartTime(),
                po.getEndTime(),
                po.getCoverImage(),
                po.getAdminId(),
                po.getViewCount(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * Domain -> PO
     */
    public AnnouncementPO toPO(Announcement announcement) {
        if (announcement == null) {
            return null;
        }
        AnnouncementPO po = new AnnouncementPO();
        if (announcement.getId() != null) {
            po.setId(announcement.getId().value());
        }
        po.setTitle(announcement.getTitle());
        po.setContent(announcement.getContent());
        po.setSort(announcement.getSort());
        po.setStatus(announcement.getStatus().getCode());
        po.setStartTime(announcement.getStartTime());
        po.setEndTime(announcement.getEndTime());
        po.setCoverImage(announcement.getCoverImage());
        po.setAdminId(announcement.getAdminId());
        po.setViewCount(announcement.getViewCount());
        po.setCreateTime(announcement.getCreateTime());
        po.setUpdateTime(announcement.getUpdateTime());
        return po;
    }
}
