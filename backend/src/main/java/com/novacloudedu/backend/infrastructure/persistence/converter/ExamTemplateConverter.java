package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.exam.entity.ExamTemplate;
import com.novacloudedu.backend.domain.exam.valueobject.ExamTemplateId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.ExamTemplatePO;
import org.springframework.stereotype.Component;

/**
 * 试卷模板领域对象与持久化对象转换器
 */
@Component
public class ExamTemplateConverter {

    /**
     * PO -> Domain Entity
     */
    public ExamTemplate toDomain(ExamTemplatePO po) {
        if (po == null) {
            return null;
        }
        return ExamTemplate.reconstruct(
                ExamTemplateId.of(po.getId()),
                po.getName(),
                po.getDescription(),
                po.getTemplateUrl(),
                po.getCoverUrl(),
                UserId.of(po.getCreatorId()),
                Boolean.TRUE.equals(po.getIsSystem()),
                Boolean.TRUE.equals(po.getIsEnabled()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * Domain Entity -> PO
     */
    public ExamTemplatePO toPO(ExamTemplate template) {
        if (template == null) {
            return null;
        }
        ExamTemplatePO po = new ExamTemplatePO();
        if (template.getId() != null) {
            po.setId(template.getId().value());
        }
        po.setName(template.getName());
        po.setDescription(template.getDescription());
        po.setTemplateUrl(template.getTemplateUrl());
        po.setCoverUrl(template.getCoverUrl());
        po.setCreatorId(template.getCreatorId().value());
        po.setIsSystem(template.isSystem());
        po.setIsEnabled(template.isEnabled());
        po.setCreateTime(template.getCreateTime());
        po.setUpdateTime(template.getUpdateTime());
        return po;
    }
}
