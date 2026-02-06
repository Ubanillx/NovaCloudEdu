package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.scraper.entity.ScraperSourceConfig;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperConfigId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.ScraperSourceConfigPO;
import org.springframework.stereotype.Component;

@Component
public class ScraperSourceConfigConverter {

    public ScraperSourceConfigPO toPO(ScraperSourceConfig config) {
        ScraperSourceConfigPO po = new ScraperSourceConfigPO();
        if (config.getId() != null) {
            po.setId(config.getId().value());
        }
        po.setName(config.getName());
        po.setSourceCode(config.getSourceCode());
        po.setBaseUrl(config.getBaseUrl());
        po.setDescription(config.getDescription());
        po.setTitleSelector(config.getTitleSelector());
        po.setAuthorSelector(config.getAuthorSelector());
        po.setSourceSelector(config.getSourceSelector());
        po.setContentSelector(config.getContentSelector());
        po.setDateSelector(config.getDateSelector());
        po.setImageSelector(config.getImageSelector());
        po.setLinkSelector(config.getLinkSelector());
        po.setMaxDepth(config.getMaxDepth());
        po.setMaxPages(config.getMaxPages());
        po.setDelayMs(config.getDelayMs());
        po.setUseDynamic(config.getUseDynamic());
        po.setWaitForJsMs(config.getWaitForJsMs());
        po.setCronExpression(config.getCronExpression());
        po.setEnabled(config.getEnabled());
        po.setDefaultMaxArticles(config.getDefaultMaxArticles());
        po.setDefaultCategory(config.getDefaultCategory());
        po.setDefaultDifficulty(config.getDefaultDifficulty());
        if (config.getCreatorId() != null) {
            po.setCreatorId(config.getCreatorId().value());
        }
        po.setCreateTime(config.getCreateTime());
        po.setUpdateTime(config.getUpdateTime());
        return po;
    }

    public ScraperSourceConfig toDomain(ScraperSourceConfigPO po) {
        return ScraperSourceConfig.reconstruct(
                ScraperConfigId.of(po.getId()),
                po.getName(),
                po.getSourceCode(),
                po.getBaseUrl(),
                po.getDescription(),
                po.getTitleSelector(),
                po.getAuthorSelector(),
                po.getSourceSelector(),
                po.getContentSelector(),
                po.getDateSelector(),
                po.getImageSelector(),
                po.getLinkSelector(),
                po.getMaxDepth(),
                po.getMaxPages(),
                po.getDelayMs(),
                po.getUseDynamic(),
                po.getWaitForJsMs(),
                po.getCronExpression(),
                po.getEnabled(),
                po.getDefaultMaxArticles(),
                po.getDefaultCategory(),
                po.getDefaultDifficulty(),
                po.getCreatorId() != null ? UserId.of(po.getCreatorId()) : null,
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
