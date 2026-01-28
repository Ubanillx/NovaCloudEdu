package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.LoopNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 循环节点执行器单元测试
 * 基于实际LoopNodeExecutor实现：支持forEach和times两种循环类型
 */
@DisplayName("LoopNodeExecutor 单元测试")
class LoopNodeExecutorTest {

    private LoopNodeExecutor executor;
    private WorkflowExecution mockContext;

    @BeforeEach
    void setUp() {
        executor = new LoopNodeExecutor();
        mockContext = Mockito.mock(WorkflowExecution.class);
    }

    @Test
    @DisplayName("获取节点类型应返回LOOP")
    void getNodeType_shouldReturnLoop() {
        assertEquals(NodeType.LOOP, executor.getNodeType());
    }

    @Test
    @DisplayName("forEach循环 - 应正确遍历列表")
    void execute_forEachLoop_shouldIterateList() {
        Map<String, Object> config = new HashMap<>();
        config.put("loopType", "forEach");
        config.put("itemsVariable", "items");
        config.put("itemVariable", "item");
        config.put("indexVariable", "index");

        WorkflowNode node = WorkflowNode.builder()
                .id("loop_1")
                .type(NodeType.LOOP)
                .name("遍历列表")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("items", List.of("A", "B", "C"));

        Map<String, Object> result = executor.execute(node, input, mockContext);

        assertNotNull(result);
        assertEquals(3, result.get("loopCount"));
        assertTrue((Boolean) result.get("loopCompleted"));
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> loopResults = (List<Map<String, Object>>) result.get("loopResults");
        assertEquals(3, loopResults.size());
    }

    @Test
    @DisplayName("times循环 - 应正确执行指定次数")
    void execute_timesLoop_shouldExecuteSpecifiedTimes() {
        Map<String, Object> config = new HashMap<>();
        config.put("loopType", "times");
        config.put("times", 5);
        config.put("indexVariable", "i");

        WorkflowNode node = WorkflowNode.builder()
                .id("loop_1")
                .type(NodeType.LOOP)
                .name("计数循环")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, mockContext);

        assertNotNull(result);
        assertEquals(5, result.get("loopCount"));
        assertTrue((Boolean) result.get("loopCompleted"));
    }

    @Test
    @DisplayName("空列表 - 应返回0次循环")
    void execute_emptyList_shouldReturnZeroIterations() {
        Map<String, Object> config = new HashMap<>();
        config.put("loopType", "forEach");
        config.put("itemsVariable", "items");

        WorkflowNode node = WorkflowNode.builder()
                .id("loop_1")
                .type(NodeType.LOOP)
                .name("空列表循环")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("items", List.of());

        Map<String, Object> result = executor.execute(node, input, mockContext);

        assertNotNull(result);
        assertEquals(0, result.get("loopCount"));
    }

    @Test
    @DisplayName("最大迭代次数限制 - 应在达到限制时停止")
    void execute_maxIterations_shouldStopAtLimit() {
        Map<String, Object> config = new HashMap<>();
        config.put("loopType", "times");
        config.put("times", 200);
        config.put("maxIterations", 50);

        WorkflowNode node = WorkflowNode.builder()
                .id("loop_1")
                .type(NodeType.LOOP)
                .name("限制循环")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, mockContext);

        assertNotNull(result);
        assertEquals(50, result.get("loopCount"));
    }

    @Test
    @DisplayName("验证 - 循环节点配置可选，不应抛出异常")
    void validate_shouldNotThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("loop_1")
                .type(NodeType.LOOP)
                .name("默认配置")
                .config(new HashMap<>())
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
