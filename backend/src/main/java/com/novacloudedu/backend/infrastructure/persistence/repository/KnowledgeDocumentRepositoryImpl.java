package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.novacloudedu.backend.domain.ai.entity.KnowledgeDocument;
import com.novacloudedu.backend.domain.ai.repository.KnowledgeDocumentRepository;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.KnowledgeDocumentMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.KnowledgeDocumentPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 知识库文档仓储实现
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class KnowledgeDocumentRepositoryImpl implements KnowledgeDocumentRepository {

    private final KnowledgeDocumentMapper mapper;

    @Override
    public KnowledgeDocument save(KnowledgeDocument document) {
        KnowledgeDocumentPO po = toPO(document);
        
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
    public Optional<KnowledgeDocument> findById(KnowledgeDocumentId id) {
        KnowledgeDocumentPO po = mapper.selectById(id.value());
        if (po == null || po.getIsDelete() == 1) {
            return Optional.empty();
        }
        return Optional.of(toDomain(po));
    }

    @Override
    public List<KnowledgeDocument> findByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId, int page, int size) {
        int offset = page * size;
        List<KnowledgeDocumentPO> pos = mapper.findByKnowledgeBaseId(knowledgeBaseId.value(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<KnowledgeDocument> findByStatus(DocumentStatus status, int page, int size) {
        int offset = page * size;
        List<KnowledgeDocumentPO> pos = mapper.findByStatus(status.name(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<KnowledgeDocument> findPendingDocuments(int limit) {
        List<KnowledgeDocumentPO> pos = mapper.findPendingDocuments(limit);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<KnowledgeDocument> findPendingByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId) {
        List<KnowledgeDocumentPO> pos = mapper.findPendingByKnowledgeBaseId(knowledgeBaseId.value());
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public long countByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId) {
        return mapper.countByKnowledgeBaseId(knowledgeBaseId.value());
    }

    @Override
    public java.util.Map<String, Long> countByKnowledgeBaseIdGroupByStatus(KnowledgeBaseId knowledgeBaseId) {
        List<java.util.Map<String, Object>> rows = mapper.countByKnowledgeBaseIdGroupByStatus(knowledgeBaseId.value());
        java.util.Map<String, Long> result = new java.util.LinkedHashMap<>();
        result.put("PENDING", 0L);
        result.put("PROCESSING", 0L);
        result.put("COMPLETED", 0L);
        result.put("FAILED", 0L);
        if (rows != null) {
            for (java.util.Map<String, Object> row : rows) {
                String status = (String) row.get("status");
                Long cnt = ((Number) row.get("cnt")).longValue();
                if (status != null) {
                    result.put(status, cnt);
                }
            }
        }
        return result;
    }

    @Override
    public void delete(KnowledgeDocumentId id) {
        mapper.deleteById(id.value());
    }

    @Override
    public void deleteByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId) {
        mapper.deleteByKnowledgeBaseId(knowledgeBaseId.value());
    }

    private KnowledgeDocumentPO toPO(KnowledgeDocument doc) {
        KnowledgeDocumentPO po = new KnowledgeDocumentPO();
        if (doc.getId() != null) {
            po.setId(doc.getId().value());
        }
        po.setKnowledgeBaseId(doc.getKnowledgeBaseId().value());
        po.setName(doc.getName());
        po.setFileType(doc.getFileType().name());
        po.setFileUrl(doc.getFileUrl());
        po.setFileSize(doc.getFileSize());
        po.setContent(doc.getContent());
        po.setContentHash(doc.getContentHash());
        po.setChunkCount(doc.getChunkCount());
        po.setStatus(doc.getStatus().name());
        po.setErrorMessage(doc.getErrorMessage());
        po.setCreatorId(doc.getCreatorId().value());
        return po;
    }

    private KnowledgeDocument toDomain(KnowledgeDocumentPO po) {
        return KnowledgeDocument.reconstruct(
                KnowledgeDocumentId.of(po.getId()),
                KnowledgeBaseId.of(po.getKnowledgeBaseId()),
                po.getName(),
                DocumentType.valueOf(po.getFileType()),
                po.getFileUrl(),
                po.getFileSize(),
                po.getContent(),
                po.getContentHash(),
                po.getChunkCount(),
                DocumentStatus.valueOf(po.getStatus()),
                po.getErrorMessage(),
                UserId.of(po.getCreatorId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
