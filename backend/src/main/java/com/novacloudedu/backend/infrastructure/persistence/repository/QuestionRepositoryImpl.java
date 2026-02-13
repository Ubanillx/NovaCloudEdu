package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.exam.entity.Question;
import com.novacloudedu.backend.domain.exam.repository.QuestionRepository;
import com.novacloudedu.backend.domain.exam.valueobject.QuestionId;
import com.novacloudedu.backend.infrastructure.persistence.converter.QuestionConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.QuestionMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.QuestionPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

/**
 * 题目仓储实现
 */
@Repository
@RequiredArgsConstructor
public class QuestionRepositoryImpl implements QuestionRepository {

    private final QuestionMapper questionMapper;
    private final QuestionConverter questionConverter;

    @Override
    public Question save(Question question) {
        QuestionPO po = questionConverter.toPO(question);
        if (question.getId() == null) {
            questionMapper.insert(po);
            question.assignId(QuestionId.of(po.getId()));
        } else {
            questionMapper.updateById(po);
        }
        return question;
    }

    @Override
    public Optional<Question> findById(QuestionId id) {
        QuestionPO po = questionMapper.selectById(id.value());
        return Optional.ofNullable(questionConverter.toDomain(po));
    }

    @Override
    public List<Question> findByIds(List<QuestionId> ids) {
        if (ids == null || ids.isEmpty()) {
            return List.of();
        }
        List<Long> idValues = ids.stream().map(QuestionId::value).toList();
        List<QuestionPO> poList = questionMapper.selectBatchIds(idValues);
        return poList.stream()
                .map(questionConverter::toDomain)
                .toList();
    }

    @Override
    public void deleteById(QuestionId id) {
        questionMapper.deleteById(id.value());
    }

    @Override
    public QuestionPage findByCondition(QuestionQueryCondition condition) {
        LambdaQueryWrapper<QuestionPO> wrapper = new LambdaQueryWrapper<>();

        if (StringUtils.hasText(condition.keyword())) {
            wrapper.like(QuestionPO::getContent, condition.keyword());
        }
        if (condition.type() != null) {
            wrapper.eq(QuestionPO::getType, condition.type().getCode());
        }
        if (condition.subject() != null) {
            wrapper.eq(QuestionPO::getSubject, condition.subject().getCode());
        }
        if (StringUtils.hasText(condition.grade())) {
            wrapper.eq(QuestionPO::getGrade, condition.grade());
        }
        if (condition.difficulty() != null) {
            wrapper.eq(QuestionPO::getDifficulty, condition.difficulty());
        }
        if (condition.creatorId() != null) {
            wrapper.eq(QuestionPO::getCreatorId, condition.creatorId().value());
        }

        wrapper.orderByDesc(QuestionPO::getCreateTime);

        Page<QuestionPO> page = new Page<>(condition.pageNum(), condition.pageSize());
        Page<QuestionPO> resultPage = questionMapper.selectPage(page, wrapper);

        List<Question> questions = resultPage.getRecords().stream()
                .map(questionConverter::toDomain)
                .toList();

        return new QuestionPage(questions, resultPage.getTotal(), condition.pageNum(), condition.pageSize());
    }
}
