package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.exam.entity.ExamPaper;
import com.novacloudedu.backend.domain.exam.valueobject.ExamPaperId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperStatus;
import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.ExamPaperPO;
import org.springframework.stereotype.Component;

/**
 * 试卷领域对象与持久化对象转换器
 */
@Component
public class ExamPaperConverter {

    /**
     * PO -> Domain Entity
     */
    public ExamPaper toDomain(ExamPaperPO po) {
        if (po == null) {
            return null;
        }
        return ExamPaper.reconstruct(
                ExamPaperId.of(po.getId()),
                po.getTitle(),
                po.getSubtitle(),
                Subject.fromCode(po.getSubject()),
                po.getGrade(),
                po.getTotalScore(),
                po.getDurationMin(),
                po.getLayout(),
                PaperStatus.fromCode(po.getStatus()),
                po.getTemplateId(),
                UserId.of(po.getCreatorId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * Domain Entity -> PO
     */
    public ExamPaperPO toPO(ExamPaper paper) {
        if (paper == null) {
            return null;
        }
        ExamPaperPO po = new ExamPaperPO();
        if (paper.getId() != null) {
            po.setId(paper.getId().value());
        }
        po.setTitle(paper.getTitle());
        po.setSubtitle(paper.getSubtitle());
        po.setSubject(paper.getSubject().getCode());
        po.setGrade(paper.getGrade());
        po.setTotalScore(paper.getTotalScore());
        po.setDurationMin(paper.getDurationMin());
        po.setLayout(paper.getLayout());
        po.setStatus(paper.getStatus().getCode());
        po.setTemplateId(paper.getTemplateId());
        po.setCreatorId(paper.getCreatorId().value());
        po.setCreateTime(paper.getCreateTime());
        po.setUpdateTime(paper.getUpdateTime());
        return po;
    }
}
