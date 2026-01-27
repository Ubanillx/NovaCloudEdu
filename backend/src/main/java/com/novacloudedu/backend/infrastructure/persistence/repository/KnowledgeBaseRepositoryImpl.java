package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.novacloudedu.backend.domain.ai.entity.KnowledgeBase;
import com.novacloudedu.backend.domain.ai.repository.KnowledgeBaseRepository;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.KnowledgeBaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.KnowledgeBasePO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 知识库仓储实现
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class KnowledgeBaseRepositoryImpl implements KnowledgeBaseRepository {

    private final KnowledgeBaseMapper mapper;

    @Override
    public KnowledgeBase save(KnowledgeBase knowledgeBase) {
        KnowledgeBasePO po = toPO(knowledgeBase);
        
        if (po.getId() == null) {
            po.setCreateTime(LocalDateTime.now());
            po.setUpdateTime(LocalDateTime.now());
            po.setIsDelete(0);
            mapper.insert(po);
        } else {
            po.setUpdateTime(LocalDateTime.now());
            mapper.updateById(po);
        }
        
        return toDomain(po);
    }

    @Override
    public Optional<KnowledgeBase> findById(KnowledgeBaseId id) {
        KnowledgeBasePO po = mapper.selectById(id.value());
        if (po == null || po.getIsDelete() == 1) {
            return Optional.empty();
        }
        return Optional.of(toDomain(po));
    }

    @Override
    public List<KnowledgeBase> findByCreatorId(UserId creatorId, int page, int size) {
        int offset = page * size;
        List<KnowledgeBasePO> pos = mapper.findByCreatorId(creatorId.value(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<KnowledgeBase> findActiveByCreatorId(UserId creatorId, int page, int size) {
        int offset = page * size;
        List<KnowledgeBasePO> pos = mapper.findActiveByCreatorId(creatorId.value(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<KnowledgeBase> search(String keyword, UserId creatorId, int page, int size) {
        int offset = page * size;
        List<KnowledgeBasePO> pos = mapper.search(keyword, creatorId.value(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public long countByCreatorId(UserId creatorId) {
        return mapper.countByCreatorId(creatorId.value());
    }

    @Override
    public void delete(KnowledgeBaseId id) {
        mapper.deleteById(id.value());
    }

    @Override
    public void updateChunkCount(KnowledgeBaseId id, int chunkCount) {
        mapper.updateChunkCount(id.value(), chunkCount);
    }

    private KnowledgeBasePO toPO(KnowledgeBase kb) {
        KnowledgeBasePO po = new KnowledgeBasePO();
        if (kb.getId() != null) {
            po.setId(kb.getId().value());
        }
        po.setName(kb.getName());
        po.setDescription(kb.getDescription());
        po.setEmbeddingModel(kb.getEmbeddingModel());
        po.setEmbeddingDimension(kb.getEmbeddingDimension());
        po.setChunkSize(kb.getChunkSize());
        po.setChunkOverlap(kb.getChunkOverlap());
        po.setDocumentCount(kb.getDocumentCount());
        po.setChunkCount(kb.getChunkCount());
        po.setStatus(kb.getStatus());
        po.setCreatorId(kb.getCreatorId().value());
        return po;
    }

    private KnowledgeBase toDomain(KnowledgeBasePO po) {
        return KnowledgeBase.reconstruct(
                KnowledgeBaseId.of(po.getId()),
                po.getName(),
                po.getDescription(),
                po.getEmbeddingModel(),
                po.getEmbeddingDimension(),
                po.getChunkSize(),
                po.getChunkOverlap(),
                po.getDocumentCount(),
                po.getChunkCount(),
                po.getStatus(),
                UserId.of(po.getCreatorId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
