package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.SwitchNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 多路分支节点执行器单元测试
 * 基于实际SwitchNodeExecutor实现：使用variable和cases配置
 */
@DisplayName("SwitchNodeExecutor 单元测试")
class SwitchNodeExecutorTest {

    private SwitchNodeExecutor executor;

    @BeforeEach
    void setUp() {
        executor = new SwitchNodeExecutor();
    }

    @Test
    @DisplayName("获取节点类型应返回SWITCH")
    void getNodeType_shouldReturnSwitch() {
        assertEquals(NodeType.SWITCH, executor.getNodeType());
    }

    @Test
    @DisplayName("字符串匹配 - 应返回对应分支")
    void execute_stringMatch_shouldReturnCorrectBranch() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "status");
        config.put("cases", List.of(
                Map.of("value", "pending", "branch", "pending_branch"),
                Map.of("value", "approved", "branch", "approved_branch"),
                Map.of("value", "rejected", "branch", "rejected_branch")
        ));
        config.put("default", "unknown_branch");

        WorkflowNode node = WorkflowNode.builder()
                .id("switch_1")
                .type(NodeType.SWITCH)
                .name("状态分支")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("status", "approved");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("approved_branch", result.get("matchedBranch"));
        assertEquals("approved", result.get("switchValue"));
    }

    @Test
    @DisplayName("数字匹配 - 应返回对应分支")
    void execute_numberMatch_shouldReturnCorrectBranch() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "level");
        config.put("cases", List.of(
                Map.of("value", 1, "branch", "level1"),
                Map.of("value", 2, "branch", "level2"),
                Map.of("value", 3, "branch", "level3")
        ));
        config.put("default", "default_level");

        WorkflowNode node = WorkflowNode.builder()
                .id("switch_1")
                .type(NodeType.SWITCH)
                .name("等级分支")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("level", 2);

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("level2", result.get("matchedBranch"));
    }

    @Test
    @DisplayName("无匹配时应返回默认分支")
    void execute_noMatch_shouldReturnDefaultBranch() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "type");
        config.put("cases", List.of(
                Map.of("value", "A", "branch", "branch_a"),
                Map.of("value", "B", "branch", "branch_b")
        ));
        config.put("default", "branch_other");

        WorkflowNode node = WorkflowNode.builder()
                .id("switch_1")
                .type(NodeType.SWITCH)
                .name("类型分支")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("type", "C");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("branch_other", result.get("matchedBranch"));
    }

    @Test
    @DisplayName("变量不存在时应返回默认分支")
    void execute_variableNotExist_shouldReturnDefaultBranch() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "category");
        config.put("cases", List.of(
                Map.of("value", "food", "branch", "food_branch"),
                Map.of("value", "drink", "branch", "drink_branch")
        ));
        config.put("default", "default_branch");

        WorkflowNode node = WorkflowNode.builder()
                .id("switch_1")
                .type(NodeType.SWITCH)
                .name("分类分支")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        // category 变量不存在

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("default_branch", result.get("matchedBranch"));
    }

    @Test
    @DisplayName("验证 - 缺少variable配置应抛出异常")
    void validate_missingVariable_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("cases", List.of(
                Map.of("value", "A", "branch", "branch_a")
        ));

        WorkflowNode node = WorkflowNode.builder()
                .id("switch_1")
                .type(NodeType.SWITCH)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 缺少config应抛出异常")
    void validate_missingConfig_shouldThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("switch_1")
                .type(NodeType.SWITCH)
                .name("无效配置")
                .config(null)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }
}
