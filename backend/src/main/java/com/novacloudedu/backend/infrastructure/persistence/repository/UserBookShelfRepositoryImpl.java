package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.book.entity.UserBookShelf;
import com.novacloudedu.backend.domain.book.repository.UserBookShelfRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserBookShelfConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserBookShelfMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserBookShelfPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class UserBookShelfRepositoryImpl implements UserBookShelfRepository {

    private final UserBookShelfMapper userBookShelfMapper;
    private final UserBookShelfConverter userBookShelfConverter;

    @Override
    public UserBookShelf save(UserBookShelf shelf) {
        UserBookShelfPO po = userBookShelfConverter.toUserBookShelfPO(shelf);
        
        LambdaQueryWrapper<UserBookShelfPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBookShelfPO::getUserId, po.getUserId())
                .eq(UserBookShelfPO::getBookId, po.getBookId());
        UserBookShelfPO existing = userBookShelfMapper.selectOne(wrapper);
        
        if (existing == null) {
            userBookShelfMapper.insert(po);
        } else {
            po.setId(existing.getId());
            userBookShelfMapper.updateById(po);
        }
        return shelf;
    }

    @Override
    public Optional<UserBookShelf> findByUserIdAndBookId(UserId userId, BookId bookId) {
        LambdaQueryWrapper<UserBookShelfPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBookShelfPO::getUserId, userId.value())
                .eq(UserBookShelfPO::getBookId, bookId.value());
        UserBookShelfPO po = userBookShelfMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(userBookShelfConverter::toUserBookShelf);
    }

    @Override
    public List<UserBookShelf> findByUserId(UserId userId, int page, int size) {
        Page<UserBookShelfPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserBookShelfPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBookShelfPO::getUserId, userId.value())
                .orderByDesc(UserBookShelfPO::getAddedTime);
        Page<UserBookShelfPO> result = userBookShelfMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userBookShelfConverter::toUserBookShelf)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserBookShelf> findByUserIdOrderByLastReadTime(UserId userId, int page, int size) {
        Page<UserBookShelfPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserBookShelfPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBookShelfPO::getUserId, userId.value())
                .orderByDesc(UserBookShelfPO::getLastReadTime);
        Page<UserBookShelfPO> result = userBookShelfMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userBookShelfConverter::toUserBookShelf)
                .collect(Collectors.toList());
    }

    @Override
    public long countByUserId(UserId userId) {
        LambdaQueryWrapper<UserBookShelfPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBookShelfPO::getUserId, userId.value());
        return userBookShelfMapper.selectCount(wrapper);
    }

    @Override
    public void delete(UserId userId, BookId bookId) {
        LambdaQueryWrapper<UserBookShelfPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBookShelfPO::getUserId, userId.value())
                .eq(UserBookShelfPO::getBookId, bookId.value());
        userBookShelfMapper.delete(wrapper);
    }
}
