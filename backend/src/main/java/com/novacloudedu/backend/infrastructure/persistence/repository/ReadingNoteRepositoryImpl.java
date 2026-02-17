package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.book.entity.ReadingNote;
import com.novacloudedu.backend.domain.book.repository.ReadingNoteRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ReadingNoteConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ReadingNoteMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ReadingNotePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class ReadingNoteRepositoryImpl implements ReadingNoteRepository {

    private final ReadingNoteMapper readingNoteMapper;
    private final ReadingNoteConverter converter;

    @Override
    public ReadingNote save(ReadingNote note) {
        ReadingNotePO po = converter.toPO(note);
        if (po.getId() == null) {
            readingNoteMapper.insert(po);
            // 使用反射或reconstruct更新id —— 这里通过reconstruct重建
            return converter.toDomain(po);
        } else {
            readingNoteMapper.updateById(po);
            return note;
        }
    }

    @Override
    public Optional<ReadingNote> findById(Long id) {
        ReadingNotePO po = readingNoteMapper.selectById(id);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<ReadingNote> findByUserIdAndBookId(UserId userId, BookId bookId) {
        LambdaQueryWrapper<ReadingNotePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ReadingNotePO::getUserId, userId.value())
                .eq(ReadingNotePO::getBookId, bookId.value())
                .orderByDesc(ReadingNotePO::getCreateTime);
        return readingNoteMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<ReadingNote> findByUserIdAndChapterId(UserId userId, ChapterId chapterId) {
        LambdaQueryWrapper<ReadingNotePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ReadingNotePO::getUserId, userId.value())
                .eq(ReadingNotePO::getChapterId, chapterId.value())
                .orderByAsc(ReadingNotePO::getPositionStart);
        return readingNoteMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<ReadingNote> findByUserId(UserId userId, int page, int size) {
        LambdaQueryWrapper<ReadingNotePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ReadingNotePO::getUserId, userId.value())
                .orderByDesc(ReadingNotePO::getUpdateTime)
                .last("LIMIT " + size + " OFFSET " + (page - 1) * size);
        return readingNoteMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public long countByUserId(UserId userId) {
        LambdaQueryWrapper<ReadingNotePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ReadingNotePO::getUserId, userId.value());
        return readingNoteMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(Long id) {
        readingNoteMapper.deleteById(id);
    }

    @Override
    public void deleteByUserIdAndBookId(UserId userId, BookId bookId) {
        LambdaQueryWrapper<ReadingNotePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ReadingNotePO::getUserId, userId.value())
                .eq(ReadingNotePO::getBookId, bookId.value());
        readingNoteMapper.delete(wrapper);
    }
}
