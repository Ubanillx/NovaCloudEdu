package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.membership.entity.MembershipPlan;
import com.novacloudedu.backend.domain.membership.repository.MembershipPlanRepository;
import com.novacloudedu.backend.domain.membership.valueobject.PlanCode;
import com.novacloudedu.backend.infrastructure.persistence.converter.MembershipPlanConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.MembershipPlanMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.MembershipPlanPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Slf4j
@Repository
@RequiredArgsConstructor
public class MembershipPlanRepositoryImpl implements MembershipPlanRepository {

    private final MembershipPlanMapper membershipPlanMapper;
    private final MembershipPlanConverter membershipPlanConverter;

    private static final long CACHE_TTL_MS = 5 * 60 * 1000L;
    private final ConcurrentHashMap<String, CacheEntry<?>> cache = new ConcurrentHashMap<>();

    private record CacheEntry<T>(T value, long expireAt) {
        boolean isExpired() { return System.currentTimeMillis() > expireAt; }
    }

    @SuppressWarnings("unchecked")
    private <T> Optional<T> getFromCache(String key) {
        CacheEntry<?> entry = cache.get(key);
        if (entry != null && !entry.isExpired()) {
            return Optional.of((T) entry.value());
        }
        if (entry != null) cache.remove(key);
        return Optional.empty();
    }

    private <T> void putCache(String key, T value) {
        cache.put(key, new CacheEntry<>(value, System.currentTimeMillis() + CACHE_TTL_MS));
    }

    private void clearCache() {
        cache.clear();
        log.debug("MembershipPlan 本地缓存已清除");
    }

    @Override
    public MembershipPlan save(MembershipPlan plan) {
        MembershipPlanPO po = membershipPlanConverter.toPO(plan);
        if (po.getId() == null) {
            membershipPlanMapper.insert(po);
            plan.assignId(po.getId());
        } else {
            membershipPlanMapper.updateById(po);
        }
        clearCache();
        return plan;
    }

    @Override
    public Optional<MembershipPlan> findById(Long id) {
        String cacheKey = "id:" + id;
        Optional<MembershipPlan> cached = getFromCache(cacheKey);
        if (cached.isPresent()) return cached;

        MembershipPlanPO po = membershipPlanMapper.selectById(id);
        Optional<MembershipPlan> result = Optional.ofNullable(po).map(membershipPlanConverter::toDomain);
        result.ifPresent(plan -> putCache(cacheKey, plan));
        return result;
    }

    @Override
    public Optional<MembershipPlan> findByCode(PlanCode code) {
        String cacheKey = "code:" + code.getValue();
        Optional<MembershipPlan> cached = getFromCache(cacheKey);
        if (cached.isPresent()) return cached;

        LambdaQueryWrapper<MembershipPlanPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MembershipPlanPO::getCode, code.getValue());
        MembershipPlanPO po = membershipPlanMapper.selectOne(wrapper);
        Optional<MembershipPlan> result = Optional.ofNullable(po).map(membershipPlanConverter::toDomain);
        result.ifPresent(plan -> putCache(cacheKey, plan));
        return result;
    }

    @Override
    public Optional<MembershipPlan> findDefault() {
        String cacheKey = "default";
        Optional<MembershipPlan> cached = getFromCache(cacheKey);
        if (cached.isPresent()) return cached;

        LambdaQueryWrapper<MembershipPlanPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MembershipPlanPO::getIsDefault, 1);
        MembershipPlanPO po = membershipPlanMapper.selectOne(wrapper);
        Optional<MembershipPlan> result = Optional.ofNullable(po).map(membershipPlanConverter::toDomain);
        result.ifPresent(plan -> putCache(cacheKey, plan));
        return result;
    }

    @Override
    public List<MembershipPlan> findAll() {
        String cacheKey = "all";
        Optional<List<MembershipPlan>> cached = getFromCache(cacheKey);
        if (cached.isPresent()) return cached.get();

        LambdaQueryWrapper<MembershipPlanPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByAsc(MembershipPlanPO::getSortOrder);
        List<MembershipPlan> result = membershipPlanMapper.selectList(wrapper).stream()
                .map(membershipPlanConverter::toDomain)
                .collect(Collectors.toList());
        putCache(cacheKey, result);
        return result;
    }

    @Override
    public void deleteById(Long id) {
        membershipPlanMapper.deleteById(id);
        clearCache();
    }
}
