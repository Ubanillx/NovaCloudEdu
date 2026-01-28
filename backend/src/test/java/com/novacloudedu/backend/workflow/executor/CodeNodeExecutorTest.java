package com.novacloudedu.backend.workflow.executor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.CodeNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 代码执行节点执行器单元测试
 */
@DisplayName("CodeNodeExecutor 单元测试")
class CodeNodeExecutorTest {

    private CodeNodeExecutor executor;
    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() {
        objectMapper = new ObjectMapper();
        executor = new CodeNodeExecutor(objectMapper);
    }

    @Test
    @DisplayName("获取节点类型应返回CODE")
    void getNodeType_shouldReturnCode() {
        assertEquals(NodeType.CODE, executor.getNodeType());
    }

    @Test
    @DisplayName("空代码 - 应返回空结果")
    void execute_emptyCode_shouldReturnEmptyResult() {
        Map<String, Object> config = new HashMap<>();
        config.put("code", "");
        config.put("language", "javascript");

        WorkflowNode node = WorkflowNode.builder()
                .id("code_1")
                .type(NodeType.CODE)
                .name("空代码")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    @DisplayName("简单return语句 - 应返回变量值")
    void execute_simpleReturn_shouldReturnVariableValue() {
        Map<String, Object> config = new HashMap<>();
        config.put("code", "return name;");
        config.put("language", "javascript");

        WorkflowNode node = WorkflowNode.builder()
                .id("code_1")
                .type(NodeType.CODE)
                .name("简单返回")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("name", "张三");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("张三", result.get("result"));
    }

    @Test
    @DisplayName("返回字面量 - 应返回字面量值")
    void execute_returnLiteral_shouldReturnLiteralValue() {
        Map<String, Object> config = new HashMap<>();
        config.put("code", "return hello;");
        config.put("language", "javascript");

        WorkflowNode node = WorkflowNode.builder()
                .id("code_1")
                .type(NodeType.CODE)
                .name("返回字面量")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        // 变量不存在时返回表达式本身
        assertEquals("hello", result.get("result"));
    }

    @Test
    @DisplayName("验证 - 缺少code配置应抛出异常")
    void validate_missingCode_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("language", "javascript");

        WorkflowNode node = WorkflowNode.builder()
                .id("code_1")
                .type(NodeType.CODE)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 缺少config应抛出异常")
    void validate_missingConfig_shouldThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("code_1")
                .type(NodeType.CODE)
                .name("无效配置")
                .config(null)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }
}
