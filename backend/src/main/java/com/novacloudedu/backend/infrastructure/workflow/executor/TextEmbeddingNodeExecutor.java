package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.ai.DashScopeEmbeddingService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 文本向量化节点执行器
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class TextEmbeddingNodeExecutor implements NodeExecutor {

    private final DashScopeEmbeddingService embeddingService;

    @Override
    public NodeType getNodeType() {
        return NodeType.TEXT_EMBEDDING;
    }

    @Override
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String textVariable = (String) config.get("textVariable");
        String outputVariable = (String) config.getOrDefault("outputVariable", "embedding");
        
        // 获取要向量化的文本
        Object textObj = input.get(textVariable);
        String text = textObj != null ? String.valueOf(textObj) : "";
        
        if (text.isEmpty()) {
            log.warn("文本向量化节点输入为空: nodeId={}", node.getId());
            return Map.of(outputVariable, List.of());
        }

        log.info("文本向量化: nodeId={}, textLength={}", node.getId(), text.length());

        // 调用向量化服务
        var chapterVector = embeddingService.embedText(text);
        float[] vectorArray = chapterVector.toArray();
        
        // 转换为List<Double>
        List<Double> embedding = new java.util.ArrayList<>();
        for (float f : vectorArray) {
            embedding.add((double) f);
        }

        Map<String, Object> result = new HashMap<>();
        result.put(outputVariable, embedding);
        result.put("dimension", chapterVector.getDimension());
        
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null || !config.containsKey("textVariable")) {
            throw new IllegalArgumentException("文本向量化节点缺少textVariable配置");
        }
    }
}
