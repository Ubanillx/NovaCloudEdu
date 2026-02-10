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
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * JSON解析节点执行器
 *
 * <p>支持的配置字段（与 {@code JsonParseNodeConfigRequest} 对齐）：</p>
 * <ul>
 *   <li><b>inputVariable</b> / sourceVariable — 数据来源变量名（兼容旧字段名）</li>
 *   <li><b>parseMode</b> — EXTRACT / TRANSFORM / VALIDATE（默认 EXTRACT）</li>
 *   <li><b>extractions</b> — 多字段提取配置列表，每项含 fieldPath / outputVariable / dataType / required / defaultValue</li>
 *   <li><b>jsonPath</b> — 简易 JSONPath 表达式（用于单值提取）</li>
 *   <li><b>outputVariable</b> — 整体输出变量名</li>
 *   <li><b>errorStrategy</b> — ERROR / DEFAULT_VALUE / SKIP</li>
 *   <li><b>defaultValue</b> — errorStrategy 为 DEFAULT_VALUE 时使用</li>
 * </ul>
 *
 * <p>同时向后兼容旧配置：operation (parse/stringify/extract)、sourceVariable、path</p>
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class JsonParseNodeExecutor implements NodeExecutor {

    private final ObjectMapper objectMapper;

    /** 匹配数组索引，如 items[0] */
    private static final Pattern ARRAY_INDEX_PATTERN = Pattern.compile("^(.+?)\\[(\\d+)]$");

    @Override
    public NodeType getNodeType() {
        return NodeType.JSON_PARSE;
    }

    @Override
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();

        // 兼容新旧字段名：inputVariable（新） / sourceVariable（旧）
        String inputVariable = (String) config.get("inputVariable");
        if (inputVariable == null || inputVariable.isBlank()) {
            inputVariable = (String) config.getOrDefault("sourceVariable", "jsonString");
        }
        String outputVariable = (String) config.getOrDefault("outputVariable", "parsedJson");
        String errorStrategy = (String) config.getOrDefault("errorStrategy", "ERROR");
        Object defaultValue = config.get("defaultValue");

        // 解析来源数据：支持带点号路径的变量引用，如 "http_1.jsonBody"
        Object source = resolveVariable(input, inputVariable);

        // 判断走新配置（parseMode + extractions）还是旧配置（operation）
        String parseMode = (String) config.get("parseMode");
        String operation = (String) config.get("operation");

        log.info("JSON解析节点执行: parseMode={}, operation={}, inputVariable={}", parseMode, operation, inputVariable);

        Map<String, Object> result = new HashMap<>();

        try {
            // ===== 新配置模式（parseMode） =====
            if (parseMode != null && !parseMode.isBlank()) {
                // 如果来源是字符串，先解析为对象
                Object parsedSource = ensureParsed(source);

                switch (parseMode.toUpperCase()) {
                    case "EXTRACT":
                        executeExtractMode(config, parsedSource, outputVariable, result);
                        break;
                    case "TRANSFORM":
                        // 转换模式：解析后整体输出
                        result.put(outputVariable, parsedSource);
                        break;
                    case "VALIDATE":
                        // 验证模式：检查是否为有效JSON
                        boolean valid = (parsedSource != null);
                        result.put("valid", valid);
                        result.put(outputVariable, parsedSource);
                        break;
                    default:
                        log.warn("未知的parseMode: {}, 按EXTRACT处理", parseMode);
                        executeExtractMode(config, parsedSource, outputVariable, result);
                }
            }
            // ===== 旧配置模式（operation）向后兼容 =====
            else if (operation != null && !operation.isBlank()) {
                executeLegacyOperation(operation, source, config, outputVariable, result);
            }
            // ===== 默认：自动提取模式 =====
            else {
                Object parsedSource = ensureParsed(source);
                executeExtractMode(config, parsedSource, outputVariable, result);
            }

            result.put("success", true);

        } catch (Exception e) {
            log.error("JSON解析失败: inputVariable={}", inputVariable, e);
            handleError(errorStrategy, defaultValue, outputVariable, e, result);
        }

        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null) {
            return;
        }
        // 至少需要指定数据来源
        String inputVariable = (String) config.get("inputVariable");
        String sourceVariable = (String) config.get("sourceVariable");
        if ((inputVariable == null || inputVariable.isBlank()) && (sourceVariable == null || sourceVariable.isBlank())) {
            throw new IllegalArgumentException("JSON解析节点必须指定输入变量名（inputVariable）");
        }
    }

    // ==================== 核心方法 ====================

    /**
     * EXTRACT 模式：支持 extractions 列表批量提取 + jsonPath 单值提取
     */
    @SuppressWarnings("unchecked")
    private void executeExtractMode(Map<String, Object> config, Object parsedSource,
                                     String outputVariable, Map<String, Object> result) {
        // 1. 批量字段提取（extractions 列表）
        List<Map<String, Object>> extractions = (List<Map<String, Object>>) config.get("extractions");
        if (extractions != null && !extractions.isEmpty()) {
            for (Map<String, Object> extraction : extractions) {
                String fieldPath = (String) extraction.get("fieldPath");
                String extractOutputVar = (String) extraction.get("outputVariable");
                String dataType = (String) extraction.get("dataType");
                Boolean required = (Boolean) extraction.get("required");
                Object extractDefault = extraction.get("defaultValue");

                if (fieldPath == null || fieldPath.isBlank()) {
                    continue;
                }
                if (extractOutputVar == null || extractOutputVar.isBlank()) {
                    // 默认用 fieldPath 最后一段作为变量名
                    String[] segments = fieldPath.split("\\.");
                    extractOutputVar = segments[segments.length - 1].replaceAll("\\[\\d+]", "");
                }

                Object extracted = extractByPath(parsedSource, fieldPath);

                // 类型转换
                if (extracted != null && dataType != null) {
                    extracted = convertType(extracted, dataType);
                }

                // 必填校验
                if (extracted == null) {
                    if (extractDefault != null) {
                        extracted = extractDefault;
                    } else if (Boolean.TRUE.equals(required)) {
                        throw new RuntimeException("必需字段提取为空: " + fieldPath);
                    }
                }

                result.put(extractOutputVar, extracted);
            }
        }

        // 2. jsonPath 单值提取
        String jsonPath = (String) config.get("jsonPath");
        if (jsonPath != null && !jsonPath.isBlank()) {
            Object extracted = extractByJsonPath(parsedSource, jsonPath);
            result.put(outputVariable, extracted);
        }

        // 3. 如果没有 extractions 也没有 jsonPath，将整体解析结果输出
        if ((extractions == null || extractions.isEmpty()) && (jsonPath == null || jsonPath.isBlank())) {
            result.put(outputVariable, parsedSource);
        }
    }

    /**
     * 旧版 operation 兼容执行
     */
    private void executeLegacyOperation(String operation, Object source, Map<String, Object> config,
                                         String outputVariable, Map<String, Object> result) throws Exception {
        switch (operation) {
            case "parse":
                if (source instanceof String) {
                    Object parsed = objectMapper.readValue((String) source, Object.class);
                    result.put(outputVariable, parsed);
                } else {
                    result.put(outputVariable, source);
                }
                break;
            case "stringify":
                String jsonString = objectMapper.writeValueAsString(source);
                result.put(outputVariable, jsonString);
                break;
            case "extract":
                String path = (String) config.getOrDefault("path", "");
                Object extracted = extractByPath(source, path);
                result.put(outputVariable, extracted);
                break;
            default:
                log.warn("未知的operation: {}", operation);
                result.put(outputVariable, source);
        }
    }

    /**
     * 错误处理策略
     */
    private void handleError(String errorStrategy, Object defaultValue, String outputVariable,
                              Exception e, Map<String, Object> result) {
        switch (errorStrategy != null ? errorStrategy.toUpperCase() : "ERROR") {
            case "DEFAULT_VALUE":
                result.put("success", true);
                result.put(outputVariable, defaultValue);
                result.put("warning", "JSON解析失败，使用默认值: " + e.getMessage());
                break;
            case "SKIP":
                result.put("success", true);
                result.put("skipped", true);
                result.put("warning", "JSON解析失败，已跳过: " + e.getMessage());
                break;
            case "ERROR":
            default:
                result.put("success", false);
                result.put("error", e.getMessage());
                break;
        }
    }

    // ==================== 数据解析与提取工具方法 ====================

    /**
     * 确保数据已解析为 Java 对象（如果是 JSON 字符串则解析）
     */
    private Object ensureParsed(Object source) throws Exception {
        if (source instanceof String) {
            String str = ((String) source).trim();
            if (str.isEmpty()) {
                return null;
            }
            // 尝试解析 JSON
            if (str.startsWith("{") || str.startsWith("[")) {
                return objectMapper.readValue(str, Object.class);
            }
            // 非JSON字符串直接返回
            return str;
        }
        return source;
    }

    /**
     * 解析变量引用：支持带点号路径，如 "http_1.jsonBody.data"
     * <p>先尝试直接匹配完整 key，再尝试逐级深入。</p>
     */
    private Object resolveVariable(Map<String, Object> input, String variableName) {
        if (variableName == null || input == null) {
            return null;
        }
        // 1. 直接匹配完整 key
        if (input.containsKey(variableName)) {
            return input.get(variableName);
        }
        // 2. 尝试按点号拆分逐级解析
        int dotIdx = variableName.indexOf('.');
        if (dotIdx > 0) {
            String rootKey = variableName.substring(0, dotIdx);
            String remainingPath = variableName.substring(dotIdx + 1);
            Object root = input.get(rootKey);
            if (root != null) {
                return extractByPath(root, remainingPath);
            }
        }
        return null;
    }

    /**
     * 通过点号路径提取嵌套数据，支持数组索引。
     * <p>路径示例：</p>
     * <ul>
     *   <li>{@code data.user.name} — 多层对象嵌套</li>
     *   <li>{@code data.items[0].title} — 数组索引</li>
     *   <li>{@code results[2].tags[0]} — 多级数组索引</li>
     * </ul>
     */
    @SuppressWarnings("unchecked")
    private Object extractByPath(Object source, String path) {
        if (path == null || path.isEmpty() || source == null) {
            return source;
        }

        String[] parts = path.split("\\.");
        Object current = source;

        for (String part : parts) {
            if (current == null) {
                return null;
            }

            // 检查是否包含数组索引，如 items[0]
            Matcher matcher = ARRAY_INDEX_PATTERN.matcher(part);
            if (matcher.matches()) {
                String fieldName = matcher.group(1);
                int index = Integer.parseInt(matcher.group(2));

                // 先取字段
                current = getField(current, fieldName);
                // 再取索引
                if (current instanceof List) {
                    List<?> list = (List<?>) current;
                    current = (index >= 0 && index < list.size()) ? list.get(index) : null;
                } else if (current instanceof Object[]) {
                    Object[] arr = (Object[]) current;
                    current = (index >= 0 && index < arr.length) ? arr[index] : null;
                } else {
                    return null;
                }
            } else {
                // 纯字段名（也可能是纯数组索引如 [0]，但此场景由上面分支处理）
                current = getField(current, part);
            }
        }

        return current;
    }

    /**
     * 从 Map 或已解析的对象中获取字段
     */
    @SuppressWarnings("unchecked")
    private Object getField(Object source, String fieldName) {
        if (source instanceof Map) {
            return ((Map<String, Object>) source).get(fieldName);
        }
        return null;
    }

    /**
     * 简易 JSONPath 支持（将 $.a.b[0].c 转换为 a.b[0].c 后委托 extractByPath）
     */
    private Object extractByJsonPath(Object source, String jsonPath) {
        if (jsonPath == null || source == null) {
            return null;
        }
        // 去除 $ 前缀和通配符（简易实现）
        String path = jsonPath.trim();
        if (path.startsWith("$.")) {
            path = path.substring(2);
        } else if (path.startsWith("$")) {
            path = path.substring(1);
        }
        // 将 [*] 通配暂不支持，直接提取
        if (path.contains("[*]")) {
            log.warn("JSONPath 通配符 [*] 暂不支持完整语义，将尝试提取第一层匹配");
            path = path.replace("[*]", "[0]");
        }
        return extractByPath(source, path);
    }

    /**
     * 类型转换
     */
    private Object convertType(Object value, String dataType) {
        if (value == null || dataType == null) {
            return value;
        }
        try {
            switch (dataType.toUpperCase()) {
                case "STRING":
                    return (value instanceof String) ? value : String.valueOf(value);
                case "INTEGER":
                    if (value instanceof Number) return ((Number) value).longValue();
                    return Long.parseLong(String.valueOf(value).trim());
                case "DOUBLE":
                    if (value instanceof Number) return ((Number) value).doubleValue();
                    return Double.parseDouble(String.valueOf(value).trim());
                case "BOOLEAN":
                    if (value instanceof Boolean) return value;
                    return Boolean.parseBoolean(String.valueOf(value).trim());
                case "ARRAY":
                    if (value instanceof List) return value;
                    // 尝试将字符串解析为数组
                    if (value instanceof String) {
                        return objectMapper.readValue((String) value, List.class);
                    }
                    return value;
                case "OBJECT":
                    if (value instanceof Map) return value;
                    if (value instanceof String) {
                        return objectMapper.readValue((String) value, Map.class);
                    }
                    return value;
                default:
                    return value;
            }
        } catch (Exception e) {
            log.warn("类型转换失败: value={}, targetType={}, error={}", value, dataType, e.getMessage());
            return value;
        }
    }
}
