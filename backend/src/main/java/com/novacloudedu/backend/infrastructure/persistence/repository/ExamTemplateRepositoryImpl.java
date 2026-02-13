package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.exam.entity.ExamTemplate;
import com.novacloudedu.backend.domain.exam.repository.ExamTemplateRepository;
import com.novacloudedu.backend.domain.exam.valueobject.ExamTemplateId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ExamTemplateConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ExamTemplateMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ExamTemplatePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 试卷模板仓储实现
 */
@Repository
@RequiredArgsConstructor
public class ExamTemplateRepositoryImpl implements ExamTemplateRepository {

    private final ExamTemplateMapper examTemplateMapper;
    private final ExamTemplateConverter examTemplateConverter;

    @Override
    public ExamTemplate save(ExamTemplate template) {
        ExamTemplatePO po = examTemplateConverter.toPO(template);
        if (template.getId() == null) {
            examTemplateMapper.insert(po);
            template.assignId(ExamTemplateId.of(po.getId()));
        } else {
            examTemplateMapper.updateById(po);
        }
        return template;
    }

    @Override
    public Optional<ExamTemplate> findById(ExamTemplateId id) {
        ExamTemplatePO po = examTemplateMapper.selectById(id.value());
        return Optional.ofNullable(examTemplateConverter.toDomain(po));
    }

    @Override
    public void deleteById(ExamTemplateId id) {
        examTemplateMapper.deleteById(id.value());
    }

    @Override
    public List<ExamTemplate> findEnabled() {
        LambdaQueryWrapper<ExamTemplatePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ExamTemplatePO::getIsEnabled, true);
        wrapper.orderByDesc(ExamTemplatePO::getIsSystem);
        wrapper.orderByDesc(ExamTemplatePO::getUpdateTime);
        return examTemplateMapper.selectList(wrapper).stream()
                .map(examTemplateConverter::toDomain)
                .toList();
    }

    @Override
    public List<ExamTemplate> findAll() {
        LambdaQueryWrapper<ExamTemplatePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(ExamTemplatePO::getIsSystem);
        wrapper.orderByDesc(ExamTemplatePO::getUpdateTime);
        return examTemplateMapper.selectList(wrapper).stream()
                .map(examTemplateConverter::toDomain)
                .toList();
    }
}
