package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ChapterConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ChapterMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ChapterPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class ChapterRepositoryImpl implements ChapterRepository {

    private final ChapterMapper chapterMapper;
    private final ChapterConverter chapterConverter;

    @Override
    public Chapter save(Chapter chapter) {
        ChapterPO po = chapterConverter.toChapterPO(chapter);
        if (po.getId() == null) {
            chapterMapper.insert(po);
            chapter.assignId(ChapterId.of(po.getId()));
        } else {
            chapterMapper.updateById(po);
        }
        return chapter;
    }

    @Override
    @Transactional
    public void saveAll(List<Chapter> chapters) {
        chapters.forEach(this::save);
    }

    @Override
    public Optional<Chapter> findById(ChapterId id) {
        ChapterPO po = chapterMapper.selectById(id.value());
        return Optional.ofNullable(po).map(chapterConverter::toChapter);
    }

    @Override
    public Optional<Chapter> findByBookIdAndIndex(BookId bookId, Integer chapterIndex) {
        LambdaQueryWrapper<ChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChapterPO::getBookId, bookId.value())
                .eq(ChapterPO::getChapterIndex, chapterIndex);
        ChapterPO po = chapterMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(chapterConverter::toChapter);
    }

    @Override
    public List<Chapter> findByBookId(BookId bookId) {
        LambdaQueryWrapper<ChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChapterPO::getBookId, bookId.value());
        return chapterMapper.selectList(wrapper).stream()
                .map(chapterConverter::toChapter)
                .collect(Collectors.toList());
    }

    @Override
    public List<Chapter> findByBookIdOrderByIndex(BookId bookId) {
        LambdaQueryWrapper<ChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChapterPO::getBookId, bookId.value())
                .orderByAsc(ChapterPO::getChapterIndex);
        return chapterMapper.selectList(wrapper).stream()
                .map(chapterConverter::toChapter)
                .collect(Collectors.toList());
    }

    @Override
    public long countByBookId(BookId bookId) {
        LambdaQueryWrapper<ChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChapterPO::getBookId, bookId.value());
        return chapterMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(ChapterId id) {
        chapterMapper.deleteById(id.value());
    }

    @Override
    public void deleteByBookId(BookId bookId) {
        LambdaQueryWrapper<ChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChapterPO::getBookId, bookId.value());
        chapterMapper.delete(wrapper);
    }
}
