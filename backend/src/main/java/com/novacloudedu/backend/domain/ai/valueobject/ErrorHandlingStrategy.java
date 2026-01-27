package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 错误处理策略
 */
public enum ErrorHandlingStrategy {
    STOP("停止执行"),
    CONTINUE("继续执行"),
    RETRY("重试"),
    FALLBACK("跳转到备用节点");
    
    private final String description;
    
    ErrorHandlingStrategy(String description) {
        this.description = description;
    }
    
    public String getDescription() {
        return description;
    }
}
