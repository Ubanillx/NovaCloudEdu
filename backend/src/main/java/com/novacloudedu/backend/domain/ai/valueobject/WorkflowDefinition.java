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
    
    /**
     * 展平 LOOP 容器节点的子节点和内部边到主列表，
     * 使引擎可以通过 findNodeById / findOutgoingEdges 访问子节点。
     */
    public void flattenChildren() {
        List<WorkflowNode> childNodesToAdd = new ArrayList<>();
        List<WorkflowEdge> childEdgesToAdd = new ArrayList<>();
        // Fix #12+: 递归展平所有层级的 LOOP / PARALLEL 容器子节点
        collectChildrenRecursive(this.nodes, childNodesToAdd, childEdgesToAdd);
        this.nodes.addAll(childNodesToAdd);
        this.edges.addAll(childEdgesToAdd);
    }

    private void collectChildrenRecursive(List<WorkflowNode> nodesToScan,
                                           List<WorkflowNode> outNodes,
                                           List<WorkflowEdge> outEdges) {
        for (WorkflowNode node : nodesToScan) {
            if ((node.getType() == NodeType.LOOP || node.getType() == NodeType.PARALLEL)
                    && node.getChildren() != null) {
                WorkflowNode.ChildrenDefinition ch = node.getChildren();
                if (ch.getNodes() != null) {
                    outNodes.addAll(ch.getNodes());
                    // 递归处理子节点中可能存在的嵌套容器
                    collectChildrenRecursive(ch.getNodes(), outNodes, outEdges);
                }
                if (ch.getEdges() != null) {
                    outEdges.addAll(ch.getEdges());
                }
            }
        }
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

    /**
     * 深拷贝工作流定义
     */
    public WorkflowDefinition copy() {
        List<WorkflowNode> copiedNodes = new ArrayList<>();
        for (WorkflowNode node : this.nodes) {
            copiedNodes.add(WorkflowNode.builder()
                    .id(node.getId())
                    .type(node.getType())
                    .name(node.getName())
                    .position(node.getPosition() != null ? 
                            WorkflowNode.Position.builder()
                                    .x(node.getPosition().getX())
                                    .y(node.getPosition().getY())
                                    .build() : null)
                    .config(node.getConfig() != null ? new HashMap<>(node.getConfig()) : null)
                    .errorHandling(node.getErrorHandling())
                    .children(node.getChildren())
                    .width(node.getWidth())
                    .height(node.getHeight())
                    .build());
        }

        List<WorkflowEdge> copiedEdges = new ArrayList<>();
        for (WorkflowEdge edge : this.edges) {
            copiedEdges.add(WorkflowEdge.builder()
                    .id(edge.getId())
                    .sourceNodeId(edge.getSourceNodeId())
                    .targetNodeId(edge.getTargetNodeId())
                    .sourceHandle(edge.getSourceHandle())
                    .targetHandle(edge.getTargetHandle())
                    .condition(edge.getCondition())
                    .label(edge.getLabel())
                    .build());
        }

        Map<String, VariableDefinition> copiedVariables = new HashMap<>();
        for (Map.Entry<String, VariableDefinition> entry : this.variables.entrySet()) {
            VariableDefinition v = entry.getValue();
            copiedVariables.put(entry.getKey(), VariableDefinition.builder()
                    .name(v.getName())
                    .type(v.getType())
                    .defaultValue(v.getDefaultValue())
                    .description(v.getDescription())
                    .build());
        }

        return WorkflowDefinition.builder()
                .version(this.version)
                .nodes(copiedNodes)
                .edges(copiedEdges)
                .variables(copiedVariables)
                .settings(WorkflowSettings.builder()
                        .maxExecutionTimeMs(this.settings.getMaxExecutionTimeMs())
                        .enableLogging(this.settings.isEnableLogging())
                        .logLevel(this.settings.getLogLevel())
                        .enableDebug(this.settings.isEnableDebug())
                        .build())
                .build();
    }
}
