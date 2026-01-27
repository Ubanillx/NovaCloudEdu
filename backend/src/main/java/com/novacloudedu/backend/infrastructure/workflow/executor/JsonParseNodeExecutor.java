package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * JSON解析节点执行器
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class JsonParseNodeExecutor implements NodeExecutor {

    private final ObjectMapper objectMapper;

    @Override
    public NodeType getNodeType() {
        return NodeType.JSON_PARSE;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String sourceVariable = (String) config.getOrDefault("sourceVariable", "jsonString");
        String outputVariable = (String) config.getOrDefault("outputVariable", "parsedJson");
        String operation = (String) config.getOrDefault("operation", "parse");
        
        Object source = input.get(sourceVariable);
        
        log.info("JSON解析节点执行: operation={}, sourceVariable={}", operation, sourceVariable);

        Map<String, Object> result = new HashMap<>();
        
        try {
            if ("parse".equals(operation)) {
                // 解析JSON字符串
                if (source instanceof String) {
                    Object parsed = objectMapper.readValue((String) source, Object.class);
                    result.put(outputVariable, parsed);
                } else {
                    result.put(outputVariable, source);
                }
            } else if ("stringify".equals(operation)) {
                // 序列化为JSON字符串
                String jsonString = objectMapper.writeValueAsString(source);
                result.put(outputVariable, jsonString);
            } else if ("extract".equals(operation)) {
                // 提取特定字段
                String path = (String) config.getOrDefault("path", "");
                Object extracted = extractPath(source, path);
                result.put(outputVariable, extracted);
            }
            
            result.put("success", true);
            
        } catch (Exception e) {
            log.error("JSON解析失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        // JSON解析节点配置可选
    }

    @SuppressWarnings("unchecked")
    private Object extractPath(Object source, String path) {
        if (path == null || path.isEmpty() || source == null) {
            return source;
        }
        
        String[] parts = path.split("\\.");
        Object current = source;
        
        for (String part : parts) {
            if (current instanceof Map) {
                current = ((Map<String, Object>) current).get(part);
            } else {
                return null;
            }
            if (current == null) {
                return null;
            }
        }
        
        return current;
    }
}
