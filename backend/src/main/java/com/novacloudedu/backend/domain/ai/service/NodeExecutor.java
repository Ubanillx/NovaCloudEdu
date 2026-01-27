package com.novacloudedu.backend.domain.ai.service;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;

import java.util.Map;

/**
 * 节点执行器接口
 */
public interface NodeExecutor {
    
    /**
     * 获取支持的节点类型
     */
    NodeType getNodeType();
    
    /**
     * 执行节点
     */
    Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context);
    
    /**
     * 验证节点配置
     */
    void validate(WorkflowNode node);
}
