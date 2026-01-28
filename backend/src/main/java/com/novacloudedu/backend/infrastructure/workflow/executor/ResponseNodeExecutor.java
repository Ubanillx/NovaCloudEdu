package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 响应输出节点执行器
 * 用于构建工作流的最终输出
 */
@Slf4j
@Component
public class ResponseNodeExecutor implements NodeExecutor {

    @Override
    public NodeType getNodeType() {
        return NodeType.RESPONSE;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String responseType = (String) config.getOrDefault("responseType", "JSON");
        String contentTemplate = (String) config.get("contentTemplate");
        List<Map<String, Object>> fields = (List<Map<String, Object>>) config.get("fields");
        Map<String, Object> jsonStructure = (Map<String, Object>) config.get("jsonStructure");
        
        Map<String, Object> result = new HashMap<>();
        Object responseBody;
        
        switch (responseType.toUpperCase()) {
            case "TEXT" -> {
                responseBody = replaceVariables(contentTemplate, input);
            }
            case "JSON" -> {
                Map<String, Object> jsonResponse = new HashMap<>();
                
                // 使用字段映射
                if (fields != null) {
                    for (Map<String, Object> field : fields) {
                        String fieldName = (String) field.get("fieldName");
                        String sourceVariable = (String) field.get("sourceVariable");
                        String fieldPath = (String) field.get("fieldPath");
                        Object defaultValue = field.get("defaultValue");
                        
                        Object value = input.get(sourceVariable);
                        
                        // 从对象中提取字段
                        if (value != null && fieldPath != null && !fieldPath.isBlank()) {
                            value = getNestedValue(value, fieldPath);
                        }
                        
                        // 使用默认值
                        if (value == null) {
                            value = defaultValue;
                        }
                        
                        jsonResponse.put(fieldName, value);
                    }
                }
                
                // 合并JSON结构
                if (jsonStructure != null) {
                    for (Map.Entry<String, Object> entry : jsonStructure.entrySet()) {
                        Object value = entry.getValue();
                        if (value instanceof String) {
                            value = replaceVariables((String) value, input);
                        }
                        jsonResponse.put(entry.getKey(), value);
                    }
                }
                
                responseBody = jsonResponse;
            }
            case "VARIABLE" -> {
                String outputVariable = (String) config.get("outputVariable");
                responseBody = input.get(outputVariable);
            }
            default -> {
                responseBody = input;
            }
        }
        
        result.put("response", responseBody);
        result.put("responseType", responseType);
        result.put("_workflowOutput", responseBody); // 特殊标记，用于工作流最终输出
        
        log.info("响应节点执行完成: nodeId={}, responseType={}", node.getId(), responseType);
        
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        // 响应节点配置可选
    }

    private String replaceVariables(String template, Map<String, Object> variables) {
        if (template == null) return null;
        String result = template;
        for (Map.Entry<String, Object> entry : variables.entrySet()) {
            String placeholder = "{{" + entry.getKey() + "}}";
            String value = entry.getValue() != null ? String.valueOf(entry.getValue()) : "";
            result = result.replace(placeholder, value);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    private Object getNestedValue(Object obj, String path) {
        String[] parts = path.split("\\.");
        Object current = obj;
        for (String part : parts) {
            if (current instanceof Map) {
                current = ((Map<String, Object>) current).get(part);
            } else {
                return null;
            }
        }
        return current;
    }
}
