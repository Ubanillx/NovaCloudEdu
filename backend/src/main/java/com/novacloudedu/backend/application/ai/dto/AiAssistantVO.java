package com.novacloudedu.backend.application.ai.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * AI助手视图对象
 */
@Data
public class AiAssistantVO {

    private Long id;
    private String name;
    private String description;
    private String avatarUrl;
    private List<String> tags;
    private String category;

    private String systemPrompt;
    private String openingMessage;
    private List<String> suggestedQuestions;

    private String modelName;
    private BigDecimal temperature;
    private BigDecimal topP;
    private Integer maxTokens;

    private String status;
    private Integer version;
    private Integer publishedVersion;

    private Boolean isPublic;
    private Integer usageCount;
    private Double rating;

    private List<KnowledgeBaseVO> knowledgeBases;

    private List<Long> mcpServerIds;

    private Long creatorId;
    private Integer sort;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
