package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.ai.DashScopeLlmService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

/**
 * LLM节点执行器
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class LlmNodeExecutor implements NodeExecutor {

    private final DashScopeLlmService llmService;

    @Override
    public NodeType getNodeType() {
        return NodeType.LLM;
    }

    @Override
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String systemPrompt = (String) config.getOrDefault("systemPrompt", "");
        String userMessage = (String) config.getOrDefault("userMessage", "");
        
        // 支持变量替换
        userMessage = replaceVariables(userMessage, input);
        systemPrompt = replaceVariables(systemPrompt, input);
        
        // 如果userMessage为空，尝试从input获取
        if (userMessage.isEmpty()) {
            userMessage = (String) input.getOrDefault("userInput", "");
        }

        log.info("LLM节点执行: systemPrompt长度={}, userMessage长度={}", 
                systemPrompt.length(), userMessage.length());

        // 调用LLM
        String response = llmService.chatWithSystemPrompt(systemPrompt, userMessage);

        Map<String, Object> result = new HashMap<>();
        result.put("response", response);
        result.put("llmOutput", response);
        
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        // 验证节点配置
        if (node.getConfig() == null) {
            throw new IllegalArgumentException("LLM节点缺少配置");
        }
    }

    private String replaceVariables(String template, Map<String, Object> variables) {
        if (template == null || template.isEmpty()) {
            return template;
        }
        
        String result = template;
        for (Map.Entry<String, Object> entry : variables.entrySet()) {
            String placeholder = "{{" + entry.getKey() + "}}";
            String value = entry.getValue() != null ? String.valueOf(entry.getValue()) : "";
            result = result.replace(placeholder, value);
        }
        return result;
    }
}
