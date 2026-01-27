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
 * 合并节点执行器
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
        Map<String, Object> config = node.getConfig();
        
        String mergeMode = (String) config.getOrDefault("mode", "all");
        List<String> sourceVariables = (List<String>) config.getOrDefault("sources", List.of());
        String outputVariable = (String) config.getOrDefault("outputVariable", "merged");
        
        log.info("合并节点执行: mode={}, sourcesCount={}", mergeMode, sourceVariables.size());

        Map<String, Object> merged = new HashMap<>();
        
        if (sourceVariables.isEmpty()) {
            // 如果没有指定源变量，合并所有输入
            merged.putAll(input);
        } else {
            // 合并指定的变量
            for (String varName : sourceVariables) {
                Object value = input.get(varName);
                if (value != null) {
                    if (value instanceof Map) {
                        merged.putAll((Map<String, Object>) value);
                    } else {
                        merged.put(varName, value);
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
}
