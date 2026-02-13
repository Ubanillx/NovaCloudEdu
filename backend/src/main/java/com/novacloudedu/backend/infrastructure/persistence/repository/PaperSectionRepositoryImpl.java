package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.exam.entity.PaperSection;
import com.novacloudedu.backend.domain.exam.repository.PaperSectionRepository;
import com.novacloudedu.backend.domain.exam.valueobject.ExamPaperId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperSectionId;
import com.novacloudedu.backend.infrastructure.persistence.converter.PaperSectionConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PaperSectionMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PaperSectionPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 试卷大题仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PaperSectionRepositoryImpl implements PaperSectionRepository {

    private final PaperSectionMapper paperSectionMapper;
    private final PaperSectionConverter paperSectionConverter;

    @Override
    public PaperSection save(PaperSection section) {
        PaperSectionPO po = paperSectionConverter.toPO(section);
        if (section.getId() == null) {
            paperSectionMapper.insert(po);
            section.assignId(PaperSectionId.of(po.getId()));
        } else {
            paperSectionMapper.updateById(po);
        }
        return section;
    }

    @Override
    public Optional<PaperSection> findById(PaperSectionId id) {
        PaperSectionPO po = paperSectionMapper.selectById(id.value());
        return Optional.ofNullable(paperSectionConverter.toDomain(po));
    }

    @Override
    public List<PaperSection> findByPaperId(ExamPaperId paperId) {
        LambdaQueryWrapper<PaperSectionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PaperSectionPO::getPaperId, paperId.value())
                .orderByAsc(PaperSectionPO::getSortOrder);
        return paperSectionMapper.selectList(wrapper).stream()
                .map(paperSectionConverter::toDomain)
                .toList();
    }

    @Override
    public void deleteById(PaperSectionId id) {
        paperSectionMapper.deleteById(id.value());
    }

    @Override
    public void deleteByPaperId(ExamPaperId paperId) {
        LambdaQueryWrapper<PaperSectionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PaperSectionPO::getPaperId, paperId.value());
        paperSectionMapper.delete(wrapper);
    }
}
