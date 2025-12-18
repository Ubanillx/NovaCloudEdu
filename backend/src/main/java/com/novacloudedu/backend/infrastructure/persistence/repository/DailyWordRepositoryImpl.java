package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.infrastructure.persistence.converter.DailyWordConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.DailyWordMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.DailyWordPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class DailyWordRepositoryImpl implements DailyWordRepository {

    private final DailyWordMapper dailyWordMapper;
    private final DailyWordConverter dailyWordConverter;

    @Override
    public DailyWord save(DailyWord dailyWord) {
        DailyWordPO po = dailyWordConverter.toPO(dailyWord);
        if (po.getId() == null) {
            dailyWordMapper.insert(po);
            dailyWord.assignId(DailyWordId.of(po.getId()));
        } else {
            dailyWordMapper.updateById(po);
        }
        return dailyWord;
    }

    @Override
    public Optional<DailyWord> findById(DailyWordId id) {
        DailyWordPO po = dailyWordMapper.selectById(id.value());
        return Optional.ofNullable(po).map(dailyWordConverter::toDomain);
    }

    @Override
    public List<DailyWord> findByPublishDate(LocalDate publishDate) {
        LambdaQueryWrapper<DailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DailyWordPO::getPublishDate, publishDate)
                .orderByDesc(DailyWordPO::getCreateTime);
        return dailyWordMapper.selectList(wrapper).stream()
                .map(dailyWordConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<DailyWord> findByCategory(String category, int page, int size) {
        Page<DailyWordPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<DailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DailyWordPO::getCategory, category)
                .orderByDesc(DailyWordPO::getPublishDate);
        Page<DailyWordPO> result = dailyWordMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(dailyWordConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<DailyWord> findByDifficulty(Difficulty difficulty, int page, int size) {
        Page<DailyWordPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<DailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DailyWordPO::getDifficulty, difficulty.getCode())
                .orderByDesc(DailyWordPO::getPublishDate);
        Page<DailyWordPO> result = dailyWordMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(dailyWordConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<DailyWord> findAll(int page, int size) {
        Page<DailyWordPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<DailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(DailyWordPO::getPublishDate);
        Page<DailyWordPO> result = dailyWordMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(dailyWordConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<DailyWord> searchByWord(String keyword, int page, int size) {
        Page<DailyWordPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<DailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(DailyWordPO::getWord, keyword)
                .or().like(DailyWordPO::getTranslation, keyword)
                .orderByDesc(DailyWordPO::getPublishDate);
        Page<DailyWordPO> result = dailyWordMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(dailyWordConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public long count() {
        return dailyWordMapper.selectCount(null);
    }

    @Override
    public long countByCategory(String category) {
        LambdaQueryWrapper<DailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DailyWordPO::getCategory, category);
        return dailyWordMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(DailyWordId id) {
        dailyWordMapper.deleteById(id.value());
    }
}
