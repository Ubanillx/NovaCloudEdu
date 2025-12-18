package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.UserDailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserDailyArticleConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserDailyArticleMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserDailyArticlePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class UserDailyArticleRepositoryImpl implements UserDailyArticleRepository {

    private final UserDailyArticleMapper userDailyArticleMapper;
    private final UserDailyArticleConverter userDailyArticleConverter;

    @Override
    public UserDailyArticle save(UserDailyArticle userDailyArticle) {
        UserDailyArticlePO po = userDailyArticleConverter.toPO(userDailyArticle);
        if (po.getId() == null) {
            userDailyArticleMapper.insert(po);
            userDailyArticle.assignId(po.getId());
        } else {
            userDailyArticleMapper.updateById(po);
        }
        return userDailyArticle;
    }

    @Override
    public Optional<UserDailyArticle> findById(Long id) {
        UserDailyArticlePO po = userDailyArticleMapper.selectById(id);
        return Optional.ofNullable(po).map(userDailyArticleConverter::toDomain);
    }

    @Override
    public Optional<UserDailyArticle> findByUserIdAndArticleId(UserId userId, DailyArticleId articleId) {
        LambdaQueryWrapper<UserDailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyArticlePO::getUserId, userId.value())
                .eq(UserDailyArticlePO::getArticleId, articleId.value());
        UserDailyArticlePO po = userDailyArticleMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(userDailyArticleConverter::toDomain);
    }

    @Override
    public List<UserDailyArticle> findByUserId(UserId userId, int page, int size) {
        Page<UserDailyArticlePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserDailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyArticlePO::getUserId, userId.value())
                .orderByDesc(UserDailyArticlePO::getCreateTime);
        Page<UserDailyArticlePO> result = userDailyArticleMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userDailyArticleConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserDailyArticle> findReadByUserId(UserId userId, int page, int size) {
        Page<UserDailyArticlePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserDailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyArticlePO::getUserId, userId.value())
                .eq(UserDailyArticlePO::getIsRead, 1)
                .orderByDesc(UserDailyArticlePO::getUpdateTime);
        Page<UserDailyArticlePO> result = userDailyArticleMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userDailyArticleConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserDailyArticle> findLikedByUserId(UserId userId, int page, int size) {
        Page<UserDailyArticlePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserDailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyArticlePO::getUserId, userId.value())
                .eq(UserDailyArticlePO::getIsLiked, 1)
                .orderByDesc(UserDailyArticlePO::getUpdateTime);
        Page<UserDailyArticlePO> result = userDailyArticleMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userDailyArticleConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserDailyArticle> findCollectedByUserId(UserId userId, int page, int size) {
        Page<UserDailyArticlePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserDailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyArticlePO::getUserId, userId.value())
                .eq(UserDailyArticlePO::getIsCollected, 1)
                .orderByDesc(UserDailyArticlePO::getUpdateTime);
        Page<UserDailyArticlePO> result = userDailyArticleMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userDailyArticleConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public long countByUserId(UserId userId) {
        LambdaQueryWrapper<UserDailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyArticlePO::getUserId, userId.value());
        return userDailyArticleMapper.selectCount(wrapper);
    }

    @Override
    public long countReadByUserId(UserId userId) {
        LambdaQueryWrapper<UserDailyArticlePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDailyArticlePO::getUserId, userId.value())
                .eq(UserDailyArticlePO::getIsRead, 1);
        return userDailyArticleMapper.selectCount(wrapper);
    }
}
