package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.recommendation.entity.UserPreference;
import com.novacloudedu.backend.domain.recommendation.repository.UserPreferenceRepository;
import com.novacloudedu.backend.domain.recommendation.valueobject.PreferenceType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserPreferenceConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserPreferenceMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserPreferencePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class UserPreferenceRepositoryImpl implements UserPreferenceRepository {

    private final UserPreferenceMapper userPreferenceMapper;
    private final UserPreferenceConverter userPreferenceConverter;

    @Override
    public UserPreference save(UserPreference preference) {
        UserPreferencePO po = userPreferenceConverter.toPO(preference);
        if (po.getId() == null) {
            userPreferenceMapper.insert(po);
            preference.assignId(po.getId());
        } else {
            userPreferenceMapper.updateById(po);
        }
        return preference;
    }

    @Override
    public Optional<UserPreference> findById(Long id) {
        UserPreferencePO po = userPreferenceMapper.selectById(id);
        return Optional.ofNullable(po).map(userPreferenceConverter::toDomain);
    }

    @Override
    public Optional<UserPreference> findByUserIdAndTypeAndKey(UserId userId, PreferenceType type, String key) {
        LambdaQueryWrapper<UserPreferencePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserPreferencePO::getUserId, userId.value())
                .eq(UserPreferencePO::getPreferenceType, type.getCode())
                .eq(UserPreferencePO::getPreferenceKey, key);
        UserPreferencePO po = userPreferenceMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(userPreferenceConverter::toDomain);
    }

    @Override
    public List<UserPreference> findByUserId(UserId userId) {
        LambdaQueryWrapper<UserPreferencePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserPreferencePO::getUserId, userId.value())
                .orderByDesc(UserPreferencePO::getPreferenceValue);
        return userPreferenceMapper.selectList(wrapper).stream()
                .map(userPreferenceConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserPreference> findByUserIdAndType(UserId userId, PreferenceType type) {
        LambdaQueryWrapper<UserPreferencePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserPreferencePO::getUserId, userId.value())
                .eq(UserPreferencePO::getPreferenceType, type.getCode())
                .orderByDesc(UserPreferencePO::getPreferenceValue);
        return userPreferenceMapper.selectList(wrapper).stream()
                .map(userPreferenceConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserPreference> findTopByUserIdAndType(UserId userId, PreferenceType type, int limit) {
        LambdaQueryWrapper<UserPreferencePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserPreferencePO::getUserId, userId.value())
                .eq(UserPreferencePO::getPreferenceType, type.getCode())
                .orderByDesc(UserPreferencePO::getPreferenceValue)
                .last("LIMIT " + limit);
        return userPreferenceMapper.selectList(wrapper).stream()
                .map(userPreferenceConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteByUserId(UserId userId) {
        LambdaQueryWrapper<UserPreferencePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserPreferencePO::getUserId, userId.value());
        userPreferenceMapper.delete(wrapper);
    }
}
