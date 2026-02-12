package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.AiAssistantId;
import com.novacloudedu.backend.domain.ai.valueobject.AiAssistantStatus;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.ai.valueobject.ModelConfig;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * AI助手聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AiAssistant {

    private AiAssistantId id;
    private String name;
    private String description;
    private String avatarUrl;
    private List<String> tags;
    private String category;
    
    // 提示词配置
    private String systemPrompt;
    private String openingMessage;
    private List<String> suggestedQuestions;
    
    // 模型配置
    private ModelConfig modelConfig;
    
    // MCP 服务器绑定
    private List<Long> mcpServerIds;
    
    // 状态与版本
    private AiAssistantStatus status;
    private Integer version;
    private Integer publishedVersion;
    
    // 统计
    private Boolean isPublic;
    private Integer usageCount;
    private Double rating;
    
    // 关联的知识库
    private List<KnowledgeBaseId> knowledgeBaseIds;
    
    // 审计
    private UserId creatorId;
    private Integer sort;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新的AI助手
     */
    public static AiAssistant create(String name, String description, UserId creatorId) {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("AI助手名称不能为空");
        }
        if (creatorId == null) {
            throw new IllegalArgumentException("创建者ID不能为空");
        }

        AiAssistant assistant = new AiAssistant();
        assistant.name = name.trim();
        assistant.description = description;
        assistant.creatorId = creatorId;
        assistant.tags = new ArrayList<>();
        assistant.suggestedQuestions = new ArrayList<>();
        assistant.knowledgeBaseIds = new ArrayList<>();
        assistant.mcpServerIds = new ArrayList<>();
        assistant.modelConfig = ModelConfig.defaultConfig();
        assistant.status = AiAssistantStatus.DRAFT;
        assistant.version = 1;
        assistant.publishedVersion = 0;
        assistant.isPublic = false;
        assistant.usageCount = 0;
        assistant.rating = 0.0;
        assistant.sort = 0;
        assistant.createTime = LocalDateTime.now();
        assistant.updateTime = LocalDateTime.now();
        return assistant;
    }

    /**
     * 从数据库重构
     */
    public static AiAssistant reconstruct(
            AiAssistantId id,
            String name,
            String description,
            String avatarUrl,
            List<String> tags,
            String category,
            String systemPrompt,
            String openingMessage,
            List<String> suggestedQuestions,
            ModelConfig modelConfig,
            AiAssistantStatus status,
            Integer version,
            Integer publishedVersion,
            Boolean isPublic,
            Integer usageCount,
            Double rating,
            List<KnowledgeBaseId> knowledgeBaseIds,
            List<Long> mcpServerIds,
            UserId creatorId,
            Integer sort,
            LocalDateTime createTime,
            LocalDateTime updateTime) {
        
        AiAssistant assistant = new AiAssistant();
        assistant.id = id;
        assistant.name = name;
        assistant.description = description;
        assistant.avatarUrl = avatarUrl;
        assistant.tags = tags != null ? new ArrayList<>(tags) : new ArrayList<>();
        assistant.category = category;
        assistant.systemPrompt = systemPrompt;
        assistant.openingMessage = openingMessage;
        assistant.suggestedQuestions = suggestedQuestions != null ? new ArrayList<>(suggestedQuestions) : new ArrayList<>();
        assistant.modelConfig = modelConfig;
        assistant.status = status;
        assistant.version = version;
        assistant.publishedVersion = publishedVersion;
        assistant.isPublic = isPublic;
        assistant.usageCount = usageCount;
        assistant.rating = rating;
        assistant.knowledgeBaseIds = knowledgeBaseIds != null ? new ArrayList<>(knowledgeBaseIds) : new ArrayList<>();
        assistant.mcpServerIds = mcpServerIds != null ? new ArrayList<>(mcpServerIds) : new ArrayList<>();
        assistant.creatorId = creatorId;
        assistant.sort = sort;
        assistant.createTime = createTime;
        assistant.updateTime = updateTime;
        return assistant;
    }

    /**
     * 更新基本信息
     */
    public void updateBasicInfo(String name, String description, String avatarUrl, 
                                List<String> tags, String category) {
        if (name != null && !name.trim().isEmpty()) {
            this.name = name.trim();
        }
        this.description = description;
        this.avatarUrl = avatarUrl;
        this.tags = tags != null ? new ArrayList<>(tags) : new ArrayList<>();
        this.category = category;
        this.updateTime = LocalDateTime.now();
        incrementVersion();
    }

    /**
     * 更新提示词配置
     */
    public void updatePromptConfig(String systemPrompt, String openingMessage, 
                                   List<String> suggestedQuestions) {
        this.systemPrompt = systemPrompt;
        this.openingMessage = openingMessage;
        this.suggestedQuestions = suggestedQuestions != null ? new ArrayList<>(suggestedQuestions) : new ArrayList<>();
        this.updateTime = LocalDateTime.now();
        incrementVersion();
    }

    /**
     * 更新模型配置
     */
    public void updateModelConfig(ModelConfig modelConfig) {
        if (modelConfig == null) {
            throw new IllegalArgumentException("模型配置不能为空");
        }
        this.modelConfig = modelConfig;
        this.updateTime = LocalDateTime.now();
        incrementVersion();
    }

    /**
     * 更新 MCP 服务器绑定
     */
    public void updateMcpServerIds(List<Long> mcpServerIds) {
        this.mcpServerIds = mcpServerIds != null ? new ArrayList<>(mcpServerIds) : new ArrayList<>();
        this.updateTime = LocalDateTime.now();
        incrementVersion();
    }

    /**
     * 绑定知识库
     */
    public void bindKnowledgeBase(KnowledgeBaseId knowledgeBaseId) {
        if (knowledgeBaseId == null) {
            throw new IllegalArgumentException("知识库ID不能为空");
        }
        if (!this.knowledgeBaseIds.contains(knowledgeBaseId)) {
            this.knowledgeBaseIds.add(knowledgeBaseId);
            this.updateTime = LocalDateTime.now();
        }
    }

    /**
     * 解绑知识库
     */
    public void unbindKnowledgeBase(KnowledgeBaseId knowledgeBaseId) {
        if (knowledgeBaseId != null) {
            this.knowledgeBaseIds.remove(knowledgeBaseId);
            this.updateTime = LocalDateTime.now();
        }
    }

    /**
     * 发布
     */
    public void publish() {
        if (this.systemPrompt == null || this.systemPrompt.trim().isEmpty()) {
            throw new IllegalStateException("发布前必须配置系统提示词");
        }
        this.status = AiAssistantStatus.PUBLISHED;
        this.publishedVersion = this.version;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 归档
     */
    public void archive() {
        this.status = AiAssistantStatus.ARCHIVED;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 设置公开状态
     */
    public void setPublic(boolean isPublic) {
        this.isPublic = isPublic;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 增加使用次数
     */
    public void incrementUsageCount() {
        this.usageCount++;
    }

    /**
     * 更新评分
     */
    public void updateRating(double rating) {
        if (rating < 0 || rating > 5) {
            throw new IllegalArgumentException("评分必须在0-5之间");
        }
        this.rating = rating;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 设置排序
     */
    public void setSort(int sort) {
        this.sort = sort;
        this.updateTime = LocalDateTime.now();
    }

    private void incrementVersion() {
        this.version++;
    }

    /**
     * 是否已发布
     */
    public boolean isPublished() {
        return this.status == AiAssistantStatus.PUBLISHED;
    }

    /**
     * 是否为草稿
     */
    public boolean isDraft() {
        return this.status == AiAssistantStatus.DRAFT;
    }
}
