package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.grading.entity.GradingResult;
import com.novacloudedu.backend.domain.grading.entity.QuestionGrading;
import com.novacloudedu.backend.domain.grading.valueobject.GradingResultId;
import com.novacloudedu.backend.domain.grading.valueobject.SubmissionId;
import com.novacloudedu.backend.infrastructure.persistence.po.GradingResultPO;
import com.novacloudedu.backend.infrastructure.persistence.po.QuestionGradingPO;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class GradingResultConverter {

    public GradingResultPO toPO(GradingResult entity) {
        GradingResultPO po = new GradingResultPO();
        if (entity.getId() != null) {
            po.setId(entity.getId().getValue());
        }
        po.setSubmissionId(entity.getSubmissionId().getValue());
        po.setTotalScore(entity.getTotalScore());
        po.setMaxScore(entity.getMaxScore());
        po.setOverallComment(entity.getOverallComment());
        po.setModelId(entity.getModelId());
        po.setGradingTime(entity.getGradingTime());
        po.setCreateTime(entity.getCreateTime());
        return po;
    }

    public QuestionGradingPO toQuestionPO(QuestionGrading entity, Long gradingResultId) {
        QuestionGradingPO po = new QuestionGradingPO();
        if (entity.getId() != null) {
            po.setId(entity.getId());
        }
        po.setGradingResultId(gradingResultId);
        po.setQuestionIndex(entity.getQuestionIndex());
        po.setQuestionContent(entity.getQuestionContent());
        po.setQuestionType(entity.getQuestionType());
        po.setStudentAnswer(entity.getStudentAnswer());
        po.setStandardAnswer(entity.getStandardAnswer());
        po.setScore(entity.getScore());
        po.setMaxScore(entity.getMaxScore());
        po.setErrorCategories(entity.getErrorCategories());
        po.setErrorDetail(entity.getErrorDetail());
        po.setKnowledgePoints(entity.getKnowledgePoints());
        po.setComment(entity.getComment());
        po.setSimilarQuestionId(entity.getSimilarQuestionId());
        po.setCreateTime(entity.getCreateTime());
        return po;
    }

    public GradingResult toDomain(GradingResultPO po, List<QuestionGradingPO> questionPOs) {
        List<QuestionGrading> gradings = questionPOs != null
                ? questionPOs.stream().map(this::toQuestionDomain).toList()
                : List.of();

        return GradingResult.reconstruct(
                GradingResultId.of(po.getId()),
                SubmissionId.of(po.getSubmissionId()),
                po.getTotalScore(),
                po.getMaxScore(),
                po.getOverallComment(),
                gradings,
                po.getModelId(),
                po.getGradingTime(),
                po.getCreateTime()
        );
    }

    private QuestionGrading toQuestionDomain(QuestionGradingPO po) {
        return QuestionGrading.reconstruct(
                po.getId(),
                po.getGradingResultId(),
                po.getQuestionIndex() != null ? po.getQuestionIndex() : 0,
                po.getQuestionContent(),
                po.getQuestionType(),
                po.getStudentAnswer(),
                po.getStandardAnswer(),
                po.getScore() != null ? po.getScore() : 0,
                po.getMaxScore() != null ? po.getMaxScore() : 0,
                po.getErrorCategories(),
                po.getErrorDetail(),
                po.getKnowledgePoints(),
                po.getComment(),
                po.getSimilarQuestionId(),
                po.getCreateTime()
        );
    }
}
