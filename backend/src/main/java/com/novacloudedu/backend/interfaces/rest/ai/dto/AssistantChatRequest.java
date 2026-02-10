package com.novacloudedu.backend.interfaces.rest.ai.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.util.List;

/**
 * AI助手对话请求
 * 通过 assistantId 与配置好的助手对话，支持会话级记忆
 */
@Data
public class AssistantChatRequest {

    @NotBlank(message = "消息内容不能为空")
    private String message;

    /** 会话ID，为空则自动创建新会话 */
    private Long sessionId;

    /** 图片URL列表（多模态） */
    private List<String> imageUrls;

    /** 文档URL列表，后端自动解析文档内容注入对话上下文 */
    private List<String> documentUrls;
}
