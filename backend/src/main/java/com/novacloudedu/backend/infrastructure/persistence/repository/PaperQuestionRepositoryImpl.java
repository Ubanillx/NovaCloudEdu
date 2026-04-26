package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.exam.entity.PaperQuestion;
import com.novacloudedu.backend.domain.exam.repository.PaperQuestionRepository;
import com.novacloudedu.backend.domain.exam.valueobject.PaperQuestionId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperSectionId;
import com.novacloudedu.backend.infrastructure.persistence.converter.PaperQuestionConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PaperQuestionMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PaperQuestionPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * 试卷题目关联仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PaperQuestionRepositoryImpl implements PaperQuestionRepository {

    private final PaperQuestionMapper paperQuestionMapper;
    private final PaperQuestionConverter paperQuestionConverter;

    @Override
    public PaperQuestion save(PaperQuestion paperQuestion) {
        PaperQuestionPO po = paperQuestionConverter.toPO(paperQuestion);
        if (paperQuestion.getId() == null) {
            paperQuestionMapper.insert(po);
            paperQuestion.assignId(PaperQuestionId.of(po.getId()));
        } else {
            paperQuestionMapper.updateById(po);
        }
        return paperQuestion;
    }

    @Override
    public Optional<PaperQuestion> findById(PaperQuestionId id) {
        PaperQuestionPO po = paperQuestionMapper.selectById(id.value());
        return Optional.ofNullable(paperQuestionConverter.toDomain(po));
    }

    @Override
    public List<PaperQuestion> findBySectionId(PaperSectionId sectionId) {
        LambdaQueryWrapper<PaperQuestionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PaperQuestionPO::getSectionId, sectionId.value())
                .orderByAsc(PaperQuestionPO::getSortOrder);
        return paperQuestionMapper.selectList(wrapper).stream()
                .map(paperQuestionConverter::toDomain)
                .toList();
    }

    @Override
    public List<PaperQuestion> findBySectionIds(List<PaperSectionId> sectionIds) {
        if (sectionIds == null || sectionIds.isEmpty()) {
            return List.of();
        }
        List<Long> idValues = sectionIds.stream().map(PaperSectionId::value).toList();
        LambdaQueryWrapper<PaperQuestionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(PaperQuestionPO::getSectionId, idValues)
                .orderByAsc(PaperQuestionPO::getSortOrder);
        Map<Long, Integer> sectionOrder = new HashMap<>();
        for (int i = 0; i < idValues.size(); i++) {
            sectionOrder.put(idValues.get(i), i);
        }
        return paperQuestionMapper.selectList(wrapper).stream()
                .sorted(Comparator
                        .comparingInt((PaperQuestionPO po) -> sectionOrder.getOrDefault(po.getSectionId(), Integer.MAX_VALUE))
                        .thenComparing(po -> po.getSortOrder() != null ? po.getSortOrder() : 0)
                        .thenComparing(po -> po.getId() != null ? po.getId() : 0L))
                .map(paperQuestionConverter::toDomain)
                .toList();
    }

    @Override
    public void deleteById(PaperQuestionId id) {
        paperQuestionMapper.deleteById(id.value());
    }

    @Override
    public void deleteBySectionId(PaperSectionId sectionId) {
        LambdaQueryWrapper<PaperQuestionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PaperQuestionPO::getSectionId, sectionId.value());
        paperQuestionMapper.delete(wrapper);
    }

    @Override
    public void deleteBySectionIds(List<PaperSectionId> sectionIds) {
        if (sectionIds == null || sectionIds.isEmpty()) {
            return;
        }
        List<Long> idValues = sectionIds.stream().map(PaperSectionId::value).toList();
        LambdaQueryWrapper<PaperQuestionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(PaperQuestionPO::getSectionId, idValues);
        paperQuestionMapper.delete(wrapper);
    }
}
