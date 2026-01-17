package com.novacloudedu.backend.infrastructure.ai;

import com.alibaba.dashscope.aigc.generation.Generation;
import com.alibaba.dashscope.aigc.generation.GenerationParam;
import com.alibaba.dashscope.aigc.generation.GenerationResult;
import com.alibaba.dashscope.common.Message;
import com.alibaba.dashscope.common.Role;
import com.novacloudedu.backend.domain.book.service.LlmService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 基于阿里云灵积平台的 LLM 服务实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class DashScopeLlmService implements LlmService {

    private final Generation generation;

    @Value("${ai.dashscope.llm.model-name}")
    private String modelName;

    @Value("${ai.dashscope.llm.temperature:0.7}")
    private Float temperature;

    @Value("${ai.dashscope.llm.max-tokens:2000}")
    private Integer maxTokens;

    @Value("${ai.dashscope.llm.top-p:0.8}")
    private Double topP;

    @Override
    public String chat(String message) {
        log.info("发送单条消息到 DashScope: {}", message);
        try {
            GenerationParam param = GenerationParam.builder()
                    .model(modelName)
                    .prompt(message)
                    .temperature(temperature)
                    .maxTokens(maxTokens)
                    .topP(topP)
                    .build();

            GenerationResult result = generation.call(param);
            String response = result.getOutput().getText();
            log.info("DashScope 回复: {}", response);
            return response;
        } catch (Exception e) {
            log.error("DashScope LLM 调用失败", e);
            throw new RuntimeException("LLM 调用失败: " + e.getMessage(), e);
        }
    }

    @Override
    public String chat(List<Map<String, String>> messages) {
        log.info("发送多轮对话到 DashScope，消息数: {}", messages.size());
        try {
            List<Message> dashscopeMessages = new ArrayList<>();
            
            for (Map<String, String> msg : messages) {
                String role = msg.get("role");
                String content = msg.get("content");
                
                Role dashscopeRole;
                switch (role.toLowerCase()) {
                    case "system":
                        dashscopeRole = Role.SYSTEM;
                        break;
                    case "user":
                        dashscopeRole = Role.USER;
                        break;
                    case "assistant":
                        dashscopeRole = Role.ASSISTANT;
                        break;
                    default:
                        log.warn("未知的消息角色: {}，使用 USER", role);
                        dashscopeRole = Role.USER;
                }
                
                dashscopeMessages.add(Message.builder()
                        .role(dashscopeRole.getValue())
                        .content(content)
                        .build());
            }
            
            GenerationParam param = GenerationParam.builder()
                    .model(modelName)
                    .messages(dashscopeMessages)
                    .temperature(temperature)
                    .maxTokens(maxTokens)
                    .topP(topP)
                    .resultFormat(GenerationParam.ResultFormat.MESSAGE)
                    .build();

            GenerationResult result = generation.call(param);
            String response = result.getOutput().getChoices().get(0).getMessage().getContent();
            log.info("DashScope 回复: {}", response);
            return response;
        } catch (Exception e) {
            log.error("DashScope LLM 多轮对话调用失败", e);
            throw new RuntimeException("LLM 调用失败: " + e.getMessage(), e);
        }
    }

    @Override
    public String chatWithSystemPrompt(String systemPrompt, String userMessage) {
        log.info("使用系统提示词进行对话");
        try {
            List<Message> messages = new ArrayList<>();
            messages.add(Message.builder()
                    .role(Role.SYSTEM.getValue())
                    .content(systemPrompt)
                    .build());
            messages.add(Message.builder()
                    .role(Role.USER.getValue())
                    .content(userMessage)
                    .build());
            
            GenerationParam param = GenerationParam.builder()
                    .model(modelName)
                    .messages(messages)
                    .temperature(temperature)
                    .maxTokens(maxTokens)
                    .topP(topP)
                    .resultFormat(GenerationParam.ResultFormat.MESSAGE)
                    .build();

            GenerationResult result = generation.call(param);
            String response = result.getOutput().getChoices().get(0).getMessage().getContent();
            log.info("DashScope 回复: {}", response);
            return response;
        } catch (Exception e) {
            log.error("DashScope LLM 调用失败", e);
            throw new RuntimeException("LLM 调用失败: " + e.getMessage(), e);
        }
    }

    @Override
    public void streamChat(String message, StreamCallback callback) {
        log.info("流式对话暂不支持，使用普通对话代替");
        // TODO: 实现流式调用
        String response = chat(message);
        callback.onToken(response);
    }

    @Override
    public String getModelName() {
        return modelName;
    }

    @Override
    public int getMaxTokens() {
        return maxTokens;
    }
}
