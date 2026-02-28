package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.membership.entity.AiUsageRecord;
import com.novacloudedu.backend.domain.membership.repository.AiUsageRecordRepository;
import com.novacloudedu.backend.domain.membership.valueobject.AiFeatureType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.AiUsageRecordConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AiUsageRecordMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiUsageRecordPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class AiUsageRecordRepositoryImpl implements AiUsageRecordRepository {

    private final AiUsageRecordMapper aiUsageRecordMapper;
    private final AiUsageRecordConverter aiUsageRecordConverter;

    @Override
    public AiUsageRecord save(AiUsageRecord record) {
        AiUsageRecordPO po = aiUsageRecordConverter.toPO(record);
        if (po.getId() == null) {
            aiUsageRecordMapper.insert(po);
            record.assignId(po.getId());
        } else {
            aiUsageRecordMapper.updateById(po);
        }
        return record;
    }

    @Override
    public Optional<AiUsageRecord> findByUserIdAndFeatureTypeAndDate(UserId userId, AiFeatureType featureType, LocalDate date) {
        LambdaQueryWrapper<AiUsageRecordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AiUsageRecordPO::getUserId, userId.value())
                .eq(AiUsageRecordPO::getFeatureType, featureType.getValue())
                .eq(AiUsageRecordPO::getUsageDate, date);
        AiUsageRecordPO po = aiUsageRecordMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(aiUsageRecordConverter::toDomain);
    }

    @Override
    public int sumMonthlyUsage(UserId userId, AiFeatureType featureType, int year, int month) {
        return aiUsageRecordMapper.sumMonthlyUsage(userId.value(), featureType.getValue(), year, month);
    }

    @Override
    public List<AiUsageRecord> findByUserIdAndDate(UserId userId, LocalDate date) {
        LambdaQueryWrapper<AiUsageRecordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AiUsageRecordPO::getUserId, userId.value())
                .eq(AiUsageRecordPO::getUsageDate, date);
        return aiUsageRecordMapper.selectList(wrapper).stream()
                .map(aiUsageRecordConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public Map<String, Integer> sumAllMonthlyUsage(UserId userId, int year, int month) {
        Map<String, Map<String, Object>> raw = aiUsageRecordMapper.sumAllMonthlyUsageRaw(userId.value(), year, month);
        Map<String, Integer> result = new HashMap<>();
        if (raw != null) {
            raw.forEach((key, value) -> {
                Object total = value.get("total");
                result.put(key, total instanceof Number ? ((Number) total).intValue() : 0);
            });
        }
        return result;
    }

    @Override
    public void incrementUsage(UserId userId, AiFeatureType featureType, LocalDate date) {
        // 使用 PostgreSQL INSERT ON CONFLICT DO UPDATE 原子性 upsert，避免并发竞态
        long id = com.baomidou.mybatisplus.core.toolkit.IdWorker.getId();
        aiUsageRecordMapper.upsertUsage(id, userId.value(), featureType.getValue(), date);
    }
}
