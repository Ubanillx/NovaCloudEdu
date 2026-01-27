package com.novacloudedu.backend.domain.ai.valueobject;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

/**
 * 工作流节点值对象
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WorkflowNode {
    
    private String id;
    private NodeType type;
    private String name;
    private Position position;
    private Map<String, Object> config;
    private ErrorHandlingConfig errorHandling;
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Position {
        private int x;
        private int y;
    }
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ErrorHandlingConfig {
        private ErrorHandlingStrategy onError;
        private int retryCount;
        private long retryDelayMs;
        private String fallbackNodeId;
        private long timeoutMs;
        
        public static ErrorHandlingConfig defaultConfig() {
            return ErrorHandlingConfig.builder()
                    .onError(ErrorHandlingStrategy.STOP)
                    .retryCount(3)
                    .retryDelayMs(1000)
                    .timeoutMs(30000)
                    .build();
        }
    }
}
