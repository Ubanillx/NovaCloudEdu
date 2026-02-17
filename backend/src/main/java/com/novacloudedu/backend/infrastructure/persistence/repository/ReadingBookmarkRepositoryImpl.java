package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.book.entity.ReadingBookmark;
import com.novacloudedu.backend.domain.book.repository.ReadingBookmarkRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ReadingBookmarkConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ReadingBookmarkMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ReadingBookmarkPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class ReadingBookmarkRepositoryImpl implements ReadingBookmarkRepository {

    private final ReadingBookmarkMapper readingBookmarkMapper;
    private final ReadingBookmarkConverter converter;

    @Override
    public ReadingBookmark save(ReadingBookmark bookmark) {
        ReadingBookmarkPO po = converter.toPO(bookmark);
        if (po.getId() == null) {
            readingBookmarkMapper.insert(po);
            return converter.toDomain(po);
        } else {
            readingBookmarkMapper.updateById(po);
            return bookmark;
        }
    }

    @Override
    public Optional<ReadingBookmark> findById(Long id) {
        ReadingBookmarkPO po = readingBookmarkMapper.selectById(id);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<ReadingBookmark> findByUserIdAndBookId(UserId userId, BookId bookId) {
        LambdaQueryWrapper<ReadingBookmarkPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ReadingBookmarkPO::getUserId, userId.value())
                .eq(ReadingBookmarkPO::getBookId, bookId.value())
                .orderByAsc(ReadingBookmarkPO::getChapterIndex)
                .orderByAsc(ReadingBookmarkPO::getPosition);
        return readingBookmarkMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<ReadingBookmark> findByUserIdAndChapterId(UserId userId, ChapterId chapterId) {
        LambdaQueryWrapper<ReadingBookmarkPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ReadingBookmarkPO::getUserId, userId.value())
                .eq(ReadingBookmarkPO::getChapterId, chapterId.value())
                .orderByAsc(ReadingBookmarkPO::getPosition);
        return readingBookmarkMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<ReadingBookmark> findByUserId(UserId userId, int page, int size) {
        LambdaQueryWrapper<ReadingBookmarkPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ReadingBookmarkPO::getUserId, userId.value())
                .orderByDesc(ReadingBookmarkPO::getCreateTime)
                .last("LIMIT " + size + " OFFSET " + (page - 1) * size);
        return readingBookmarkMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public long countByUserId(UserId userId) {
        LambdaQueryWrapper<ReadingBookmarkPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ReadingBookmarkPO::getUserId, userId.value());
        return readingBookmarkMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(Long id) {
        readingBookmarkMapper.deleteById(id);
    }

    @Override
    public void deleteByUserIdAndBookId(UserId userId, BookId bookId) {
        LambdaQueryWrapper<ReadingBookmarkPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ReadingBookmarkPO::getUserId, userId.value())
                .eq(ReadingBookmarkPO::getBookId, bookId.value());
        readingBookmarkMapper.delete(wrapper);
    }
}
