package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.exam.entity.PaperQuestion;
import com.novacloudedu.backend.domain.exam.valueobject.PaperQuestionId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperSectionId;
import com.novacloudedu.backend.domain.exam.valueobject.QuestionId;
import com.novacloudedu.backend.infrastructure.persistence.po.PaperQuestionPO;
import org.springframework.stereotype.Component;

/**
 * 试卷题目关联领域对象与持久化对象转换器
 */
@Component
public class PaperQuestionConverter {

    /**
     * PO -> Domain Entity
     */
    public PaperQuestion toDomain(PaperQuestionPO po) {
        if (po == null) {
            return null;
        }
        return PaperQuestion.reconstruct(
                PaperQuestionId.of(po.getId()),
                PaperSectionId.of(po.getSectionId()),
                QuestionId.of(po.getQuestionId()),
                po.getScore(),
                po.getSortOrder(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * Domain Entity -> PO
     */
    public PaperQuestionPO toPO(PaperQuestion pq) {
        if (pq == null) {
            return null;
        }
        PaperQuestionPO po = new PaperQuestionPO();
        if (pq.getId() != null) {
            po.setId(pq.getId().value());
        }
        po.setSectionId(pq.getSectionId().value());
        po.setQuestionId(pq.getQuestionId().value());
        po.setScore(pq.getScore());
        po.setSortOrder(pq.getSortOrder());
        po.setCreateTime(pq.getCreateTime());
        po.setUpdateTime(pq.getUpdateTime());
        return po;
    }
}
