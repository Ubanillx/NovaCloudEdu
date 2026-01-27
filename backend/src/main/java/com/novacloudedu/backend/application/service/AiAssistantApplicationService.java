package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.ai.command.CreateAiAssistantCommand;
import com.novacloudedu.backend.application.ai.command.UpdateAiAssistantCommand;
import com.novacloudedu.backend.application.ai.dto.AiAssistantVO;
import com.novacloudedu.backend.application.ai.dto.KnowledgeBaseVO;
import com.novacloudedu.backend.domain.ai.entity.AiAssistant;
import com.novacloudedu.backend.domain.ai.entity.KnowledgeBase;
import com.novacloudedu.backend.domain.ai.repository.AiAssistantRepository;
import com.novacloudedu.backend.domain.ai.repository.KnowledgeBaseRepository;
import com.novacloudedu.backend.domain.ai.valueobject.AiAssistantId;
import com.novacloudedu.backend.domain.ai.valueobject.AiAssistantStatus;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.ai.valueobject.ModelConfig;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * AI助手应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AiAssistantApplicationService {

    private final AiAssistantRepository assistantRepository;
    private final KnowledgeBaseRepository knowledgeBaseRepository;

    /**
     * 创建AI助手
     */
    @Transactional
    public AiAssistantVO create(Long userId, CreateAiAssistantCommand dto) {
        log.info("创建AI助手: userId={}, name={}", userId, dto.getName());

        AiAssistant assistant = AiAssistant.create(
                dto.getName(),
                dto.getDescription(),
                UserId.of(userId)
        );

        // 更新基本信息
        assistant.updateBasicInfo(
                dto.getName(),
                dto.getDescription(),
                dto.getAvatarUrl(),
                dto.getTags(),
                dto.getCategory()
        );

        // 更新提示词配置
        assistant.updatePromptConfig(
                dto.getSystemPrompt(),
                dto.getOpeningMessage(),
                dto.getSuggestedQuestions()
        );

        // 更新模型配置
        if (dto.getModelName() != null || dto.getTemperature() != null || 
            dto.getTopP() != null || dto.getMaxTokens() != null) {
            ModelConfig modelConfig = ModelConfig.create(
                    dto.getModelName(),
                    dto.getTemperature(),
                    dto.getTopP(),
                    dto.getMaxTokens()
            );
            assistant.updateModelConfig(modelConfig);
        }

        // 保存
        AiAssistant saved = assistantRepository.save(assistant);

        // 绑定知识库
        if (dto.getKnowledgeBaseIds() != null && !dto.getKnowledgeBaseIds().isEmpty()) {
            for (Long kbId : dto.getKnowledgeBaseIds()) {
                assistantRepository.bindKnowledgeBase(saved.getId(), kbId);
            }
        }

        return toVO(saved);
    }

    /**
     * 更新AI助手
     */
    @Transactional
    public AiAssistantVO update(Long id, UpdateAiAssistantCommand dto) {
        log.info("更新AI助手: id={}", id);

        AiAssistant assistant = assistantRepository.findById(AiAssistantId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("AI助手不存在: " + id));

        // 更新基本信息
        if (dto.getName() != null || dto.getDescription() != null || 
            dto.getAvatarUrl() != null || dto.getTags() != null || dto.getCategory() != null) {
            assistant.updateBasicInfo(
                    dto.getName() != null ? dto.getName() : assistant.getName(),
                    dto.getDescription() != null ? dto.getDescription() : assistant.getDescription(),
                    dto.getAvatarUrl() != null ? dto.getAvatarUrl() : assistant.getAvatarUrl(),
                    dto.getTags() != null ? dto.getTags() : assistant.getTags(),
                    dto.getCategory() != null ? dto.getCategory() : assistant.getCategory()
            );
        }

        // 更新提示词配置
        if (dto.getSystemPrompt() != null || dto.getOpeningMessage() != null || 
            dto.getSuggestedQuestions() != null) {
            assistant.updatePromptConfig(
                    dto.getSystemPrompt() != null ? dto.getSystemPrompt() : assistant.getSystemPrompt(),
                    dto.getOpeningMessage() != null ? dto.getOpeningMessage() : assistant.getOpeningMessage(),
                    dto.getSuggestedQuestions() != null ? dto.getSuggestedQuestions() : assistant.getSuggestedQuestions()
            );
        }

        // 更新模型配置
        if (dto.getModelName() != null || dto.getTemperature() != null || 
            dto.getTopP() != null || dto.getMaxTokens() != null) {
            ModelConfig currentConfig = assistant.getModelConfig();
            ModelConfig modelConfig = ModelConfig.create(
                    dto.getModelName() != null ? dto.getModelName() : currentConfig.getModelName(),
                    dto.getTemperature() != null ? dto.getTemperature() : currentConfig.getTemperature(),
                    dto.getTopP() != null ? dto.getTopP() : currentConfig.getTopP(),
                    dto.getMaxTokens() != null ? dto.getMaxTokens() : currentConfig.getMaxTokens()
            );
            assistant.updateModelConfig(modelConfig);
        }

        // 更新公开状态
        if (dto.getIsPublic() != null) {
            assistant.setPublic(dto.getIsPublic());
        }

        // 更新排序
        if (dto.getSort() != null) {
            assistant.setSort(dto.getSort());
        }

        AiAssistant saved = assistantRepository.save(assistant);
        return toVO(saved);
    }

    /**
     * 获取AI助手详情
     */
    public AiAssistantVO getById(Long id) {
        AiAssistant assistant = assistantRepository.findById(AiAssistantId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("AI助手不存在: " + id));
        return toVO(assistant);
    }

    /**
     * 获取用户的AI助手列表
     */
    public List<AiAssistantVO> listByCreator(Long userId, int page, int size) {
        List<AiAssistant> assistants = assistantRepository.findByCreatorId(UserId.of(userId), page, size);
        return assistants.stream().map(this::toVO).collect(Collectors.toList());
    }

    /**
     * 获取公开的AI助手列表
     */
    public List<AiAssistantVO> listPublic(int page, int size) {
        List<AiAssistant> assistants = assistantRepository.findPublicAssistants(page, size);
        return assistants.stream().map(this::toVO).collect(Collectors.toList());
    }

    /**
     * 搜索AI助手
     */
    public List<AiAssistantVO> search(String keyword, int page, int size) {
        List<AiAssistant> assistants = assistantRepository.search(keyword, page, size);
        return assistants.stream().map(this::toVO).collect(Collectors.toList());
    }

    /**
     * 删除AI助手
     */
    @Transactional
    public void delete(Long id) {
        log.info("删除AI助手: id={}", id);
        assistantRepository.delete(AiAssistantId.of(id));
    }

    /**
     * 发布AI助手
     */
    @Transactional
    public AiAssistantVO publish(Long id) {
        log.info("发布AI助手: id={}", id);

        AiAssistant assistant = assistantRepository.findById(AiAssistantId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("AI助手不存在: " + id));

        assistant.publish();
        AiAssistant saved = assistantRepository.save(assistant);
        return toVO(saved);
    }

    /**
     * 归档AI助手
     */
    @Transactional
    public AiAssistantVO archive(Long id) {
        log.info("归档AI助手: id={}", id);

        AiAssistant assistant = assistantRepository.findById(AiAssistantId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("AI助手不存在: " + id));

        assistant.archive();
        AiAssistant saved = assistantRepository.save(assistant);
        return toVO(saved);
    }

    /**
     * 绑定知识库
     */
    @Transactional
    public void bindKnowledgeBase(Long assistantId, Long knowledgeBaseId) {
        log.info("绑定知识库: assistantId={}, knowledgeBaseId={}", assistantId, knowledgeBaseId);
        
        // 验证AI助手存在
        assistantRepository.findById(AiAssistantId.of(assistantId))
                .orElseThrow(() -> new IllegalArgumentException("AI助手不存在: " + assistantId));
        
        // 验证知识库存在
        knowledgeBaseRepository.findById(KnowledgeBaseId.of(knowledgeBaseId))
                .orElseThrow(() -> new IllegalArgumentException("知识库不存在: " + knowledgeBaseId));

        assistantRepository.bindKnowledgeBase(AiAssistantId.of(assistantId), knowledgeBaseId);
    }

    /**
     * 解绑知识库
     */
    @Transactional
    public void unbindKnowledgeBase(Long assistantId, Long knowledgeBaseId) {
        log.info("解绑知识库: assistantId={}, knowledgeBaseId={}", assistantId, knowledgeBaseId);
        assistantRepository.unbindKnowledgeBase(AiAssistantId.of(assistantId), knowledgeBaseId);
    }

    private AiAssistantVO toVO(AiAssistant assistant) {
        AiAssistantVO vo = new AiAssistantVO();
        vo.setId(assistant.getId().value());
        vo.setName(assistant.getName());
        vo.setDescription(assistant.getDescription());
        vo.setAvatarUrl(assistant.getAvatarUrl());
        vo.setTags(assistant.getTags());
        vo.setCategory(assistant.getCategory());
        vo.setSystemPrompt(assistant.getSystemPrompt());
        vo.setOpeningMessage(assistant.getOpeningMessage());
        vo.setSuggestedQuestions(assistant.getSuggestedQuestions());

        ModelConfig mc = assistant.getModelConfig();
        if (mc != null) {
            vo.setModelName(mc.getModelName());
            vo.setTemperature(mc.getTemperature());
            vo.setTopP(mc.getTopP());
            vo.setMaxTokens(mc.getMaxTokens());
        }

        vo.setStatus(assistant.getStatus().name());
        vo.setVersion(assistant.getVersion());
        vo.setPublishedVersion(assistant.getPublishedVersion());
        vo.setIsPublic(assistant.getIsPublic());
        vo.setUsageCount(assistant.getUsageCount());
        vo.setRating(assistant.getRating());

        // 获取关联的知识库
        List<Long> kbIds = assistantRepository.findKnowledgeBaseIds(assistant.getId());
        List<KnowledgeBaseVO> knowledgeBases = new ArrayList<>();
        for (Long kbId : kbIds) {
            knowledgeBaseRepository.findById(KnowledgeBaseId.of(kbId))
                    .ifPresent(kb -> knowledgeBases.add(toKnowledgeBaseVO(kb)));
        }
        vo.setKnowledgeBases(knowledgeBases);

        vo.setCreatorId(assistant.getCreatorId().value());
        vo.setSort(assistant.getSort());
        vo.setCreateTime(assistant.getCreateTime());
        vo.setUpdateTime(assistant.getUpdateTime());

        return vo;
    }

    private KnowledgeBaseVO toKnowledgeBaseVO(KnowledgeBase kb) {
        KnowledgeBaseVO vo = new KnowledgeBaseVO();
        vo.setId(kb.getId().value());
        vo.setName(kb.getName());
        vo.setDescription(kb.getDescription());
        vo.setEmbeddingModel(kb.getEmbeddingModel());
        vo.setEmbeddingDimension(kb.getEmbeddingDimension());
        vo.setChunkSize(kb.getChunkSize());
        vo.setChunkOverlap(kb.getChunkOverlap());
        vo.setDocumentCount(kb.getDocumentCount());
        vo.setChunkCount(kb.getChunkCount());
        vo.setStatus(kb.getStatus());
        vo.setCreatorId(kb.getCreatorId().value());
        vo.setCreateTime(kb.getCreateTime());
        vo.setUpdateTime(kb.getUpdateTime());
        return vo;
    }
}
