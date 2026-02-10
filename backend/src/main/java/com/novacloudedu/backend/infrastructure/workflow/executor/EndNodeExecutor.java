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
 * 结束节点执行器
 * 负责：
 * 1. 收集指定的输出变量作为工作流最终输出
 * 2. 如果未配置输出变量，则收集所有上下文变量
 */
@Slf4j
@Component
public class EndNodeExecutor implements NodeExecutor {

    @Override
    public NodeType getNodeType() {
        return NodeType.END;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig() != null ? node.getConfig() : Map.of();
        Map<String, Object> output = new HashMap<>();

        // 获取输出变量定义
        List<Map<String, Object>> outputVariables = (List<Map<String, Object>>) config.get("outputVariables");

        if (outputVariables != null && !outputVariables.isEmpty()) {
            // 按配置收集指定的输出变量
            for (Map<String, Object> varDef : outputVariables) {
                String varName = (String) varDef.get("name");
                String sourceVariable = (String) varDef.getOrDefault("sourceVariable", varName);

                if (varName == null || varName.isBlank()) {
                    continue;
                }

                Object value = input.get(sourceVariable);
                if (value != null) {
                    output.put(varName, value);
                }
            }
            log.info("结束节点执行: 收集 {} 个指定输出变量", output.size());
        } else {
            // 未配置输出变量，将所有非内部变量作为输出
            for (Map.Entry<String, Object> entry : input.entrySet()) {
                if (!entry.getKey().startsWith("_")) {
                    output.put(entry.getKey(), entry.getValue());
                }
            }
            log.info("结束节点执行: 透传全部变量，共 {} 个", output.size());
        }

        // 标记工作流输出（使用副本避免循环引用）
        output.put("_workflowOutput", new HashMap<>(output));

        return output;
    }

    @Override
    public void validate(WorkflowNode node) {
        // 结束节点配置可选
    }
}
