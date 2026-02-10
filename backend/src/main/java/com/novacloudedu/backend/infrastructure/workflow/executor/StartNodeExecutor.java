package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * 开始节点执行器
 * 负责：
 * 1. 将工作流输入参数注入执行上下文
 * 2. 根据 config.inputParameters 定义校验输入参数
 * 3. 设置默认值
 */
@Slf4j
@Component
public class StartNodeExecutor implements NodeExecutor {

    @Override
    public NodeType getNodeType() {
        return NodeType.START;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig() != null ? node.getConfig() : Map.of();
        Map<String, Object> output = new HashMap<>();

        // 获取输入参数定义
        List<Map<String, Object>> inputParameters = (List<Map<String, Object>>) config.get("inputParameters");
        Boolean validateInput = (Boolean) config.getOrDefault("validateInput", false);

        if (inputParameters != null && !inputParameters.isEmpty()) {
            for (Map<String, Object> paramDef : inputParameters) {
                String paramName = (String) paramDef.get("name");
                String paramType = (String) paramDef.getOrDefault("type", "STRING");
                Boolean required = (Boolean) paramDef.getOrDefault("required", false);
                Object defaultValue = paramDef.get("defaultValue");

                if (paramName == null || paramName.isBlank()) {
                    continue;
                }

                Object value = input.get(paramName);

                // 如果值为空，尝试使用默认值
                if (value == null && defaultValue != null) {
                    value = defaultValue;
                    log.debug("开始节点: 参数 '{}' 使用默认值: {}", paramName, defaultValue);
                }

                // 必填校验
                if (Boolean.TRUE.equals(validateInput) && Boolean.TRUE.equals(required) && value == null) {
                    throw new IllegalArgumentException("缺少必需的输入参数: " + paramName);
                }

                // 类型转换与校验
                if (value != null && Boolean.TRUE.equals(validateInput)) {
                    value = validateAndConvert(paramName, value, paramType, paramDef);
                }

                // 将参数注入输出（会被引擎合并到全局变量）
                if (value != null) {
                    output.put(paramName, value);
                }
            }

            log.info("开始节点执行: 定义了 {} 个输入参数, 实际注入 {} 个",
                    inputParameters.size(), output.size());
        } else {
            // 没有定义输入参数，将所有 input 透传
            output.putAll(input);
            log.info("开始节点执行: 无参数定义，透传全部输入，共 {} 个", input.size());
        }

        return output;
    }

    @Override
    public void validate(WorkflowNode node) {
        // 开始节点配置可选，无需强制校验
    }

    /**
     * 校验并转换参数值的类型
     */
    private Object validateAndConvert(String name, Object value, String type, Map<String, Object> paramDef) {
        try {
            switch (type.toUpperCase()) {
                case "STRING" -> {
                    String strVal = String.valueOf(value);
                    // 长度校验
                    Integer minLength = getInteger(paramDef, "minLength");
                    Integer maxLength = getInteger(paramDef, "maxLength");
                    if (minLength != null && strVal.length() < minLength) {
                        throw new IllegalArgumentException(
                                String.format("参数 '%s' 长度不能小于 %d", name, minLength));
                    }
                    if (maxLength != null && strVal.length() > maxLength) {
                        throw new IllegalArgumentException(
                                String.format("参数 '%s' 长度不能大于 %d", name, maxLength));
                    }
                    return strVal;
                }
                case "NUMBER" -> {
                    double numVal;
                    if (value instanceof Number) {
                        numVal = ((Number) value).doubleValue();
                    } else {
                        numVal = Double.parseDouble(String.valueOf(value));
                    }
                    // 范围校验
                    Double minValue = getDouble(paramDef, "minValue");
                    Double maxValue = getDouble(paramDef, "maxValue");
                    if (minValue != null && numVal < minValue) {
                        throw new IllegalArgumentException(
                                String.format("参数 '%s' 不能小于 %s", name, minValue));
                    }
                    if (maxValue != null && numVal > maxValue) {
                        throw new IllegalArgumentException(
                                String.format("参数 '%s' 不能大于 %s", name, maxValue));
                    }
                    return numVal;
                }
                case "BOOLEAN" -> {
                    if (value instanceof Boolean) {
                        return value;
                    }
                    return Boolean.parseBoolean(String.valueOf(value));
                }
                case "OBJECT" -> {
                    if (value instanceof Map) {
                        return value;
                    }
                    throw new IllegalArgumentException(
                            String.format("参数 '%s' 类型应为 OBJECT，实际为 %s", name, value.getClass().getSimpleName()));
                }
                case "ARRAY" -> {
                    if (value instanceof List || value instanceof Collection) {
                        return value;
                    }
                    throw new IllegalArgumentException(
                            String.format("参数 '%s' 类型应为 ARRAY，实际为 %s", name, value.getClass().getSimpleName()));
                }
                default -> {
                    return value;
                }
            }
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(
                    String.format("参数 '%s' 无法转换为 %s 类型", name, type));
        }
    }

    private Integer getInteger(Map<String, Object> map, String key) {
        Object val = map.get(key);
        if (val instanceof Number) return ((Number) val).intValue();
        return null;
    }

    private Double getDouble(Map<String, Object> map, String key) {
        Object val = map.get(key);
        if (val instanceof Number) return ((Number) val).doubleValue();
        return null;
    }
}
