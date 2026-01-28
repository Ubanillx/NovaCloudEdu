package com.novacloudedu.backend.infrastructure.workflow;

import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * 节点执行器注册表
 */
@Slf4j
@Component
public class NodeExecutorRegistry {

    private final Map<NodeType, NodeExecutor> executors = new HashMap<>();

    public NodeExecutorRegistry(List<NodeExecutor> executorList) {
        for (NodeExecutor executor : executorList) {
            NodeType nodeType = executor.getNodeType();
            if (executors.containsKey(nodeType)) {
                log.warn("节点执行器重复注册: nodeType={}, existing={}, new={}",
                        nodeType, executors.get(nodeType).getClass().getSimpleName(),
                        executor.getClass().getSimpleName());
            }
            executors.put(nodeType, executor);
            log.info("注册节点执行器: nodeType={}, executor={}", nodeType, executor.getClass().getSimpleName());
        }
    }

    public Optional<NodeExecutor> getExecutor(NodeType nodeType) {
        return Optional.ofNullable(executors.get(nodeType));
    }

    public NodeExecutor getExecutorOrThrow(NodeType nodeType) {
        return getExecutor(nodeType)
                .orElseThrow(() -> new IllegalArgumentException("未找到节点执行器: " + nodeType));
    }

    public boolean hasExecutor(NodeType nodeType) {
        return executors.containsKey(nodeType);
    }

    public int getRegisteredCount() {
        return executors.size();
    }
}
