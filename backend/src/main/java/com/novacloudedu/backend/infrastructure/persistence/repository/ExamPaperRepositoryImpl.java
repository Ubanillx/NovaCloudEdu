package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.exam.entity.ExamPaper;
import com.novacloudedu.backend.domain.exam.repository.ExamPaperRepository;
import com.novacloudedu.backend.domain.exam.valueobject.ExamPaperId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ExamPaperConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ExamPaperMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ExamPaperPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

/**
 * 试卷仓储实现
 */
@Repository
@RequiredArgsConstructor
public class ExamPaperRepositoryImpl implements ExamPaperRepository {

    private final ExamPaperMapper examPaperMapper;
    private final ExamPaperConverter examPaperConverter;

    @Override
    public ExamPaper save(ExamPaper paper) {
        ExamPaperPO po = examPaperConverter.toPO(paper);
        if (paper.getId() == null) {
            examPaperMapper.insert(po);
            paper.assignId(ExamPaperId.of(po.getId()));
        } else {
            examPaperMapper.updateById(po);
        }
        return paper;
    }

    @Override
    public Optional<ExamPaper> findById(ExamPaperId id) {
        ExamPaperPO po = examPaperMapper.selectById(id.value());
        return Optional.ofNullable(examPaperConverter.toDomain(po));
    }

    @Override
    public void deleteById(ExamPaperId id) {
        examPaperMapper.deleteById(id.value());
    }

    @Override
    public ExamPaperPage findByCondition(ExamPaperQueryCondition condition) {
        LambdaQueryWrapper<ExamPaperPO> wrapper = new LambdaQueryWrapper<>();

        if (StringUtils.hasText(condition.keyword())) {
            wrapper.like(ExamPaperPO::getTitle, condition.keyword());
        }
        if (condition.subject() != null) {
            wrapper.eq(ExamPaperPO::getSubject, condition.subject().getCode());
        }
        if (StringUtils.hasText(condition.grade())) {
            wrapper.eq(ExamPaperPO::getGrade, condition.grade());
        }
        if (condition.status() != null) {
            wrapper.eq(ExamPaperPO::getStatus, condition.status().getCode());
        }
        if (condition.creatorId() != null) {
            wrapper.eq(ExamPaperPO::getCreatorId, condition.creatorId().value());
        }

        wrapper.orderByDesc(ExamPaperPO::getUpdateTime);

        Page<ExamPaperPO> page = new Page<>(condition.pageNum(), condition.pageSize());
        Page<ExamPaperPO> resultPage = examPaperMapper.selectPage(page, wrapper);

        List<ExamPaper> papers = resultPage.getRecords().stream()
                .map(examPaperConverter::toDomain)
                .toList();

        return new ExamPaperPage(papers, resultPage.getTotal(), condition.pageNum(), condition.pageSize());
    }
}
