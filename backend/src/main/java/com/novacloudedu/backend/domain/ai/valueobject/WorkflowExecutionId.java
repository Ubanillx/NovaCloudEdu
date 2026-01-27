package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 工作流执行ID值对象
 */
public record WorkflowExecutionId(String value) {
    
    public static WorkflowExecutionId of(String value) {
        return new WorkflowExecutionId(value);
    }
    
    public static WorkflowExecutionId generate() {
        return new WorkflowExecutionId("exec_" + System.currentTimeMillis() + "_" + 
                (int)(Math.random() * 10000));
    }
}
