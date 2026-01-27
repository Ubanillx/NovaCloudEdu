package com.novacloudedu.backend.domain.ai.valueobject;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 工作流定义值对象
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WorkflowDefinition {
    
    private String version;
    
    @Builder.Default
    private List<WorkflowNode> nodes = new ArrayList<>();
    
    @Builder.Default
    private List<WorkflowEdge> edges = new ArrayList<>();
    
    @Builder.Default
    private Map<String, VariableDefinition> variables = new HashMap<>();
    
    @Builder.Default
    private WorkflowSettings settings = new WorkflowSettings();
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class VariableDefinition {
        private String name;
        private String type;
        private Object defaultValue;
        private String description;
    }
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class WorkflowSettings {
        @Builder.Default
        private long maxExecutionTimeMs = 60000;
        @Builder.Default
        private boolean enableLogging = true;
        @Builder.Default
        private LogLevel logLevel = LogLevel.INFO;
        @Builder.Default
        private boolean enableDebug = false;
    }
    
    public WorkflowNode findNodeById(String nodeId) {
        return nodes.stream()
                .filter(n -> n.getId().equals(nodeId))
                .findFirst()
                .orElse(null);
    }
    
    public WorkflowNode findStartNode() {
        return nodes.stream()
                .filter(n -> n.getType() == NodeType.START)
                .findFirst()
                .orElse(null);
    }
    
    public List<WorkflowEdge> findOutgoingEdges(String nodeId) {
        return edges.stream()
                .filter(e -> e.getSourceNodeId().equals(nodeId))
                .toList();
    }
    
    public List<WorkflowEdge> findIncomingEdges(String nodeId) {
        return edges.stream()
                .filter(e -> e.getTargetNodeId().equals(nodeId))
                .toList();
    }
}
