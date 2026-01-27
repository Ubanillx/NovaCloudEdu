package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 节点执行状态
 */
public enum NodeExecutionStatus {
    PENDING("等待执行"),
    RUNNING("执行中"),
    COMPLETED("已完成"),
    FAILED("执行失败"),
    SKIPPED("已跳过"),
    TIMEOUT("执行超时");
    
    private final String description;
    
    NodeExecutionStatus(String description) {
        this.description = description;
    }
    
    public String getDescription() {
        return description;
    }
}
