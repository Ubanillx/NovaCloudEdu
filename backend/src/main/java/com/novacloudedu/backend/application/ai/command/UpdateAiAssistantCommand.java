package com.novacloudedu.backend.application.ai.command;

import jakarta.validation.constraints.Size;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * AI助手更新DTO
 */
@Data
public class UpdateAiAssistantCommand {

    @Size(max = 128, message = "名称最长128个字符")
    private String name;

    @Size(max = 2000, message = "描述最长2000个字符")
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

    private Boolean isPublic;

    private Integer sort;
}
