package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.novacloudedu.backend.domain.book.entity.ChapterSummary;
import com.novacloudedu.backend.domain.book.repository.ChapterSummaryRepository;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterSummaryId;
import com.novacloudedu.backend.domain.book.valueobject.SummaryType;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ChapterSummaryMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ChapterSummaryPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 章节总结仓储实现
 */
@Repository
@RequiredArgsConstructor
public class ChapterSummaryRepositoryImpl implements ChapterSummaryRepository {

    private final ChapterSummaryMapper mapper;

    @Override
    public ChapterSummary save(ChapterSummary summary) {
        ChapterSummaryPO po = toPO(summary);
        
        if (po.getId() == null) {
            po.setCreateTime(LocalDateTime.now());
            po.setIsDelete(0);
            mapper.insert(po);
        } else {
            mapper.updateById(po);
        }
        
        return toDomain(po);
    }

    @Override
    public Optional<ChapterSummary> findById(ChapterSummaryId id) {
        ChapterSummaryPO po = mapper.selectById(id.getValue());
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public Optional<ChapterSummary> findByChapterIdAndType(ChapterId chapterId, SummaryType type) {
        ChapterSummaryPO po = mapper.findByChapterIdAndType(chapterId.value(), type.name());
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public List<ChapterSummary> findByChapterId(ChapterId chapterId) {
        List<ChapterSummaryPO> pos = mapper.findByChapterId(chapterId.value());
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public void delete(ChapterSummaryId id) {
        mapper.deleteById(id.getValue());
    }

    @Override
    public boolean existsByChapterIdAndType(ChapterId chapterId, SummaryType type) {
        return mapper.countByChapterIdAndType(chapterId.value(), type.name()) > 0;
    }

    private ChapterSummaryPO toPO(ChapterSummary summary) {
        ChapterSummaryPO po = new ChapterSummaryPO();
        if (summary.getId() != null) {
            po.setId(summary.getId().getValue());
        }
        po.setChapterId(summary.getChapterId().value());
        po.setSummaryType(summary.getSummaryType().name());
        po.setContent(summary.getContent());
        po.setKeyPoints(summary.getKeyPoints());
        po.setAiModel(summary.getAiModel());
        po.setIsCached(summary.isCached());
        return po;
    }

    private ChapterSummary toDomain(ChapterSummaryPO po) {
        return ChapterSummary.reconstruct(
                ChapterSummaryId.of(po.getId()),
                ChapterId.of(po.getChapterId()),
                SummaryType.valueOf(po.getSummaryType()),
                po.getContent(),
                po.getKeyPoints(),
                po.getAiModel(),
                po.getIsCached(),
                po.getCreateTime()
        );
    }
}
