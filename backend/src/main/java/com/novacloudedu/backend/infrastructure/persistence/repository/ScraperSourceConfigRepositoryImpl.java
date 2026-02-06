package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.scraper.entity.ScraperSourceConfig;
import com.novacloudedu.backend.domain.scraper.repository.ScraperSourceConfigRepository;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperConfigId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ScraperSourceConfigConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ScraperSourceConfigMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ScraperSourceConfigPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class ScraperSourceConfigRepositoryImpl implements ScraperSourceConfigRepository {

    private final ScraperSourceConfigMapper mapper;
    private final ScraperSourceConfigConverter converter;

    @Override
    public ScraperSourceConfig save(ScraperSourceConfig config) {
        ScraperSourceConfigPO po = converter.toPO(config);
        if (po.getId() == null) {
            mapper.insert(po);
            config.assignId(ScraperConfigId.of(po.getId()));
        } else {
            mapper.updateById(po);
        }
        return config;
    }

    @Override
    public Optional<ScraperSourceConfig> findById(ScraperConfigId id) {
        ScraperSourceConfigPO po = mapper.selectById(id.value());
        return Optional.ofNullable(po).map(converter::toDomain);
    }

    @Override
    public Optional<ScraperSourceConfig> findBySourceCode(String sourceCode) {
        LambdaQueryWrapper<ScraperSourceConfigPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ScraperSourceConfigPO::getSourceCode, sourceCode);
        ScraperSourceConfigPO po = mapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(converter::toDomain);
    }

    @Override
    public List<ScraperSourceConfig> findAll() {
        LambdaQueryWrapper<ScraperSourceConfigPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(ScraperSourceConfigPO::getCreateTime);
        return mapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<ScraperSourceConfig> findAllEnabled() {
        LambdaQueryWrapper<ScraperSourceConfigPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ScraperSourceConfigPO::getEnabled, true)
                .orderByDesc(ScraperSourceConfigPO::getCreateTime);
        return mapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<ScraperSourceConfig> findByPage(int page, int size) {
        Page<ScraperSourceConfigPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<ScraperSourceConfigPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(ScraperSourceConfigPO::getCreateTime);
        Page<ScraperSourceConfigPO> result = mapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public ConfigPage findByPageWithTotal(int page, int size) {
        Page<ScraperSourceConfigPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<ScraperSourceConfigPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(ScraperSourceConfigPO::getCreateTime);
        Page<ScraperSourceConfigPO> result = mapper.selectPage(pageParam, wrapper);
        List<ScraperSourceConfig> configs = result.getRecords().stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
        return new ConfigPage(configs, result.getTotal(), page, size);
    }

    @Override
    public long count() {
        return mapper.selectCount(null);
    }

    @Override
    public void deleteById(ScraperConfigId id) {
        mapper.deleteById(id.value());
    }
}
