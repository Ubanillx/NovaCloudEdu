package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 工作流ID值对象
 */
public record WorkflowId(Long value) {
    
    public static WorkflowId of(Long value) {
        return new WorkflowId(value);
    }
}
