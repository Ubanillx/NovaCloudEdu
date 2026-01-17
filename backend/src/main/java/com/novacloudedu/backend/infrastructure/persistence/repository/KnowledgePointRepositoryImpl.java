package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.novacloudedu.backend.domain.book.entity.KnowledgePoint;
import com.novacloudedu.backend.domain.book.repository.KnowledgePointRepository;
import com.novacloudedu.backend.domain.book.valueobject.*;
import com.novacloudedu.backend.infrastructure.persistence.mapper.KnowledgePointMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.KnowledgePointPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 知识点仓储实现
 */
@Repository
@RequiredArgsConstructor
public class KnowledgePointRepositoryImpl implements KnowledgePointRepository {

    private final KnowledgePointMapper mapper;

    @Override
    public KnowledgePoint save(KnowledgePoint point) {
        KnowledgePointPO po = toPO(point);
        
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
    public List<KnowledgePoint> saveAll(List<KnowledgePoint> points) {
        return points.stream()
                .map(this::save)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<KnowledgePoint> findById(KnowledgePointId id) {
        KnowledgePointPO po = mapper.selectById(id.getValue());
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public List<KnowledgePoint> findByChapterId(ChapterId chapterId) {
        List<KnowledgePointPO> pos = mapper.findByChapterId(chapterId.value());
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<KnowledgePoint> findByChapterIdAndType(ChapterId chapterId, KnowledgePointType type) {
        List<KnowledgePointPO> pos = mapper.findByChapterIdAndType(chapterId.value(), type.name());
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<KnowledgePoint> searchByName(String keyword, int page, int size) {
        int offset = page * size;
        List<KnowledgePointPO> pos = mapper.searchByName(keyword, offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public void delete(KnowledgePointId id) {
        mapper.deleteById(id.getValue());
    }

    @Override
    public void deleteByChapterId(ChapterId chapterId) {
        mapper.deleteByChapterId(chapterId.value());
    }

    private KnowledgePointPO toPO(KnowledgePoint point) {
        KnowledgePointPO po = new KnowledgePointPO();
        if (point.getId() != null) {
            po.setId(point.getId().getValue());
        }
        po.setChapterId(point.getChapterId().value());
        po.setPointType(point.getPointType().name());
        po.setName(point.getName());
        po.setDescription(point.getDescription());
        po.setPosition(point.getPosition());
        return po;
    }

    private KnowledgePoint toDomain(KnowledgePointPO po) {
        return KnowledgePoint.reconstruct(
                KnowledgePointId.of(po.getId()),
                ChapterId.of(po.getChapterId()),
                KnowledgePointType.valueOf(po.getPointType()),
                po.getName(),
                po.getDescription(),
                po.getPosition(),
                null,
                null,
                po.getCreateTime()
        );
    }
}
