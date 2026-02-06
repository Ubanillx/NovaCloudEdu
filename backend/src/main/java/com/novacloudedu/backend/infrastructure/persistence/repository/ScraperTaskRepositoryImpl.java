package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.scraper.entity.ScraperTask;
import com.novacloudedu.backend.domain.scraper.repository.ScraperTaskRepository;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperConfigId;
import com.novacloudedu.backend.domain.scraper.valueobject.ScraperTaskId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ScraperTaskConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ScraperTaskMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ScraperTaskPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class ScraperTaskRepositoryImpl implements ScraperTaskRepository {

    private final ScraperTaskMapper mapper;
    private final ScraperTaskConverter converter;

    @Override
    public ScraperTask save(ScraperTask task) {
        ScraperTaskPO po = converter.toPO(task);
        if (po.getId() == null) {
            mapper.insert(po);
            task.assignId(ScraperTaskId.of(po.getId()));
        } else {
            mapper.updateById(po);
        }
        return task;
    }

    @Override
    public Optional<ScraperTask> findById(ScraperTaskId id) {
        ScraperTaskPO po = mapper.selectById(id.value());
        return Optional.ofNullable(po).map(converter::toDomain);
    }

    @Override
    public List<ScraperTask> findByConfigId(ScraperConfigId configId, int page, int size) {
        Page<ScraperTaskPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<ScraperTaskPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ScraperTaskPO::getConfigId, configId.value())
                .orderByDesc(ScraperTaskPO::getCreateTime);
        Page<ScraperTaskPO> result = mapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<ScraperTask> findByDateRange(LocalDateTime startTime, LocalDateTime endTime, int page, int size) {
        Page<ScraperTaskPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<ScraperTaskPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.between(ScraperTaskPO::getCreateTime, startTime, endTime)
                .orderByDesc(ScraperTaskPO::getCreateTime);
        Page<ScraperTaskPO> result = mapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<ScraperTask> findAll(int page, int size) {
        Page<ScraperTaskPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<ScraperTaskPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(ScraperTaskPO::getCreateTime);
        Page<ScraperTaskPO> result = mapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<ScraperTask> findLatestByConfigId(ScraperConfigId configId) {
        LambdaQueryWrapper<ScraperTaskPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ScraperTaskPO::getConfigId, configId.value())
                .orderByDesc(ScraperTaskPO::getCreateTime)
                .last("LIMIT 1");
        ScraperTaskPO po = mapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(converter::toDomain);
    }

    @Override
    public long count() {
        return mapper.selectCount(null);
    }

    @Override
    public long countByConfigId(ScraperConfigId configId) {
        LambdaQueryWrapper<ScraperTaskPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ScraperTaskPO::getConfigId, configId.value());
        return mapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(ScraperTaskId id) {
        mapper.deleteById(id.value());
    }

    @Override
    public TaskPage findByConfigIdWithTotal(ScraperConfigId configId, int page, int size) {
        Page<ScraperTaskPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<ScraperTaskPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ScraperTaskPO::getConfigId, configId.value())
                .orderByDesc(ScraperTaskPO::getCreateTime);
        Page<ScraperTaskPO> result = mapper.selectPage(pageParam, wrapper);
        List<ScraperTask> tasks = result.getRecords().stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
        return new TaskPage(tasks, result.getTotal(), page, size);
    }

    @Override
    public TaskPage findAllWithTotal(int page, int size) {
        Page<ScraperTaskPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<ScraperTaskPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(ScraperTaskPO::getCreateTime);
        Page<ScraperTaskPO> result = mapper.selectPage(pageParam, wrapper);
        List<ScraperTask> tasks = result.getRecords().stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
        return new TaskPage(tasks, result.getTotal(), page, size);
    }
}
