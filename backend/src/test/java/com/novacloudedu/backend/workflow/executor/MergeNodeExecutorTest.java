package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.MergeNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 合并节点执行器单元测试
 */
@DisplayName("MergeNodeExecutor 单元测试")
class MergeNodeExecutorTest {

    private MergeNodeExecutor executor;

    @BeforeEach
    void setUp() {
        executor = new MergeNodeExecutor();
    }

    @Test
    @DisplayName("获取节点类型应返回MERGE")
    void getNodeType_shouldReturnMerge() {
        assertEquals(NodeType.MERGE, executor.getNodeType());
    }

    @Test
    @DisplayName("无源变量 - 应合并所有输入")
    void execute_noSources_shouldMergeAllInput() {
        Map<String, Object> config = new HashMap<>();
        config.put("outputVariable", "merged");

        WorkflowNode node = WorkflowNode.builder()
                .id("merge_1")
                .type(NodeType.MERGE)
                .name("合并所有")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("name", "张三");
        input.put("age", 25);
        input.put("city", "北京");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        @SuppressWarnings("unchecked")
        Map<String, Object> merged = (Map<String, Object>) result.get("merged");
        assertEquals(3, merged.size());
        assertEquals("张三", merged.get("name"));
        assertEquals(25, merged.get("age"));
    }

    @Test
    @DisplayName("指定源变量 - 应只合并指定变量")
    void execute_withSources_shouldMergeSpecifiedVariables() {
        Map<String, Object> config = new HashMap<>();
        config.put("sources", List.of("user", "order"));
        config.put("outputVariable", "result");

        WorkflowNode node = WorkflowNode.builder()
                .id("merge_1")
                .type(NodeType.MERGE)
                .name("合并指定变量")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("user", Map.of("name", "李四", "age", 30));
        input.put("order", Map.of("orderId", "ORD001", "amount", 100));
        input.put("extra", "不应该被合并");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        @SuppressWarnings("unchecked")
        Map<String, Object> merged = (Map<String, Object>) result.get("result");
        assertEquals("李四", merged.get("name"));
        assertEquals("ORD001", merged.get("orderId"));
        assertNull(merged.get("extra"));
    }

    @Test
    @DisplayName("合并非Map变量 - 应保留变量名")
    void execute_nonMapVariable_shouldKeepVariableName() {
        Map<String, Object> config = new HashMap<>();
        config.put("sources", List.of("count", "status"));
        config.put("outputVariable", "merged");

        WorkflowNode node = WorkflowNode.builder()
                .id("merge_1")
                .type(NodeType.MERGE)
                .name("合并非Map")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("count", 10);
        input.put("status", "active");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        @SuppressWarnings("unchecked")
        Map<String, Object> merged = (Map<String, Object>) result.get("merged");
        assertEquals(10, merged.get("count"));
        assertEquals("active", merged.get("status"));
    }

    @Test
    @DisplayName("空输入 - 应返回空合并结果")
    void execute_emptyInput_shouldReturnEmptyMerged() {
        Map<String, Object> config = new HashMap<>();
        config.put("outputVariable", "merged");

        WorkflowNode node = WorkflowNode.builder()
                .id("merge_1")
                .type(NodeType.MERGE)
                .name("空合并")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals(0, result.get("mergedCount"));
    }

    @Test
    @DisplayName("验证 - 配置可选，不应抛出异常")
    void validate_shouldNotThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("merge_1")
                .type(NodeType.MERGE)
                .name("默认配置")
                .config(new HashMap<>())
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
