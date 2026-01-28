package com.novacloudedu.backend.workflow.executor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.JsonParseNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * JSON解析节点执行器单元测试
 * 基于实际实现：使用sourceVariable和outputVariable配置，支持parse/stringify/extract操作
 */
@DisplayName("JsonParseNodeExecutor 单元测试")
class JsonParseNodeExecutorTest {

    private JsonParseNodeExecutor executor;
    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() {
        objectMapper = new ObjectMapper();
        executor = new JsonParseNodeExecutor(objectMapper);
    }

    @Test
    @DisplayName("获取节点类型应返回JSON_PARSE")
    void getNodeType_shouldReturnJsonParse() {
        assertEquals(NodeType.JSON_PARSE, executor.getNodeType());
    }

    @Test
    @DisplayName("parse操作 - 解析简单JSON对象")
    void execute_parseSimpleJson_shouldParseCorrectly() {
        Map<String, Object> config = new HashMap<>();
        config.put("sourceVariable", "jsonStr");
        config.put("outputVariable", "parsedData");
        config.put("operation", "parse");

        WorkflowNode node = WorkflowNode.builder()
                .id("json_1")
                .type(NodeType.JSON_PARSE)
                .name("JSON解析")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("jsonStr", "{\"name\":\"张三\",\"age\":25}");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue((Boolean) result.get("success"));
        @SuppressWarnings("unchecked")
        Map<String, Object> parsedData = (Map<String, Object>) result.get("parsedData");
        assertEquals("张三", parsedData.get("name"));
        assertEquals(25, ((Number) parsedData.get("age")).intValue());
    }

    @Test
    @DisplayName("parse操作 - 解析JSON数组")
    void execute_parseJsonArray_shouldParseCorrectly() {
        Map<String, Object> config = new HashMap<>();
        config.put("sourceVariable", "jsonStr");
        config.put("outputVariable", "items");
        config.put("operation", "parse");

        WorkflowNode node = WorkflowNode.builder()
                .id("json_1")
                .type(NodeType.JSON_PARSE)
                .name("JSON解析")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("jsonStr", "[{\"id\":1},{\"id\":2}]");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue((Boolean) result.get("success"));
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> items = (List<Map<String, Object>>) result.get("items");
        assertEquals(2, items.size());
    }

    @Test
    @DisplayName("stringify操作 - 序列化对象为JSON字符串")
    void execute_stringify_shouldSerializeToJson() {
        Map<String, Object> config = new HashMap<>();
        config.put("sourceVariable", "data");
        config.put("outputVariable", "jsonString");
        config.put("operation", "stringify");

        WorkflowNode node = WorkflowNode.builder()
                .id("json_1")
                .type(NodeType.JSON_PARSE)
                .name("JSON序列化")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("data", Map.of("name", "李四", "age", 30));

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue((Boolean) result.get("success"));
        String jsonString = (String) result.get("jsonString");
        assertTrue(jsonString.contains("李四"));
        assertTrue(jsonString.contains("30"));
    }

    @Test
    @DisplayName("extract操作 - 提取嵌套字段")
    void execute_extract_shouldExtractNestedField() {
        Map<String, Object> config = new HashMap<>();
        config.put("sourceVariable", "data");
        config.put("outputVariable", "city");
        config.put("operation", "extract");
        config.put("path", "address.city");

        WorkflowNode node = WorkflowNode.builder()
                .id("json_1")
                .type(NodeType.JSON_PARSE)
                .name("字段提取")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("data", Map.of("name", "王五", "address", Map.of("city", "北京", "zip", "100000")));

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertTrue((Boolean) result.get("success"));
        assertEquals("北京", result.get("city"));
    }

    @Test
    @DisplayName("parse操作 - 无效JSON应返回错误")
    void execute_parseInvalidJson_shouldReturnError() {
        Map<String, Object> config = new HashMap<>();
        config.put("sourceVariable", "jsonStr");
        config.put("outputVariable", "result");
        config.put("operation", "parse");

        WorkflowNode node = WorkflowNode.builder()
                .id("json_1")
                .type(NodeType.JSON_PARSE)
                .name("JSON解析")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("jsonStr", "这不是有效的JSON");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertFalse((Boolean) result.get("success"));
        assertNotNull(result.get("error"));
    }

    @Test
    @DisplayName("验证 - 配置可选，不应抛出异常")
    void validate_shouldNotThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("json_1")
                .type(NodeType.JSON_PARSE)
                .name("默认配置")
                .config(new HashMap<>())
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
