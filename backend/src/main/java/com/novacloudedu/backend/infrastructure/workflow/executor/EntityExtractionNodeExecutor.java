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
 * 实体抽取节点执行器
 * 使用LLM从文本中抽取指定类型的实体
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class EntityExtractionNodeExecutor implements NodeExecutor {

    private final DashScopeLlmService llmService;

    @Override
    public NodeType getNodeType() {
        return NodeType.ENTITY_EXTRACTION;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String inputVariable = (String) config.getOrDefault("inputVariable",
                (String) config.getOrDefault("textVariable", "userInput")); // 兼容旧字段
        List<Map<String, Object>> entityTypes = (List<Map<String, Object>>) config.get("entityTypes");
        String outputVariable = (String) config.getOrDefault("outputVariable", "entities");
        
        String text = (String) input.get(inputVariable);
        if (text == null || text.isBlank()) {
            return Map.of(outputVariable, List.of());
        }

        // 构建实体类型描述
        StringBuilder entityDesc = new StringBuilder();
        for (Map<String, Object> entityType : entityTypes) {
            String name = (String) entityType.get("name");
            String description = (String) entityType.get("description");
            List<String> examples = (List<String>) entityType.get("examples");
            
            entityDesc.append("- ").append(name).append(": ").append(description);
            if (examples != null && !examples.isEmpty()) {
                entityDesc.append(" (示例: ").append(String.join(", ", examples)).append(")");
            }
            entityDesc.append("\n");
        }

        // 是否返回位置信息
        Boolean includePosition = (Boolean) config.getOrDefault("includePosition", true);

        // 构建提示词：优先使用用户自定义提示词
        String customPrompt = (String) config.get("llmPrompt");
        String systemPrompt;
        if (customPrompt != null && !customPrompt.isBlank()) {
            systemPrompt = customPrompt + "\n\n实体类型：\n" + entityDesc;
        } else {
            String positionHint = Boolean.TRUE.equals(includePosition)
                    ? "请以JSON数组格式返回结果，每个实体包含type（类型）、value（值）、start（起始位置）、end（结束位置）：\n[{\"type\": \"实体类型\", \"value\": \"实体值\", \"start\": 0, \"end\": 5}]"
                    : "请以JSON数组格式返回结果，每个实体包含type（类型）、value（值）：\n[{\"type\": \"实体类型\", \"value\": \"实体值\"}]";
            systemPrompt = """
                你是一个实体抽取专家。从用户输入的文本中抽取以下类型的实体。
                
                实体类型：
                %s
                
                %s
                
                如果没有找到任何实体，返回空数组：[]
                """.formatted(entityDesc.toString(), positionHint);
        }

        String response = llmService.chatWithSystemPrompt(systemPrompt, "文本：" + text);

        // 解析响应
        try {
            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
            String jsonStr = extractJsonArray(response);
            List<Map<String, Object>> entities = mapper.readValue(jsonStr, 
                    mapper.getTypeFactory().constructCollectionType(List.class, Map.class));

            log.info("实体抽取完成: nodeId={}, entityCount={}", node.getId(), entities.size());

            Map<String, Object> output = new HashMap<>();
            output.put(outputVariable, entities);
            output.put("entityCount", entities.size());
            
            // 按类型分组
            Map<String, List<Object>> byType = new HashMap<>();
            for (Map<String, Object> entity : entities) {
                String type = (String) entity.get("type");
                byType.computeIfAbsent(type, k -> new java.util.ArrayList<>()).add(entity.get("value"));
            }
            output.put("entitiesByType", byType);
            
            return output;
            
        } catch (Exception e) {
            log.error("实体抽取解析失败: nodeId={}, error={}", node.getId(), e.getMessage());
            return Map.of(outputVariable, List.of(), "error", e.getMessage());
        }
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null) {
            throw new IllegalArgumentException("实体抽取节点缺少配置");
        }
        // 兼容新旧字段名
        String inputVar = (String) config.get("inputVariable");
        String textVar = (String) config.get("textVariable");
        if ((inputVar == null || inputVar.isBlank()) && (textVar == null || textVar.isBlank())) {
            throw new IllegalArgumentException("实体抽取节点缺少输入变量配置(inputVariable)");
        }
        if (!config.containsKey("entityTypes")) {
            throw new IllegalArgumentException("实体抽取节点缺少entityTypes配置");
        }
    }

    private String extractJsonArray(String text) {
        int start = text.indexOf("[");
        int end = text.lastIndexOf("]");
        if (start >= 0 && end > start) {
            return text.substring(start, end + 1);
        }
        return "[]";
    }
}
