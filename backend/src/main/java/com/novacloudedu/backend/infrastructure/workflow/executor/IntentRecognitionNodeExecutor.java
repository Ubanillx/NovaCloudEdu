package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.ai.DashScopeLlmService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 意图识别节点执行器
 * 使用LLM进行意图分类
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class IntentRecognitionNodeExecutor implements NodeExecutor {

    private final DashScopeLlmService llmService;

    @Override
    public NodeType getNodeType() {
        return NodeType.INTENT_RECOGNITION;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String textVariable = (String) config.get("textVariable");
        List<Map<String, Object>> intents = (List<Map<String, Object>>) config.get("intents");
        String outputVariable = (String) config.getOrDefault("outputVariable", "intent");
        Double confidenceThreshold = getDouble(config, "confidenceThreshold", 0.6);
        
        String text = (String) input.get(textVariable);
        if (text == null || text.isBlank()) {
            return Map.of(outputVariable, "UNKNOWN", "confidence", 0.0);
        }

        // 构建意图列表描述
        StringBuilder intentDesc = new StringBuilder();
        for (Map<String, Object> intent : intents) {
            String name = (String) intent.get("name");
            String description = (String) intent.get("description");
            List<String> examples = (List<String>) intent.get("examples");
            
            intentDesc.append("- ").append(name).append(": ").append(description);
            if (examples != null && !examples.isEmpty()) {
                intentDesc.append(" (示例: ").append(String.join(", ", examples)).append(")");
            }
            intentDesc.append("\n");
        }

        // 构建提示词
        String systemPrompt = """
            你是一个意图识别专家。根据用户输入，从以下意图列表中选择最匹配的意图。
            
            意图列表：
            %s
            
            请以JSON格式返回结果，包含intent（意图名称）和confidence（置信度0-1）：
            {"intent": "意图名称", "confidence": 0.95}
            
            如果无法确定意图，返回：{"intent": "UNKNOWN", "confidence": 0.0}
            """.formatted(intentDesc.toString());

        String response = llmService.chatWithSystemPrompt(systemPrompt, "用户输入：" + text);

        // 解析响应
        try {
            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
            // 提取JSON部分
            String jsonStr = extractJson(response);
            Map<String, Object> result = mapper.readValue(jsonStr, Map.class);
            
            String intent = (String) result.getOrDefault("intent", "UNKNOWN");
            double confidence = ((Number) result.getOrDefault("confidence", 0.0)).doubleValue();
            
            // 置信度过低时返回UNKNOWN
            if (confidence < confidenceThreshold) {
                intent = "UNKNOWN";
            }

            log.info("意图识别完成: nodeId={}, intent={}, confidence={}", node.getId(), intent, confidence);

            Map<String, Object> output = new HashMap<>();
            output.put(outputVariable, intent);
            output.put("confidence", confidence);
            output.put("rawResponse", response);
            
            return output;
            
        } catch (Exception e) {
            log.error("意图识别解析失败: nodeId={}, error={}", node.getId(), e.getMessage());
            return Map.of(outputVariable, "UNKNOWN", "confidence", 0.0, "error", e.getMessage());
        }
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null) {
            throw new IllegalArgumentException("意图识别节点缺少配置");
        }
        if (!config.containsKey("textVariable")) {
            throw new IllegalArgumentException("意图识别节点缺少textVariable配置");
        }
        if (!config.containsKey("intents")) {
            throw new IllegalArgumentException("意图识别节点缺少intents配置");
        }
    }

    private String extractJson(String text) {
        int start = text.indexOf("{");
        int end = text.lastIndexOf("}");
        if (start >= 0 && end > start) {
            return text.substring(start, end + 1);
        }
        return "{}";
    }

    private Double getDouble(Map<String, Object> config, String key, double defaultValue) {
        Object value = config.get(key);
        if (value == null) return defaultValue;
        if (value instanceof Number) return ((Number) value).doubleValue();
        return defaultValue;
    }
}
