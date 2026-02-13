package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.exam.entity.PaperSection;
import com.novacloudedu.backend.domain.exam.valueobject.ExamPaperId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperSectionId;
import com.novacloudedu.backend.domain.exam.valueobject.QuestionType;
import com.novacloudedu.backend.infrastructure.persistence.po.PaperSectionPO;
import org.springframework.stereotype.Component;

/**
 * 试卷大题领域对象与持久化对象转换器
 */
@Component
public class PaperSectionConverter {

    /**
     * PO -> Domain Entity
     */
    public PaperSection toDomain(PaperSectionPO po) {
        if (po == null) {
            return null;
        }
        QuestionType questionType = po.getQuestionType() != null
                ? QuestionType.fromCode(po.getQuestionType())
                : null;

        return PaperSection.reconstruct(
                PaperSectionId.of(po.getId()),
                ExamPaperId.of(po.getPaperId()),
                po.getTitle(),
                po.getDescription(),
                questionType,
                po.getSortOrder(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * Domain Entity -> PO
     */
    public PaperSectionPO toPO(PaperSection section) {
        if (section == null) {
            return null;
        }
        PaperSectionPO po = new PaperSectionPO();
        if (section.getId() != null) {
            po.setId(section.getId().value());
        }
        po.setPaperId(section.getPaperId().value());
        po.setTitle(section.getTitle());
        po.setDescription(section.getDescription());
        po.setQuestionType(section.getQuestionType() != null ? section.getQuestionType().getCode() : null);
        po.setSortOrder(section.getSortOrder());
        po.setCreateTime(section.getCreateTime());
        po.setUpdateTime(section.getUpdateTime());
        return po;
    }
}
