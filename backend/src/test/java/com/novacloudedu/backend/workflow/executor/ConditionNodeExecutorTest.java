package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.ConditionNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 条件分支节点执行器单元测试
 * 基于实际ConditionNodeExecutor实现：使用单条件配置(variable, operator, value)
 */
@DisplayName("ConditionNodeExecutor 单元测试")
class ConditionNodeExecutorTest {

    private ConditionNodeExecutor executor;

    @BeforeEach
    void setUp() {
        executor = new ConditionNodeExecutor();
    }

    @Test
    @DisplayName("获取节点类型应返回CONDITION")
    void getNodeType_shouldReturnCondition() {
        assertEquals(NodeType.CONDITION, executor.getNodeType());
    }

    @Test
    @DisplayName("等于条件 - 字符串相等时应返回true")
    void execute_equalsCondition_stringEqual_shouldReturnTrue() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "status");
        config.put("operator", "==");
        config.put("value", "active");

        WorkflowNode node = WorkflowNode.builder()
                .id("condition_1")
                .type(NodeType.CONDITION)
                .name("状态检查")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("status", "active");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue((Boolean) result.get("conditionResult"));
        assertEquals("true", result.get("branch"));
    }

    @Test
    @DisplayName("等于条件 - 字符串不相等时应返回false")
    void execute_equalsCondition_stringNotEqual_shouldReturnFalse() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "status");
        config.put("operator", "==");
        config.put("value", "active");

        WorkflowNode node = WorkflowNode.builder()
                .id("condition_1")
                .type(NodeType.CONDITION)
                .name("状态检查")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("status", "inactive");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertFalse((Boolean) result.get("conditionResult"));
        assertEquals("false", result.get("branch"));
    }

    @Test
    @DisplayName("大于条件 - 数值大于时应返回true")
    void execute_greaterThanCondition_shouldReturnTrue() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "score");
        config.put("operator", ">");
        config.put("value", 60);

        WorkflowNode node = WorkflowNode.builder()
                .id("condition_1")
                .type(NodeType.CONDITION)
                .name("分数检查")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("score", 85);

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue((Boolean) result.get("conditionResult"));
    }

    @Test
    @DisplayName("小于条件 - 数值小于时应返回true")
    void execute_lessThanCondition_shouldReturnTrue() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "temperature");
        config.put("operator", "<");
        config.put("value", 37.5);

        WorkflowNode node = WorkflowNode.builder()
                .id("condition_1")
                .type(NodeType.CONDITION)
                .name("体温检查")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("temperature", 36.5);

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue((Boolean) result.get("conditionResult"));
    }

    @Test
    @DisplayName("包含条件 - 字符串包含时应返回true")
    void execute_containsCondition_shouldReturnTrue() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "message");
        config.put("operator", "contains");
        config.put("value", "error");

        WorkflowNode node = WorkflowNode.builder()
                .id("condition_1")
                .type(NodeType.CONDITION)
                .name("错误检查")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("message", "An error occurred in the system");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue((Boolean) result.get("conditionResult"));
    }

    @Test
    @DisplayName("空值检查 - 变量为空字符串时应返回true")
    void execute_isEmptyCondition_shouldReturnTrue() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "data");
        config.put("operator", "==");
        config.put("value", "");

        WorkflowNode node = WorkflowNode.builder()
                .id("condition_1")
                .type(NodeType.CONDITION)
                .name("数据检查")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("data", "");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue((Boolean) result.get("conditionResult"));
    }

    @Test
    @DisplayName("不等于条件 - 值不相等时应返回true")
    void execute_notEqualsCondition_shouldReturnTrue() {
        Map<String, Object> config = new HashMap<>();
        config.put("variable", "type");
        config.put("operator", "!=");
        config.put("value", "admin");

        WorkflowNode node = WorkflowNode.builder()
                .id("condition_1")
                .type(NodeType.CONDITION)
                .name("类型检查")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("type", "user");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue((Boolean) result.get("conditionResult"));
    }

    @Test
    @DisplayName("验证 - 缺少config应抛出异常")
    void validate_missingConfig_shouldThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("condition_1")
                .type(NodeType.CONDITION)
                .name("无效配置")
                .config(null)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }
}
