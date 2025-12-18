package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.UserDailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserDailyWordConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserDailyWordMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserDailyWordPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class UserDailyWordRepositoryImpl implements UserDailyWordRepository {

    private final UserDailyWordMapper userDailyWordMapper;
    private final UserDailyWordConverter userDailyWordConverter;

    @Override
    public UserDailyWord save(UserDailyWord userDailyWord) {
        UserDailyWordPO po = userDailyWordConverter.toPO(userDailyWord);
        if (po.getId() == null) {
            userDailyWordMapper.insert(po);
            userDailyWord.assignId(po.getId());
        } else {
            userDailyWordMapper.updateById(po);
        }
        return userDailyWord;
    }

    @Override
    public Optional<UserDailyWord> findById(Long id) {
        UserDailyWordPO po = userDailyWordMapper.selectById(id);
        return Optional.ofNullable(po).map(userDailyWordConverter::toDomain);
    }

    @Override
    public Optional<UserDailyWord> findByUserIdAndWordId(UserId userId, DailyWordId wordId) {
        LambdaQueryWrapper<UserDailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyWordPO::getUserId, userId.value())
                .eq(UserDailyWordPO::getWordId, wordId.value());
        UserDailyWordPO po = userDailyWordMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(userDailyWordConverter::toDomain);
    }

    @Override
    public List<UserDailyWord> findByUserId(UserId userId, int page, int size) {
        Page<UserDailyWordPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserDailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyWordPO::getUserId, userId.value())
                .orderByDesc(UserDailyWordPO::getCreateTime);
        Page<UserDailyWordPO> result = userDailyWordMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userDailyWordConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserDailyWord> findStudiedByUserId(UserId userId, int page, int size) {
        Page<UserDailyWordPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserDailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyWordPO::getUserId, userId.value())
                .eq(UserDailyWordPO::getIsStudied, 1)
                .orderByDesc(UserDailyWordPO::getUpdateTime);
        Page<UserDailyWordPO> result = userDailyWordMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userDailyWordConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserDailyWord> findCollectedByUserId(UserId userId, int page, int size) {
        Page<UserDailyWordPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserDailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyWordPO::getUserId, userId.value())
                .eq(UserDailyWordPO::getIsCollected, 1)
                .orderByDesc(UserDailyWordPO::getUpdateTime);
        Page<UserDailyWordPO> result = userDailyWordMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userDailyWordConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public long countByUserId(UserId userId) {
        LambdaQueryWrapper<UserDailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyWordPO::getUserId, userId.value());
        return userDailyWordMapper.selectCount(wrapper);
    }

    @Override
    public long countStudiedByUserId(UserId userId) {
        LambdaQueryWrapper<UserDailyWordPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyWordPO::getUserId, userId.value())
                .eq(UserDailyWordPO::getIsStudied, 1);
        return userDailyWordMapper.selectCount(wrapper);
    }
}
