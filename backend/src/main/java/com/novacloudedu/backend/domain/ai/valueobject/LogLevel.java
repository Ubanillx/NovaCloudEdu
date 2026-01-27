package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 日志级别
 */
public enum LogLevel {
    DEBUG(0),
    INFO(1),
    WARN(2),
    ERROR(3);
    
    private final int level;
    
    LogLevel(int level) {
        this.level = level;
    }
    
    public int getLevel() {
        return level;
    }
    
    public boolean isEnabled(LogLevel configuredLevel) {
        return this.level >= configuredLevel.level;
    }
}
