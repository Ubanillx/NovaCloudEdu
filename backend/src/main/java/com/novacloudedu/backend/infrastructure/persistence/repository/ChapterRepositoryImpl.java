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
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
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
    private final SqlSessionFactory sqlSessionFactory;

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
        wrapper.select(ChapterPO::getId, ChapterPO::getBookId, ChapterPO::getTitle,
                        ChapterPO::getChapterIndex, ChapterPO::getWordCount,
                        ChapterPO::getContentHash, ChapterPO::getEncryptionIv,
                        ChapterPO::getCreateTime, ChapterPO::getUpdateTime)
                .eq(ChapterPO::getBookId, bookId.value());
        return chapterMapper.selectList(wrapper).stream()
                .map(chapterConverter::toChapter)
                .collect(Collectors.toList());
    }

    @Override
    public List<Chapter> findByBookIdOrderByIndex(BookId bookId) {
        LambdaQueryWrapper<ChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.select(ChapterPO::getId, ChapterPO::getBookId, ChapterPO::getTitle,
                        ChapterPO::getChapterIndex, ChapterPO::getWordCount,
                        ChapterPO::getContentHash, ChapterPO::getEncryptionIv,
                        ChapterPO::getCreateTime, ChapterPO::getUpdateTime)
                .eq(ChapterPO::getBookId, bookId.value())
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

    @Override
    public List<Chapter> findUnencryptedByBookId(BookId bookId) {
        LambdaQueryWrapper<ChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChapterPO::getBookId, bookId.value())
                .and(w -> w.isNull(ChapterPO::getEncryptionIv)
                        .or().eq(ChapterPO::getEncryptionIv, ""))
                .orderByAsc(ChapterPO::getChapterIndex);
        return chapterMapper.selectList(wrapper).stream()
                .map(chapterConverter::toChapter)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void batchUpdate(List<Chapter> chapters, int batchSize) {
        if (chapters == null || chapters.isEmpty()) return;
        try (SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH, false)) {
            ChapterMapper batchMapper = sqlSession.getMapper(ChapterMapper.class);
            for (int i = 0; i < chapters.size(); i++) {
                ChapterPO po = chapterConverter.toChapterPO(chapters.get(i));
                batchMapper.updateById(po);
                if ((i + 1) % batchSize == 0) {
                    sqlSession.flushStatements();
                }
            }
            sqlSession.flushStatements();
            sqlSession.commit();
        }
    }

    @Override
    public List<Chapter> searchByContentKeyword(String keyword, int page, int size) {
        LambdaQueryWrapper<ChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w
                .like(ChapterPO::getTitle, keyword)
                .or()
                .like(ChapterPO::getContent, keyword))
                .orderByDesc(ChapterPO::getUpdateTime)
                .last("LIMIT " + size + " OFFSET " + (page - 1) * size);
        return chapterMapper.selectList(wrapper).stream()
                .map(chapterConverter::toChapter)
                .collect(Collectors.toList());
    }

    @Override
    public List<Chapter> searchByBookIdAndKeyword(Long bookId, String keyword, int page, int size) {
        LambdaQueryWrapper<ChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChapterPO::getBookId, bookId)
                .and(w -> w
                        .like(ChapterPO::getTitle, keyword)
                        .or()
                        .like(ChapterPO::getContent, keyword))
                .orderByAsc(ChapterPO::getChapterIndex)
                .last("LIMIT " + size + " OFFSET " + (page - 1) * size);
        return chapterMapper.selectList(wrapper).stream()
                .map(chapterConverter::toChapter)
                .collect(Collectors.toList());
    }
}
