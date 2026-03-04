package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.ppt.entity.PptGenerationSession;
import com.novacloudedu.backend.domain.ppt.valueobject.PptGenerationState;
import com.novacloudedu.backend.infrastructure.persistence.po.PptGenerationSessionPO;
import org.springframework.stereotype.Component;

/**
 * PPT生成会话转换器：PO ↔ Domain
 */
@Component
public class PptGenerationSessionConverter {

    public PptGenerationSession toDomain(PptGenerationSessionPO po) {
        if (po == null) {
            return null;
        }
        return PptGenerationSession.reconstruct(
                po.getId(),
                po.getUserId(),
                po.getProjectId(),
                PptGenerationState.fromCode(po.getState()),
                po.getTopic(),
                po.getOutlineMarkdown(),
                po.getOutlineJson(),
                po.getTemplateId(),
                po.getTemplateUrl(),
                po.getTemplateJson(),
                po.getSlidesJson(),
                po.getResultUrl(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    public PptGenerationSessionPO toPO(PptGenerationSession session) {
        if (session == null) {
            return null;
        }
        PptGenerationSessionPO po = new PptGenerationSessionPO();
        po.setId(session.getId());
        po.setUserId(session.getUserId());
        po.setProjectId(session.getProjectId());
        po.setState(session.getState().getCode());
        po.setTopic(session.getTopic());
        po.setOutlineMarkdown(session.getOutlineMarkdown());
        po.setOutlineJson(session.getOutlineJson());
        po.setTemplateId(session.getTemplateId());
        po.setTemplateUrl(session.getTemplateUrl());
        po.setTemplateJson(session.getTemplateJson());
        po.setSlidesJson(session.getSlidesJson());
        po.setResultUrl(session.getResultUrl());
        po.setCreateTime(session.getCreateTime());
        po.setUpdateTime(session.getUpdateTime());
        return po;
    }
}
