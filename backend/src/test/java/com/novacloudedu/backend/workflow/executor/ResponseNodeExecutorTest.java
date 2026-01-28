package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.ResponseNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 响应输出节点执行器单元测试
 */
@DisplayName("ResponseNodeExecutor 单元测试")
class ResponseNodeExecutorTest {

    private ResponseNodeExecutor executor;

    @BeforeEach
    void setUp() {
        executor = new ResponseNodeExecutor();
    }

    @Test
    @DisplayName("获取节点类型应返回RESPONSE")
    void getNodeType_shouldReturnResponse() {
        assertEquals(NodeType.RESPONSE, executor.getNodeType());
    }

    @Test
    @DisplayName("TEXT响应类型 - 应正确渲染模板")
    void execute_textResponseType_shouldRenderTemplate() {
        Map<String, Object> config = new HashMap<>();
        config.put("responseType", "TEXT");
        config.put("contentTemplate", "你好，{{name}}！你的订单{{orderId}}已完成。");

        WorkflowNode node = WorkflowNode.builder()
                .id("response_1")
                .type(NodeType.RESPONSE)
                .name("文本响应")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("name", "张三");
        input.put("orderId", "ORD123456");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("TEXT", result.get("responseType"));
        String response = (String) result.get("response");
        assertTrue(response.contains("张三"));
        assertTrue(response.contains("ORD123456"));
    }

    @Test
    @DisplayName("JSON响应类型 - 应正确构建JSON结构")
    void execute_jsonResponseType_shouldBuildJsonStructure() {
        Map<String, Object> config = new HashMap<>();
        config.put("responseType", "JSON");
        config.put("fields", List.of(
                Map.of("fieldName", "userName", "sourceVariable", "name"),
                Map.of("fieldName", "userAge", "sourceVariable", "age")
        ));

        WorkflowNode node = WorkflowNode.builder()
                .id("response_1")
                .type(NodeType.RESPONSE)
                .name("JSON响应")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("name", "李四");
        input.put("age", 30);

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("JSON", result.get("responseType"));
        @SuppressWarnings("unchecked")
        Map<String, Object> response = (Map<String, Object>) result.get("response");
        assertEquals("李四", response.get("userName"));
        assertEquals(30, response.get("userAge"));
    }

    @Test
    @DisplayName("VARIABLE响应类型 - 应返回指定变量的值")
    void execute_variableResponseType_shouldReturnVariableValue() {
        Map<String, Object> config = new HashMap<>();
        config.put("responseType", "VARIABLE");
        config.put("outputVariable", "result");

        WorkflowNode node = WorkflowNode.builder()
                .id("response_1")
                .type(NodeType.RESPONSE)
                .name("变量响应")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("result", Map.of("status", "success", "data", List.of(1, 2, 3)));

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("VARIABLE", result.get("responseType"));
        assertNotNull(result.get("response"));
    }

    @Test
    @DisplayName("默认字段值 - 当源变量不存在时应使用默认值")
    void execute_missingSourceVariable_shouldUseDefaultValue() {
        Map<String, Object> config = new HashMap<>();
        config.put("responseType", "JSON");
        config.put("fields", List.of(
                Map.of("fieldName", "status", "sourceVariable", "statusCode", "defaultValue", "unknown")
        ));

        WorkflowNode node = WorkflowNode.builder()
                .id("response_1")
                .type(NodeType.RESPONSE)
                .name("JSON响应")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        // statusCode 变量不存在

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        @SuppressWarnings("unchecked")
        Map<String, Object> response = (Map<String, Object>) result.get("response");
        assertEquals("unknown", response.get("status"));
    }
}
