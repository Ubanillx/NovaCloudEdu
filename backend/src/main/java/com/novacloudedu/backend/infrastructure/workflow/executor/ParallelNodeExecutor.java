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
 * 并行执行节点执行器
 * 注意：实际的并行执行由WorkflowEngine处理，此执行器主要用于标记和配置
 */
@Slf4j
@Component
public class ParallelNodeExecutor implements NodeExecutor {

    @Override
    public NodeType getNodeType() {
        return NodeType.PARALLEL;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        List<String> branchNodeIds = (List<String>) config.get("branchNodeIds");
        String mergeNodeId = (String) config.get("mergeNodeId");
        Long timeout = getLong(config, "timeout", 60000L);
        Boolean waitAll = (Boolean) config.getOrDefault("waitAll", true);
        
        log.info("并行节点开始: nodeId={}, branches={}, mergeNode={}", 
                node.getId(), branchNodeIds, mergeNodeId);

        // 并行节点本身不执行具体逻辑，只是标记分支信息
        // 实际的并行执行由WorkflowEngine根据这些配置来处理
        Map<String, Object> result = new HashMap<>();
        result.put("_parallelBranches", branchNodeIds);
        result.put("_mergeNodeId", mergeNodeId);
        result.put("_timeout", timeout);
        result.put("_waitAll", waitAll);
        result.put("_parallelStartTime", System.currentTimeMillis());
        
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null) {
            throw new IllegalArgumentException("并行节点缺少配置");
        }
        if (!config.containsKey("branchNodeIds")) {
            throw new IllegalArgumentException("并行节点缺少branchNodeIds配置");
        }
    }

    private Long getLong(Map<String, Object> config, String key, long defaultValue) {
        Object value = config.get(key);
        if (value == null) return defaultValue;
        if (value instanceof Number) return ((Number) value).longValue();
        return defaultValue;
    }
}
