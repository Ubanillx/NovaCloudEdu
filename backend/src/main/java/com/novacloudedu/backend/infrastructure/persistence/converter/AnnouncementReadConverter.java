package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.announcement.entity.AnnouncementRead;
import com.novacloudedu.backend.infrastructure.persistence.po.AnnouncementReadPO;
import org.springframework.stereotype.Component;

/**
 * 公告阅读记录转换器
 */
@Component
public class AnnouncementReadConverter {

    /**
     * PO -> Domain
     */
    public AnnouncementRead toDomain(AnnouncementReadPO po) {
        if (po == null) {
            return null;
        }
        return AnnouncementRead.reconstruct(
                po.getId(),
                po.getAnnouncementId(),
                po.getUserId(),
                po.getCreateTime()
        );
    }

    /**
     * Domain -> PO
     */
    public AnnouncementReadPO toPO(AnnouncementRead read) {
        if (read == null) {
            return null;
        }
        AnnouncementReadPO po = new AnnouncementReadPO();
        if (read.getId() != null) {
            po.setId(read.getId());
        }
        po.setAnnouncementId(read.getAnnouncementId());
        po.setUserId(read.getUserId());
        po.setCreateTime(read.getCreateTime());
        return po;
    }
}
