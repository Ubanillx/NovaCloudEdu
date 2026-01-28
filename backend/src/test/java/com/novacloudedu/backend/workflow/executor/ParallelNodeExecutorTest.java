package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.ParallelNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 并行执行节点执行器单元测试
 */
@DisplayName("ParallelNodeExecutor 单元测试")
class ParallelNodeExecutorTest {

    private ParallelNodeExecutor executor;

    @BeforeEach
    void setUp() {
        executor = new ParallelNodeExecutor();
    }

    @Test
    @DisplayName("获取节点类型应返回PARALLEL")
    void getNodeType_shouldReturnParallel() {
        assertEquals(NodeType.PARALLEL, executor.getNodeType());
    }

    @Test
    @DisplayName("执行 - 应返回分支配置信息")
    void execute_shouldReturnBranchConfig() {
        Map<String, Object> config = new HashMap<>();
        config.put("branchNodeIds", List.of("branch_1", "branch_2", "branch_3"));
        config.put("mergeNodeId", "merge_node");
        config.put("timeout", 30000L);
        config.put("waitAll", true);

        WorkflowNode node = WorkflowNode.builder()
                .id("parallel_1")
                .type(NodeType.PARALLEL)
                .name("并行执行")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        @SuppressWarnings("unchecked")
        List<String> branches = (List<String>) result.get("_parallelBranches");
        assertEquals(3, branches.size());
        assertTrue(branches.contains("branch_1"));
        assertEquals("merge_node", result.get("_mergeNodeId"));
        assertEquals(30000L, result.get("_timeout"));
        assertTrue((Boolean) result.get("_waitAll"));
        assertNotNull(result.get("_parallelStartTime"));
    }

    @Test
    @DisplayName("执行 - 默认超时时间应为60秒")
    void execute_defaultTimeout_shouldBe60Seconds() {
        Map<String, Object> config = new HashMap<>();
        config.put("branchNodeIds", List.of("branch_1"));

        WorkflowNode node = WorkflowNode.builder()
                .id("parallel_1")
                .type(NodeType.PARALLEL)
                .name("并行执行")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals(60000L, result.get("_timeout"));
    }

    @Test
    @DisplayName("验证 - 缺少branchNodeIds应抛出异常")
    void validate_missingBranchNodeIds_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("mergeNodeId", "merge_node");

        WorkflowNode node = WorkflowNode.builder()
                .id("parallel_1")
                .type(NodeType.PARALLEL)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 缺少config应抛出异常")
    void validate_missingConfig_shouldThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("parallel_1")
                .type(NodeType.PARALLEL)
                .name("无效配置")
                .config(null)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }
}
