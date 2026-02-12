package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.AiAssistant;
import com.novacloudedu.backend.domain.ai.repository.AiAssistantRepository;
import com.novacloudedu.backend.domain.ai.valueobject.AiAssistantId;
import com.novacloudedu.backend.domain.ai.valueobject.AiAssistantStatus;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.ai.valueobject.ModelConfig;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AiAssistantKnowledgeMapper;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AiAssistantMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiAssistantKnowledgePO;
import com.novacloudedu.backend.infrastructure.persistence.po.AiAssistantPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * AI助手仓储实现
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class AiAssistantRepositoryImpl implements AiAssistantRepository {

    private final AiAssistantMapper mapper;
    private final AiAssistantKnowledgeMapper knowledgeMapper;
    private final ObjectMapper objectMapper;

    @Override
    public AiAssistant save(AiAssistant assistant) {
        AiAssistantPO po = toPO(assistant);
        
        if (po.getId() == null) {
            po.setCreateTime(LocalDateTime.now());
            po.setUpdateTime(LocalDateTime.now());
            po.setIsDelete(0);
            mapper.insert(po);
        } else {
            po.setUpdateTime(LocalDateTime.now());
            mapper.updateById(po);
        }
        
        return toDomain(po, findKnowledgeBaseIds(AiAssistantId.of(po.getId())));
    }

    @Override
    public Optional<AiAssistant> findById(AiAssistantId id) {
        AiAssistantPO po = mapper.selectById(id.value());
        if (po == null || po.getIsDelete() == 1) {
            return Optional.empty();
        }
        List<Long> kbIds = findKnowledgeBaseIds(id);
        return Optional.of(toDomain(po, kbIds));
    }

    @Override
    public List<AiAssistant> findByCreatorId(UserId creatorId, int page, int size) {
        int offset = page * size;
        List<AiAssistantPO> pos = mapper.findByCreatorId(creatorId.value(), offset, size);
        return pos.stream()
                .map(po -> toDomain(po, knowledgeMapper.findKnowledgeBaseIds(po.getId())))
                .collect(Collectors.toList());
    }

    @Override
    public List<AiAssistant> findByStatus(AiAssistantStatus status, int page, int size) {
        int offset = page * size;
        List<AiAssistantPO> pos = mapper.findByStatus(status.name(), offset, size);
        return pos.stream()
                .map(po -> toDomain(po, knowledgeMapper.findKnowledgeBaseIds(po.getId())))
                .collect(Collectors.toList());
    }

    @Override
    public List<AiAssistant> findPublicAssistants(int page, int size) {
        int offset = page * size;
        List<AiAssistantPO> pos = mapper.findPublicAssistants(offset, size);
        return pos.stream()
                .map(po -> toDomain(po, knowledgeMapper.findKnowledgeBaseIds(po.getId())))
                .collect(Collectors.toList());
    }

    @Override
    public List<AiAssistant> findByCategory(String category, int page, int size) {
        int offset = page * size;
        List<AiAssistantPO> pos = mapper.findByCategory(category, offset, size);
        return pos.stream()
                .map(po -> toDomain(po, knowledgeMapper.findKnowledgeBaseIds(po.getId())))
                .collect(Collectors.toList());
    }

    @Override
    public List<AiAssistant> search(String keyword, int page, int size) {
        int offset = page * size;
        List<AiAssistantPO> pos = mapper.search(keyword, offset, size);
        return pos.stream()
                .map(po -> toDomain(po, knowledgeMapper.findKnowledgeBaseIds(po.getId())))
                .collect(Collectors.toList());
    }

    @Override
    public long countByCreatorId(UserId creatorId) {
        return mapper.countByCreatorId(creatorId.value());
    }

    @Override
    public void delete(AiAssistantId id) {
        mapper.deleteById(id.value());
        knowledgeMapper.deleteByAssistantId(id.value());
    }

    @Override
    public void bindKnowledgeBase(AiAssistantId assistantId, Long knowledgeBaseId) {
        AiAssistantKnowledgePO po = new AiAssistantKnowledgePO();
        po.setAssistantId(assistantId.value());
        po.setKnowledgeBaseId(knowledgeBaseId);
        po.setCreateTime(LocalDateTime.now());
        knowledgeMapper.insert(po);
    }

    @Override
    public void unbindKnowledgeBase(AiAssistantId assistantId, Long knowledgeBaseId) {
        knowledgeMapper.deleteByAssistantAndKnowledge(assistantId.value(), knowledgeBaseId);
    }

    @Override
    public List<Long> findKnowledgeBaseIds(AiAssistantId assistantId) {
        return knowledgeMapper.findKnowledgeBaseIds(assistantId.value());
    }

    private AiAssistantPO toPO(AiAssistant assistant) {
        AiAssistantPO po = new AiAssistantPO();
        if (assistant.getId() != null) {
            po.setId(assistant.getId().value());
        }
        po.setName(assistant.getName());
        po.setDescription(assistant.getDescription());
        po.setAvatarUrl(assistant.getAvatarUrl());
        po.setTags(toJson(assistant.getTags()));
        po.setCategory(assistant.getCategory());
        po.setSystemPrompt(assistant.getSystemPrompt());
        po.setOpeningMessage(assistant.getOpeningMessage());
        po.setSuggestedQuestions(toJson(assistant.getSuggestedQuestions()));
        
        ModelConfig mc = assistant.getModelConfig();
        if (mc != null) {
            po.setModelName(mc.getModelName());
            po.setTemperature(mc.getTemperature());
            po.setTopP(mc.getTopP());
            po.setMaxTokens(mc.getMaxTokens());
        }
        
        po.setStatus(assistant.getStatus().name());
        po.setVersion(assistant.getVersion());
        po.setPublishedVersion(assistant.getPublishedVersion());
        po.setIsPublic(assistant.getIsPublic() ? 1 : 0);
        po.setUsageCount(assistant.getUsageCount());
        po.setRating(BigDecimal.valueOf(assistant.getRating()));
        po.setMcpServerIds(toJson(assistant.getMcpServerIds()));
        po.setCreatorId(assistant.getCreatorId().value());
        po.setSort(assistant.getSort());
        
        return po;
    }

    private AiAssistant toDomain(AiAssistantPO po, List<Long> knowledgeBaseIds) {
        List<KnowledgeBaseId> kbIds = knowledgeBaseIds != null 
                ? knowledgeBaseIds.stream().map(KnowledgeBaseId::of).collect(Collectors.toList())
                : new ArrayList<>();
        
        ModelConfig modelConfig = ModelConfig.create(
                po.getModelName(),
                po.getTemperature(),
                po.getTopP(),
                po.getMaxTokens()
        );
        
        return AiAssistant.reconstruct(
                AiAssistantId.of(po.getId()),
                po.getName(),
                po.getDescription(),
                po.getAvatarUrl(),
                fromJson(po.getTags(), new TypeReference<List<String>>() {}),
                po.getCategory(),
                po.getSystemPrompt(),
                po.getOpeningMessage(),
                fromJson(po.getSuggestedQuestions(), new TypeReference<List<String>>() {}),
                modelConfig,
                AiAssistantStatus.valueOf(po.getStatus()),
                po.getVersion(),
                po.getPublishedVersion(),
                po.getIsPublic() == 1,
                po.getUsageCount(),
                po.getRating() != null ? po.getRating().doubleValue() : 0.0,
                kbIds,
                fromJson(po.getMcpServerIds(), new TypeReference<List<Long>>() {}),
                UserId.of(po.getCreatorId()),
                po.getSort(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    private String toJson(Object obj) {
        if (obj == null) {
            return "[]";
        }
        try {
            return objectMapper.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            log.error("JSON序列化失败", e);
            return "[]";
        }
    }

    private <T> T fromJson(String json, TypeReference<T> typeRef) {
        if (json == null || json.isEmpty()) {
            try {
                return objectMapper.readValue("[]", typeRef);
            } catch (JsonProcessingException e) {
                return null;
            }
        }
        try {
            return objectMapper.readValue(json, typeRef);
        } catch (JsonProcessingException e) {
            log.error("JSON反序列化失败", e);
            return null;
        }
    }
}
