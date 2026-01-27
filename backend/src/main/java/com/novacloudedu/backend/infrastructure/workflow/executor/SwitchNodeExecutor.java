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
 * 多路分支节点执行器
 */
@Slf4j
@Component
public class SwitchNodeExecutor implements NodeExecutor {

    @Override
    public NodeType getNodeType() {
        return NodeType.SWITCH;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String variableName = (String) config.getOrDefault("variable", "");
        List<Map<String, Object>> cases = (List<Map<String, Object>>) config.getOrDefault("cases", List.of());
        String defaultBranch = (String) config.getOrDefault("default", "default");
        
        Object actualValue = input.get(variableName);
        String actualValueStr = actualValue != null ? String.valueOf(actualValue) : "";
        
        log.info("Switch节点执行: variable={}, value={}, casesCount={}", 
                variableName, actualValueStr, cases.size());

        String matchedBranch = defaultBranch;
        
        for (Map<String, Object> caseItem : cases) {
            Object caseValue = caseItem.get("value");
            String caseBranch = (String) caseItem.getOrDefault("branch", "");
            
            if (caseValue != null && String.valueOf(caseValue).equals(actualValueStr)) {
                matchedBranch = caseBranch;
                break;
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put("switchValue", actualValueStr);
        result.put("matchedBranch", matchedBranch);
        result.put("branch", matchedBranch);
        
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        if (node.getConfig() == null || !node.getConfig().containsKey("variable")) {
            throw new IllegalArgumentException("Switch节点缺少variable配置");
        }
    }
}
