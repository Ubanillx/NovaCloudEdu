package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.grading.entity.GradingResult;
import com.novacloudedu.backend.domain.grading.repository.GradingResultRepository;
import com.novacloudedu.backend.domain.grading.valueobject.GradingResultId;
import com.novacloudedu.backend.domain.grading.valueobject.SubmissionId;
import com.novacloudedu.backend.infrastructure.persistence.converter.GradingResultConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.GradingResultMapper;
import com.novacloudedu.backend.infrastructure.persistence.mapper.QuestionGradingMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.GradingResultPO;
import com.novacloudedu.backend.infrastructure.persistence.po.QuestionGradingPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class GradingResultRepositoryImpl implements GradingResultRepository {

    private final GradingResultMapper resultMapper;
    private final QuestionGradingMapper questionMapper;
    private final GradingResultConverter converter;

    @Override
    public GradingResult save(GradingResult result) {
        GradingResultPO po = converter.toPO(result);

        if (po.getId() != null && resultMapper.selectById(po.getId()) != null) {
            resultMapper.updateById(po);
        } else {
            resultMapper.insert(po);
        }

        if (result.getId() == null) {
            result.assignId(GradingResultId.of(po.getId()));
        }

        // 保存单题批改详情
        Long resultId = po.getId();
        if (result.getQuestionGradings() != null && !result.getQuestionGradings().isEmpty()) {
            // 先删除旧的
            LambdaQueryWrapper<QuestionGradingPO> deleteWrapper = new LambdaQueryWrapper<QuestionGradingPO>()
                    .eq(QuestionGradingPO::getGradingResultId, resultId);
            questionMapper.delete(deleteWrapper);

            // 重新插入
            for (var grading : result.getQuestionGradings()) {
                grading.assignGradingResultId(resultId);
                QuestionGradingPO qpo = converter.toQuestionPO(grading, resultId);
                questionMapper.insert(qpo);
            }
        }

        return result;
    }

    @Override
    public Optional<GradingResult> findById(GradingResultId id) {
        GradingResultPO po = resultMapper.selectById(id.getValue());
        if (po == null) return Optional.empty();

        List<QuestionGradingPO> questions = questionMapper.selectList(
                new LambdaQueryWrapper<QuestionGradingPO>()
                        .eq(QuestionGradingPO::getGradingResultId, id.getValue())
                        .orderByAsc(QuestionGradingPO::getQuestionIndex));

        return Optional.of(converter.toDomain(po, questions));
    }

    @Override
    public Optional<GradingResult> findBySubmissionId(SubmissionId submissionId) {
        GradingResultPO po = resultMapper.selectOne(
                new LambdaQueryWrapper<GradingResultPO>()
                        .eq(GradingResultPO::getSubmissionId, submissionId.getValue())
                        .orderByDesc(GradingResultPO::getCreateTime)
                        .last("LIMIT 1"));
        if (po == null) return Optional.empty();

        List<QuestionGradingPO> questions = questionMapper.selectList(
                new LambdaQueryWrapper<QuestionGradingPO>()
                        .eq(QuestionGradingPO::getGradingResultId, po.getId())
                        .orderByAsc(QuestionGradingPO::getQuestionIndex));

        return Optional.of(converter.toDomain(po, questions));
    }
}
