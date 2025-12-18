package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.dailylearning.entity.UserWordBook;
import com.novacloudedu.backend.domain.dailylearning.repository.UserWordBookRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.LearningStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserWordBookConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserWordBookMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserWordBookPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class UserWordBookRepositoryImpl implements UserWordBookRepository {

    private final UserWordBookMapper userWordBookMapper;
    private final UserWordBookConverter userWordBookConverter;

    @Override
    public UserWordBook save(UserWordBook userWordBook) {
        UserWordBookPO po = userWordBookConverter.toPO(userWordBook);
        if (po.getId() == null) {
            userWordBookMapper.insert(po);
            userWordBook.assignId(po.getId());
        } else {
            userWordBookMapper.updateById(po);
        }
        return userWordBook;
    }

    @Override
    public Optional<UserWordBook> findById(Long id) {
        UserWordBookPO po = userWordBookMapper.selectById(id);
        return Optional.ofNullable(po).map(userWordBookConverter::toDomain);
    }

    @Override
    public Optional<UserWordBook> findByUserIdAndWordId(UserId userId, DailyWordId wordId) {
        LambdaQueryWrapper<UserWordBookPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordBookPO::getUserId, userId.value())
                .eq(UserWordBookPO::getWordId, wordId.value());
        UserWordBookPO po = userWordBookMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(userWordBookConverter::toDomain);
    }

    @Override
    public List<UserWordBook> findByUserId(UserId userId, int page, int size) {
        Page<UserWordBookPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserWordBookPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordBookPO::getUserId, userId.value())
                .orderByDesc(UserWordBookPO::getCollectedTime);
        Page<UserWordBookPO> result = userWordBookMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userWordBookConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserWordBook> findByUserIdAndStatus(UserId userId, LearningStatus status, int page, int size) {
        Page<UserWordBookPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserWordBookPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordBookPO::getUserId, userId.value())
                .eq(UserWordBookPO::getLearningStatus, status.getCode())
                .orderByDesc(UserWordBookPO::getCollectedTime);
        Page<UserWordBookPO> result = userWordBookMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userWordBookConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public long countByUserId(UserId userId) {
        LambdaQueryWrapper<UserWordBookPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordBookPO::getUserId, userId.value());
        return userWordBookMapper.selectCount(wrapper);
    }

    @Override
    public long countByUserIdAndStatus(UserId userId, LearningStatus status) {
        LambdaQueryWrapper<UserWordBookPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordBookPO::getUserId, userId.value())
                .eq(UserWordBookPO::getLearningStatus, status.getCode());
        return userWordBookMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(Long id) {
        userWordBookMapper.deleteById(id);
    }
}
