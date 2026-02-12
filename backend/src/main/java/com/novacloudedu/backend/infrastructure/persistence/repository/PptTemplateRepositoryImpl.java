package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.ppt.entity.PptTemplate;
import com.novacloudedu.backend.domain.ppt.repository.PptTemplateRepository;
import com.novacloudedu.backend.domain.ppt.valueobject.PptTemplateId;
import com.novacloudedu.backend.infrastructure.persistence.converter.PptTemplateConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PptTemplateMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PptTemplatePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * PPT模板仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PptTemplateRepositoryImpl implements PptTemplateRepository {

    private final PptTemplateMapper pptTemplateMapper;
    private final PptTemplateConverter pptTemplateConverter;

    @Override
    public PptTemplate save(PptTemplate template) {
        PptTemplatePO po = pptTemplateConverter.toPO(template);
        if (template.getId() == null) {
            pptTemplateMapper.insert(po);
            template.assignId(PptTemplateId.of(po.getId()));
        } else {
            pptTemplateMapper.updateById(po);
        }
        return template;
    }

    @Override
    public Optional<PptTemplate> findById(PptTemplateId id) {
        PptTemplatePO po = pptTemplateMapper.selectById(id.value());
        return Optional.ofNullable(pptTemplateConverter.toDomain(po));
    }

    @Override
    public void delete(PptTemplateId id) {
        pptTemplateMapper.deleteById(id.value());
    }

    @Override
    public List<PptTemplate> findAll() {
        LambdaQueryWrapper<PptTemplatePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(PptTemplatePO::getCreateTime);
        return pptTemplateMapper.selectList(wrapper).stream()
                .map(pptTemplateConverter::toDomain)
                .toList();
    }

    @Override
    public List<PptTemplate> findEnabled() {
        LambdaQueryWrapper<PptTemplatePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PptTemplatePO::getEnabled, true)
               .orderByDesc(PptTemplatePO::getCreateTime);
        return pptTemplateMapper.selectList(wrapper).stream()
                .map(pptTemplateConverter::toDomain)
                .toList();
    }
}
