package com.novacloudedu.backend.interfaces.rest.ai.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.util.List;

/**
 * 会话级聊天请求（不需要 history，服务端自动管理）
 */
@Data
public class SessionChatRequest {

    @NotBlank(message = "消息内容不能为空")
    private String message;

    private String systemPrompt;

    private List<String> imageUrls;

    /** 模型ID，格式: "provider/model"，如 "dashscope/qwen-max"。为空则使用默认模型 */
    private String modelId;
}
