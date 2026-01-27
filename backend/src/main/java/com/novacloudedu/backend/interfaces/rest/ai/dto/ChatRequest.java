package com.novacloudedu.backend.interfaces.rest.ai.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class ChatRequest {

    @NotBlank(message = "消息内容不能为空")
    private String message;

    private List<Map<String, String>> history;

    private String systemPrompt;
}
