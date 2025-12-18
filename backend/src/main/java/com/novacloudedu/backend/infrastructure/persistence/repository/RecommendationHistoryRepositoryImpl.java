package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.recommendation.entity.RecommendationHistory;
import com.novacloudedu.backend.domain.recommendation.repository.RecommendationHistoryRepository;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.RecommendationHistoryConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.RecommendationHistoryMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.RecommendationHistoryPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class RecommendationHistoryRepositoryImpl implements RecommendationHistoryRepository {

    private final RecommendationHistoryMapper recommendationHistoryMapper;
    private final RecommendationHistoryConverter recommendationHistoryConverter;

    @Override
    public RecommendationHistory save(RecommendationHistory history) {
        RecommendationHistoryPO po = recommendationHistoryConverter.toPO(history);
        if (po.getId() == null) {
            recommendationHistoryMapper.insert(po);
            history.assignId(po.getId());
        } else {
            recommendationHistoryMapper.updateById(po);
        }
        return history;
    }

    @Override
    public Optional<RecommendationHistory> findById(Long id) {
        RecommendationHistoryPO po = recommendationHistoryMapper.selectById(id);
        return Optional.ofNullable(po).map(recommendationHistoryConverter::toDomain);
    }

    @Override
    public Optional<RecommendationHistory> findByUserIdAndTarget(UserId userId, TargetType targetType, Long targetId) {
        LambdaQueryWrapper<RecommendationHistoryPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RecommendationHistoryPO::getUserId, userId.value())
                .eq(RecommendationHistoryPO::getTargetType, targetType.getCode())
                .eq(RecommendationHistoryPO::getTargetId, targetId)
                .orderByDesc(RecommendationHistoryPO::getCreateTime)
                .last("LIMIT 1");
        RecommendationHistoryPO po = recommendationHistoryMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(recommendationHistoryConverter::toDomain);
    }

    @Override
    public List<RecommendationHistory> findByUserId(UserId userId, int page, int size) {
        Page<RecommendationHistoryPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<RecommendationHistoryPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RecommendationHistoryPO::getUserId, userId.value())
                .orderByDesc(RecommendationHistoryPO::getCreateTime);
        Page<RecommendationHistoryPO> result = recommendationHistoryMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(recommendationHistoryConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<RecommendationHistory> findByUserIdAndTargetType(UserId userId, TargetType targetType, int page, int size) {
        Page<RecommendationHistoryPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<RecommendationHistoryPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RecommendationHistoryPO::getUserId, userId.value())
                .eq(RecommendationHistoryPO::getTargetType, targetType.getCode())
                .orderByDesc(RecommendationHistoryPO::getCreateTime);
        Page<RecommendationHistoryPO> result = recommendationHistoryMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(recommendationHistoryConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<Long> findRecommendedTargetIds(UserId userId, TargetType targetType, LocalDateTime afterTime) {
        LambdaQueryWrapper<RecommendationHistoryPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RecommendationHistoryPO::getUserId, userId.value())
                .eq(RecommendationHistoryPO::getTargetType, targetType.getCode())
                .ge(RecommendationHistoryPO::getCreateTime, afterTime)
                .select(RecommendationHistoryPO::getTargetId);
        return recommendationHistoryMapper.selectList(wrapper).stream()
                .map(RecommendationHistoryPO::getTargetId)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteByUserId(UserId userId) {
        LambdaQueryWrapper<RecommendationHistoryPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RecommendationHistoryPO::getUserId, userId.value());
        recommendationHistoryMapper.delete(wrapper);
    }
}
