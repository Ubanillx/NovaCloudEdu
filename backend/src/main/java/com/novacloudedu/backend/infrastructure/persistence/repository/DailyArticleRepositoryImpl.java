package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.infrastructure.persistence.converter.DailyArticleConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.DailyArticleMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.DailyArticlePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class DailyArticleRepositoryImpl implements DailyArticleRepository {

    private final DailyArticleMapper dailyArticleMapper;
    private final DailyArticleConverter dailyArticleConverter;

    @Override
    public DailyArticle save(DailyArticle dailyArticle) {
        DailyArticlePO po = dailyArticleConverter.toPO(dailyArticle);
        if (po.getId() == null) {
            dailyArticleMapper.insert(po);
            dailyArticle.assignId(DailyArticleId.of(po.getId()));
        } else {
            dailyArticleMapper.updateById(po);
        }
        return dailyArticle;
    }

    @Override
    public Optional<DailyArticle> findById(DailyArticleId id) {
        DailyArticlePO po = dailyArticleMapper.selectById(id.value());
        return Optional.ofNullable(po).map(dailyArticleConverter::toDomain);
    }

    @Override
    public List<DailyArticle> findByPublishDate(LocalDate publishDate) {
        LambdaQueryWrapper<DailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DailyArticlePO::getPublishDate, publishDate)
                .orderByDesc(DailyArticlePO::getCreateTime);
        return dailyArticleMapper.selectList(wrapper).stream()
                .map(dailyArticleConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<DailyArticle> findByCategory(String category, int page, int size) {
        Page<DailyArticlePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<DailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DailyArticlePO::getCategory, category)
                .orderByDesc(DailyArticlePO::getPublishDate);
        Page<DailyArticlePO> result = dailyArticleMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(dailyArticleConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<DailyArticle> findByDifficulty(Difficulty difficulty, int page, int size) {
        Page<DailyArticlePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<DailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DailyArticlePO::getDifficulty, difficulty.getCode())
                .orderByDesc(DailyArticlePO::getPublishDate);
        Page<DailyArticlePO> result = dailyArticleMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(dailyArticleConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<DailyArticle> findAll(int page, int size) {
        Page<DailyArticlePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<DailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(DailyArticlePO::getPublishDate);
        Page<DailyArticlePO> result = dailyArticleMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(dailyArticleConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<DailyArticle> searchByKeyword(String keyword, int page, int size) {
        Page<DailyArticlePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<DailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w.like(DailyArticlePO::getTitle, keyword)
                        .or().like(DailyArticlePO::getContent, keyword)
                        .or().like(DailyArticlePO::getSummary, keyword))
                .orderByDesc(DailyArticlePO::getPublishDate);
        Page<DailyArticlePO> result = dailyArticleMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(dailyArticleConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public long count() {
        return dailyArticleMapper.selectCount(null);
    }

    @Override
    public long countByCategory(String category) {
        LambdaQueryWrapper<DailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DailyArticlePO::getCategory, category);
        return dailyArticleMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(DailyArticleId id) {
        dailyArticleMapper.deleteById(id.value());
    }
}
