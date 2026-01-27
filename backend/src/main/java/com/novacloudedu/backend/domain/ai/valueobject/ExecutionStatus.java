package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 工作流执行状态
 */
public enum ExecutionStatus {
    PENDING("等待执行"),
    RUNNING("执行中"),
    PAUSED("已暂停"),
    COMPLETED("已完成"),
    FAILED("执行失败"),
    CANCELLED("已取消"),
    TIMEOUT("执行超时");
    
    private final String description;
    
    ExecutionStatus(String description) {
        this.description = description;
    }
    
    public String getDescription() {
        return description;
    }
    
    public boolean isTerminal() {
        return this == COMPLETED || this == FAILED || this == CANCELLED || this == TIMEOUT;
    }
}
