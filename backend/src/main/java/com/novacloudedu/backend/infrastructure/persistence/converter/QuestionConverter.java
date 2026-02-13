package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.exam.entity.Question;
import com.novacloudedu.backend.domain.exam.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.QuestionPO;
import org.springframework.stereotype.Component;

/**
 * 题目领域对象与持久化对象转换器
 */
@Component
public class QuestionConverter {

    /**
     * PO -> Domain Entity
     */
    public Question toDomain(QuestionPO po) {
        if (po == null) {
            return null;
        }
        return Question.reconstruct(
                QuestionId.of(po.getId()),
                QuestionType.fromCode(po.getType()),
                Subject.fromCode(po.getSubject()),
                po.getGrade(),
                DifficultyLevel.fromLevel(po.getDifficulty()),
                po.getContent(),
                po.getOptions(),
                po.getAnswer(),
                po.getExplanation(),
                po.getKnowledgeTags(),
                po.getImageUrl(),
                QuestionSource.fromCode(po.getSource()),
                UserId.of(po.getCreatorId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * Domain Entity -> PO
     */
    public QuestionPO toPO(Question question) {
        if (question == null) {
            return null;
        }
        QuestionPO po = new QuestionPO();
        if (question.getId() != null) {
            po.setId(question.getId().value());
        }
        po.setType(question.getType().getCode());
        po.setSubject(question.getSubject().getCode());
        po.setGrade(question.getGrade());
        po.setDifficulty(question.getDifficulty().getLevel());
        po.setContent(question.getContent());
        po.setOptions(question.getOptions());
        po.setAnswer(question.getAnswer());
        po.setExplanation(question.getExplanation());
        po.setKnowledgeTags(question.getKnowledgeTags());
        po.setImageUrl(question.getImageUrl());
        po.setSource(question.getSource().getCode());
        po.setCreatorId(question.getCreatorId().value());
        po.setCreateTime(question.getCreateTime());
        po.setUpdateTime(question.getUpdateTime());
        return po;
    }
}
