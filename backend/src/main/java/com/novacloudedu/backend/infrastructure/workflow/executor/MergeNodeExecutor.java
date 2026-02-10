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
 * 合并节点执行器 — 将多个分支的结果合并为一个输出
 *
 * <h3>执行逻辑概览</h3>
 * <pre>
 * 1. 读取 config.mode (默认 "all")、config.sources (源变量名列表)、config.outputVariable (输出 key)
 * 2. 如果 sources 为空 → 合并所有输入变量（过滤以 _ 前缀的内部变量）
 * 3. 如果 sources 非空 → 根据 mode 处理指定变量：
 *    - "all"  : 合并所有指定源变量，重复键后者覆盖前者（warn 日志）
 *    - "first": 只取第一个非空源变量
 *    - "last" : 只取最后一个非空源变量
 * 4. 将合并结果放入 output[outputVariable]，同时输出 mergedCount
 * </pre>
 *
 * <h3>输出 Map</h3>
 * <ul>
 *   <li>outputVariable (默认 "merged") : Map — 合并后的结果</li>
 *   <li>mergedCount : int — 合并结果中的键数量</li>
 * </ul>
 *
 * <h3>引擎侧处理</h3>
 * <p>合并节点作为普通节点执行，执行完成后输出写入 execution.variables，
 * 然后走普通出边继续后续节点。通常用于并行节点后的结果汇总。</p>
 *
 * <h3>边界条件处理</h3>
 * <ul>
 *   <li>config 为 null → 使用默认值 (mode="all", sources=空, outputVariable="merged")</li>
 *   <li>mode 为 null → 默认 "all"</li>
 *   <li>sources 为 null → 视为空列表，合并所有输入</li>
 *   <li>源变量为 null → 跳过（debug 日志）</li>
 *   <li>以 _ 前缀的内部变量在全输入模式下自动过滤</li>
 * </ul>
 */
@Slf4j
@Component
public class MergeNodeExecutor implements NodeExecutor {

    @Override
    public NodeType getNodeType() {
        return NodeType.MERGE;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig() != null ? node.getConfig() : Map.of();
        if (input == null) input = Map.of();
        
        String mergeMode = (String) config.getOrDefault("mode", "all");
        if (mergeMode == null) mergeMode = "all";
        List<String> sourceVariables = (List<String>) config.getOrDefault("sources", List.of());
        if (sourceVariables == null) sourceVariables = List.of();
        String outputVariable = (String) config.getOrDefault("outputVariable", "merged");
        if (outputVariable == null) outputVariable = "merged";
        
        log.info("合并节点执行: mode={}, sourcesCount={}", mergeMode, sourceVariables.size());

        Map<String, Object> merged = new HashMap<>();
        
        if (sourceVariables.isEmpty()) {
            // 如果没有指定源变量，合并所有输入（过滤内部变量）
            for (Map.Entry<String, Object> entry : input.entrySet()) {
                if (!entry.getKey().startsWith("_")) {
                    merged.put(entry.getKey(), entry.getValue());
                }
            }
        } else {
            // 根据合并模式处理指定变量
            switch (mergeMode.toLowerCase()) {
                case "first" -> {
                    // 只取第一个非空源变量
                    for (String varName : sourceVariables) {
                        Object value = resolveValue(varName, input);
                        if (value != null) {
                            if (value instanceof Map) {
                                merged.putAll((Map<String, Object>) value);
                            } else {
                                merged.put(varName, value);
                            }
                            break;
                        }
                    }
                }
                case "last" -> {
                    // 只取最后一个非空源变量
                    for (int i = sourceVariables.size() - 1; i >= 0; i--) {
                        String varName = sourceVariables.get(i);
                        Object value = resolveValue(varName, input);
                        if (value != null) {
                            if (value instanceof Map) {
                                merged.putAll((Map<String, Object>) value);
                            } else {
                                merged.put(varName, value);
                            }
                            break;
                        }
                    }
                }
                default -> {
                    if (!"all".equalsIgnoreCase(mergeMode)) {
                        log.warn("合并节点未知的合并模式: '{}', 回退到 'all' 模式", mergeMode);
                    }
                    // "all" 模式（默认）：合并所有指定变量
                    for (String varName : sourceVariables) {
                        Object value = resolveValue(varName, input);
                        if (value != null) {
                            if (value instanceof Map) {
                                Map<String, Object> mapValue = (Map<String, Object>) value;
                                for (String key : mapValue.keySet()) {
                                    if (merged.containsKey(key)) {
                                        log.warn("合并节点键覆盖: source='{}', key='{}', oldValue={}, newValue={}", 
                                                varName, key, merged.get(key), mapValue.get(key));
                                    }
                                }
                                merged.putAll(mapValue);
                            } else {
                                merged.put(varName, value);
                            }
                        } else {
                            log.debug("合并节点: 源变量[{}]不存在或为null，跳过", varName);
                        }
                    }
                }
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put(outputVariable, merged);
        result.put("mergedCount", merged.size());
        
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        // 合并节点配置可选
    }

    /**
     * 解析变量值，支持嵌套路径如 "node1.result"。
     * 查找策略：直接匹配 → 嵌套路径 → 去掉前缀用最后一段匹配。
     */
    @SuppressWarnings("unchecked")
    private Object resolveValue(String path, Map<String, Object> input) {
        if (path == null || path.isBlank()) return null;
        if (input.containsKey(path)) return input.get(path);
        String[] parts = path.split("\\.");
        if (parts.length > 1) {
            Object current = input;
            boolean resolved = true;
            for (String part : parts) {
                if (current instanceof Map) {
                    current = ((Map<String, Object>) current).get(part);
                } else {
                    resolved = false;
                    break;
                }
                if (current == null) { resolved = false; break; }
            }
            if (resolved && current != null) return current;
            String lastPart = parts[parts.length - 1];
            if (input.containsKey(lastPart)) {
                log.debug("合并节点变量回退解析: '{}' → '{}'", path, lastPart);
                return input.get(lastPart);
            }
        }
        return null;
    }
}
