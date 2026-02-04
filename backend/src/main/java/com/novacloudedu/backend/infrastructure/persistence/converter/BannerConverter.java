package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.banner.entity.Banner;
import com.novacloudedu.backend.domain.banner.valueobject.BannerId;
import com.novacloudedu.backend.domain.banner.valueobject.BannerStatus;
import com.novacloudedu.backend.domain.banner.valueobject.LinkType;
import com.novacloudedu.backend.infrastructure.persistence.po.BannerPO;
import org.springframework.stereotype.Component;

/**
 * 轮播图转换器
 */
@Component
public class BannerConverter {

    /**
     * PO -> Domain
     */
    public Banner toDomain(BannerPO po) {
        if (po == null) {
            return null;
        }
        return Banner.reconstruct(
                BannerId.of(po.getId()),
                po.getTitle(),
                po.getImageUrl(),
                LinkType.fromCode(po.getLinkType()),
                po.getLinkUrl(),
                po.getSort(),
                BannerStatus.fromCode(po.getStatus()),
                po.getStartTime(),
                po.getEndTime(),
                po.getAdminId(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * Domain -> PO
     */
    public BannerPO toPO(Banner banner) {
        if (banner == null) {
            return null;
        }
        BannerPO po = new BannerPO();
        if (banner.getId() != null) {
            po.setId(banner.getId().value());
        }
        po.setTitle(banner.getTitle());
        po.setImageUrl(banner.getImageUrl());
        po.setLinkType(banner.getLinkType().getCode());
        po.setLinkUrl(banner.getLinkUrl());
        po.setSort(banner.getSort());
        po.setStatus(banner.getStatus().getCode());
        po.setStartTime(banner.getStartTime());
        po.setEndTime(banner.getEndTime());
        po.setAdminId(banner.getAdminId());
        po.setCreateTime(banner.getCreateTime());
        po.setUpdateTime(banner.getUpdateTime());
        return po;
    }
}
