package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 循环节点执行器
 */
@Slf4j
@Component
public class LoopNodeExecutor implements NodeExecutor {

    @Override
    public NodeType getNodeType() {
        return NodeType.LOOP;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String loopType = (String) config.getOrDefault("loopType", "forEach");
        String itemsVariable = (String) config.getOrDefault("itemsVariable", "items");
        String itemVariable = (String) config.getOrDefault("itemVariable", "item");
        String indexVariable = (String) config.getOrDefault("indexVariable", "index");
        int maxIterations = (int) config.getOrDefault("maxIterations", 100);
        
        List<Object> items;
        if ("forEach".equals(loopType)) {
            Object itemsObj = input.get(itemsVariable);
            if (itemsObj instanceof List) {
                items = (List<Object>) itemsObj;
            } else {
                items = new ArrayList<>();
            }
        } else if ("times".equals(loopType)) {
            int times = (int) config.getOrDefault("times", 1);
            items = new ArrayList<>();
            for (int i = 0; i < Math.min(times, maxIterations); i++) {
                items.add(i);
            }
        } else {
            items = new ArrayList<>();
        }

        log.info("循环节点执行: loopType={}, itemsCount={}", loopType, items.size());

        List<Map<String, Object>> results = new ArrayList<>();
        int index = 0;
        
        for (Object item : items) {
            if (index >= maxIterations) {
                log.warn("循环达到最大迭代次数: {}", maxIterations);
                break;
            }
            
            Map<String, Object> iterationResult = new HashMap<>();
            iterationResult.put(itemVariable, item);
            iterationResult.put(indexVariable, index);
            results.add(iterationResult);
            
            // 设置当前迭代的变量到上下文
            context.setVariable(itemVariable, item);
            context.setVariable(indexVariable, index);
            
            index++;
        }

        Map<String, Object> result = new HashMap<>();
        result.put("loopResults", results);
        result.put("loopCount", results.size());
        result.put("loopCompleted", true);
        
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        // 循环节点配置可选
    }
}
