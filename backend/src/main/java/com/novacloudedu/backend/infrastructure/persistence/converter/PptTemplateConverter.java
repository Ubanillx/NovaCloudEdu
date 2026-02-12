package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.ppt.entity.PptTemplate;
import com.novacloudedu.backend.domain.ppt.valueobject.PptTemplateId;
import com.novacloudedu.backend.infrastructure.persistence.po.PptTemplatePO;
import org.springframework.stereotype.Component;

/**
 * PPT模板转换器：PO ↔ Domain
 */
@Component
public class PptTemplateConverter {

    public PptTemplate toDomain(PptTemplatePO po) {
        if (po == null) {
            return null;
        }
        return PptTemplate.reconstruct(
                PptTemplateId.of(po.getId()),
                po.getName(),
                po.getDescription(),
                po.getCoverUrl(),
                po.getTemplateUrl(),
                po.getSlideCount() != null ? po.getSlideCount() : 0,
                po.getStructureJson(),
                po.getUploaderId(),
                po.getEnabled() != null && po.getEnabled(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    public PptTemplatePO toPO(PptTemplate template) {
        if (template == null) {
            return null;
        }
        PptTemplatePO po = new PptTemplatePO();
        if (template.getId() != null) {
            po.setId(template.getId().value());
        }
        po.setName(template.getName());
        po.setDescription(template.getDescription());
        po.setCoverUrl(template.getCoverUrl());
        po.setTemplateUrl(template.getTemplateUrl());
        po.setSlideCount(template.getSlideCount());
        po.setStructureJson(template.getStructureJson());
        po.setUploaderId(template.getUploaderId());
        po.setEnabled(template.isEnabled());
        po.setCreateTime(template.getCreateTime());
        po.setUpdateTime(template.getUpdateTime());
        return po;
    }
}
