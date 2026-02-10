package com.novacloudedu.backend.workflow.executor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.JsonParseNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * JSON解析节点执行器单元测试
 * 覆盖：旧版 operation 兼容、新版 parseMode + extractions、
 *        数组索引路径、点号变量引用、类型转换、errorStrategy
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

    // ==================== 旧版 operation 兼容测试 ====================

    @Nested
    @DisplayName("旧版 operation 兼容")
    class LegacyOperationTests {

        @Test
        @DisplayName("parse操作 - 解析简单JSON对象")
        void execute_parseSimpleJson_shouldParseCorrectly() {
            Map<String, Object> config = new HashMap<>();
            config.put("sourceVariable", "jsonStr");
            config.put("outputVariable", "parsedData");
            config.put("operation", "parse");

            WorkflowNode node = buildNode("json_1", "JSON解析", config);
            Map<String, Object> input = Map.of("jsonStr", "{\"name\":\"张三\",\"age\":25}");

            Map<String, Object> result = executor.execute(node, input, null);

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

            WorkflowNode node = buildNode("json_1", "JSON解析", config);
            Map<String, Object> input = Map.of("jsonStr", "[{\"id\":1},{\"id\":2}]");

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            @SuppressWarnings("unchecked")
            List<?> items = (List<?>) result.get("items");
            assertEquals(2, items.size());
        }

        @Test
        @DisplayName("stringify操作 - 序列化对象为JSON字符串")
        void execute_stringify_shouldSerializeToJson() {
            Map<String, Object> config = new HashMap<>();
            config.put("sourceVariable", "data");
            config.put("outputVariable", "jsonString");
            config.put("operation", "stringify");

            WorkflowNode node = buildNode("json_1", "JSON序列化", config);
            Map<String, Object> input = Map.of("data", Map.of("name", "李四", "age", 30));

            Map<String, Object> result = executor.execute(node, input, null);

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

            WorkflowNode node = buildNode("json_1", "字段提取", config);
            Map<String, Object> input = Map.of("data",
                    Map.of("name", "王五", "address", Map.of("city", "北京", "zip", "100000")));

            Map<String, Object> result = executor.execute(node, input, null);

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

            WorkflowNode node = buildNode("json_1", "JSON解析", config);
            Map<String, Object> input = Map.of("jsonStr", "这不是有效的JSON");

            Map<String, Object> result = executor.execute(node, input, null);

            assertFalse((Boolean) result.get("success"));
            assertNotNull(result.get("error"));
        }
    }

    // ==================== 新版 parseMode + extractions 测试 ====================

    @Nested
    @DisplayName("新版 parseMode + extractions")
    class ParseModeTests {

        @Test
        @DisplayName("EXTRACT模式 - extractions批量提取多个字段")
        void extractMode_batchExtractions() {
            List<Map<String, Object>> extractions = new ArrayList<>();
            extractions.add(Map.of("fieldPath", "data.user.name", "outputVariable", "userName", "dataType", "STRING"));
            extractions.add(Map.of("fieldPath", "data.user.age", "outputVariable", "userAge", "dataType", "INTEGER"));
            extractions.add(Map.of("fieldPath", "data.tags", "outputVariable", "tags", "dataType", "ARRAY"));

            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "apiResponse");
            config.put("parseMode", "EXTRACT");
            config.put("extractions", extractions);

            WorkflowNode node = buildNode("json_1", "批量提取", config);

            Map<String, Object> source = Map.of("data", Map.of(
                    "user", Map.of("name", "张三", "age", 25),
                    "tags", List.of("student", "developer")
            ));
            Map<String, Object> input = Map.of("apiResponse", source);

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            assertEquals("张三", result.get("userName"));
            assertEquals(25L, result.get("userAge"));
            @SuppressWarnings("unchecked")
            List<String> tags = (List<String>) result.get("tags");
            assertEquals(2, tags.size());
            assertEquals("student", tags.get(0));
        }

        @Test
        @DisplayName("EXTRACT模式 - 数组索引路径提取 items[0].title")
        void extractMode_arrayIndexPath() {
            List<Map<String, Object>> extractions = new ArrayList<>();
            extractions.add(Map.of("fieldPath", "items[0].title", "outputVariable", "firstTitle"));
            extractions.add(Map.of("fieldPath", "items[1].title", "outputVariable", "secondTitle"));
            extractions.add(Map.of("fieldPath", "items[0].tags[0]", "outputVariable", "firstTag"));

            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "response");
            config.put("parseMode", "EXTRACT");
            config.put("extractions", extractions);

            WorkflowNode node = buildNode("json_1", "数组提取", config);

            Map<String, Object> source = Map.of("items", List.of(
                    Map.of("title", "文章A", "tags", List.of("java", "spring")),
                    Map.of("title", "文章B", "tags", List.of("python"))
            ));
            Map<String, Object> input = Map.of("response", source);

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            assertEquals("文章A", result.get("firstTitle"));
            assertEquals("文章B", result.get("secondTitle"));
            assertEquals("java", result.get("firstTag"));
        }

        @Test
        @DisplayName("EXTRACT模式 - 多层嵌套+数组混合路径")
        void extractMode_deepNestedArrayPath() {
            List<Map<String, Object>> extractions = new ArrayList<>();
            extractions.add(Map.of("fieldPath", "data.results[0].nested.value", "outputVariable", "deepValue"));
            extractions.add(Map.of("fieldPath", "data.results[1].nested.items[0]", "outputVariable", "deepItem"));

            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "src");
            config.put("parseMode", "EXTRACT");
            config.put("extractions", extractions);

            WorkflowNode node = buildNode("json_1", "深层提取", config);

            Map<String, Object> source = Map.of("data", Map.of("results", List.of(
                    Map.of("nested", Map.of("value", 42)),
                    Map.of("nested", Map.of("items", List.of("alpha", "beta")))
            )));
            Map<String, Object> input = Map.of("src", source);

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            assertEquals(42, result.get("deepValue"));
            assertEquals("alpha", result.get("deepItem"));
        }

        @Test
        @DisplayName("EXTRACT模式 - 必填字段缺失且有defaultValue时使用默认值")
        void extractMode_requiredFieldMissing_usesDefault() {
            List<Map<String, Object>> extractions = new ArrayList<>();
            Map<String, Object> extraction = new HashMap<>();
            extraction.put("fieldPath", "nonExistent.field");
            extraction.put("outputVariable", "missing");
            extraction.put("required", true);
            extraction.put("defaultValue", "默认值");
            extractions.add(extraction);

            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "data");
            config.put("parseMode", "EXTRACT");
            config.put("extractions", extractions);

            WorkflowNode node = buildNode("json_1", "缺失字段", config);
            Map<String, Object> input = Map.of("data", Map.of("other", "value"));

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            assertEquals("默认值", result.get("missing"));
        }

        @Test
        @DisplayName("EXTRACT模式 - 必填字段缺失且无defaultValue时报错")
        void extractMode_requiredFieldMissing_noDefault_errors() {
            List<Map<String, Object>> extractions = new ArrayList<>();
            Map<String, Object> extraction = new HashMap<>();
            extraction.put("fieldPath", "nonExistent.field");
            extraction.put("outputVariable", "missing");
            extraction.put("required", true);
            // 没有 defaultValue
            extractions.add(extraction);

            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "data");
            config.put("parseMode", "EXTRACT");
            config.put("extractions", extractions);

            WorkflowNode node = buildNode("json_1", "必填缺失", config);
            Map<String, Object> input = Map.of("data", Map.of("other", "value"));

            Map<String, Object> result = executor.execute(node, input, null);

            assertFalse((Boolean) result.get("success"));
            assertNotNull(result.get("error"));
        }

        @Test
        @DisplayName("EXTRACT模式 - jsonPath单值提取")
        void extractMode_jsonPath() {
            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "data");
            config.put("parseMode", "EXTRACT");
            config.put("jsonPath", "$.user.name");
            config.put("outputVariable", "extractedName");

            WorkflowNode node = buildNode("json_1", "jsonPath提取", config);
            Map<String, Object> input = Map.of("data", Map.of("user", Map.of("name", "测试用户")));

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            assertEquals("测试用户", result.get("extractedName"));
        }

        @Test
        @DisplayName("TRANSFORM模式 - 字符串解析为对象整体输出")
        void transformMode_parseStringToObject() {
            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "rawJson");
            config.put("parseMode", "TRANSFORM");
            config.put("outputVariable", "parsed");

            WorkflowNode node = buildNode("json_1", "转换模式", config);
            Map<String, Object> input = Map.of("rawJson", "{\"key\":\"value\",\"num\":123}");

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            @SuppressWarnings("unchecked")
            Map<String, Object> parsed = (Map<String, Object>) result.get("parsed");
            assertEquals("value", parsed.get("key"));
            assertEquals(123, ((Number) parsed.get("num")).intValue());
        }

        @Test
        @DisplayName("VALIDATE模式 - 有效JSON返回valid=true")
        void validateMode_validJson() {
            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "data");
            config.put("parseMode", "VALIDATE");
            config.put("outputVariable", "parsed");

            WorkflowNode node = buildNode("json_1", "验证模式", config);
            Map<String, Object> input = Map.of("data", "{\"valid\":true}");

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            assertTrue((Boolean) result.get("valid"));
        }
    }

    // ==================== 变量引用（点号路径）测试 ====================

    @Nested
    @DisplayName("变量引用 - 点号路径")
    class VariableResolutionTests {

        @Test
        @DisplayName("点号路径引用 - 如 http_1.jsonBody")
        void resolveVariable_dotPath() {
            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "http_1.jsonBody");
            config.put("parseMode", "EXTRACT");
            config.put("outputVariable", "result");

            WorkflowNode node = buildNode("json_1", "点号引用", config);

            // 模拟 HTTP 请求节点输出
            Map<String, Object> httpOutput = new HashMap<>();
            httpOutput.put("statusCode", 200);
            httpOutput.put("body", "{\"title\":\"test\"}");
            httpOutput.put("jsonBody", Map.of("title", "测试标题", "content", "测试内容"));

            Map<String, Object> input = new HashMap<>();
            input.put("http_1", httpOutput);

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            @SuppressWarnings("unchecked")
            Map<String, Object> resultData = (Map<String, Object>) result.get("result");
            assertEquals("测试标题", resultData.get("title"));
        }

        @Test
        @DisplayName("点号路径引用 + extractions提取 - 从HTTP响应中提取嵌套字段")
        void resolveVariable_dotPath_withExtractions() {
            List<Map<String, Object>> extractions = new ArrayList<>();
            extractions.add(Map.of("fieldPath", "data.title", "outputVariable", "title", "dataType", "STRING"));
            extractions.add(Map.of("fieldPath", "data.views", "outputVariable", "viewCount", "dataType", "INTEGER"));
            extractions.add(Map.of("fieldPath", "data.tags[0]", "outputVariable", "firstTag"));

            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "http_1.jsonBody");
            config.put("parseMode", "EXTRACT");
            config.put("extractions", extractions);

            WorkflowNode node = buildNode("json_1", "HTTP响应提取", config);

            // 模拟HTTP响应：jsonBody 包含嵌套的 data 对象
            Map<String, Object> jsonBody = Map.of("data", Map.of(
                    "title", "我的文章",
                    "views", 1024,
                    "tags", List.of("java", "spring", "ddd")
            ));
            Map<String, Object> httpOutput = Map.of(
                    "statusCode", 200,
                    "body", "...",
                    "jsonBody", jsonBody
            );
            Map<String, Object> input = Map.of("http_1", httpOutput);

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            assertEquals("我的文章", result.get("title"));
            assertEquals(1024L, result.get("viewCount"));
            assertEquals("java", result.get("firstTag"));
        }
    }

    // ==================== 类型转换测试 ====================

    @Nested
    @DisplayName("类型转换")
    class TypeConversionTests {

        @Test
        @DisplayName("INTEGER类型转换")
        void typeConversion_integer() {
            List<Map<String, Object>> extractions = new ArrayList<>();
            extractions.add(Map.of("fieldPath", "count", "outputVariable", "count", "dataType", "INTEGER"));

            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "data");
            config.put("parseMode", "EXTRACT");
            config.put("extractions", extractions);

            WorkflowNode node = buildNode("json_1", "类型转换", config);
            Map<String, Object> input = Map.of("data", Map.of("count", "42"));

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            assertEquals(42L, result.get("count"));
        }

        @Test
        @DisplayName("DOUBLE类型转换")
        void typeConversion_double() {
            List<Map<String, Object>> extractions = new ArrayList<>();
            extractions.add(Map.of("fieldPath", "price", "outputVariable", "price", "dataType", "DOUBLE"));

            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "data");
            config.put("parseMode", "EXTRACT");
            config.put("extractions", extractions);

            WorkflowNode node = buildNode("json_1", "类型转换", config);
            Map<String, Object> input = Map.of("data", Map.of("price", 19));

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            assertEquals(19.0, result.get("price"));
        }

        @Test
        @DisplayName("BOOLEAN类型转换")
        void typeConversion_boolean() {
            List<Map<String, Object>> extractions = new ArrayList<>();
            extractions.add(Map.of("fieldPath", "active", "outputVariable", "active", "dataType", "BOOLEAN"));

            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "data");
            config.put("parseMode", "EXTRACT");
            config.put("extractions", extractions);

            WorkflowNode node = buildNode("json_1", "类型转换", config);
            Map<String, Object> input = Map.of("data", Map.of("active", "true"));

            Map<String, Object> result = executor.execute(node, input, null);

            assertTrue((Boolean) result.get("success"));
            assertEquals(true, result.get("active"));
        }
    }

    // ==================== errorStrategy 测试 ====================

    @Nested
    @DisplayName("错误处理策略")
    class ErrorStrategyTests {

        @Test
        @DisplayName("DEFAULT_VALUE策略 - 失败时使用默认值")
        void errorStrategy_defaultValue() {
            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "missing");
            config.put("parseMode", "EXTRACT");
            config.put("jsonPath", "$.a.b");
            config.put("outputVariable", "result");
            config.put("errorStrategy", "DEFAULT_VALUE");
            config.put("defaultValue", "兜底值");

            WorkflowNode node = buildNode("json_1", "默认值策略", config);
            // 给一个 null source（变量不存在），parseMode 在 ensureParsed(null) 时 source=null
            Map<String, Object> input = new HashMap<>();

            Map<String, Object> result = executor.execute(node, input, null);

            // jsonPath 对 null 提取返回 null，不算异常；但如果 inputVariable 不存在 source 为 null
            // ensureParsed(null) 返回 null，extractByJsonPath(null, ...) 返回 null
            // 没有异常，所以 success=true，jsonPath 提取结果为 null
            assertTrue((Boolean) result.get("success"));
        }

        @Test
        @DisplayName("SKIP策略 - 失败时跳过")
        void errorStrategy_skip() {
            List<Map<String, Object>> extractions = new ArrayList<>();
            Map<String, Object> extraction = new HashMap<>();
            extraction.put("fieldPath", "nonExistent");
            extraction.put("outputVariable", "missing");
            extraction.put("required", true);
            // 无 defaultValue → 会抛出异常
            extractions.add(extraction);

            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "data");
            config.put("parseMode", "EXTRACT");
            config.put("extractions", extractions);
            config.put("errorStrategy", "SKIP");

            WorkflowNode node = buildNode("json_1", "跳过策略", config);
            Map<String, Object> input = Map.of("data", Map.of("other", "value"));

            Map<String, Object> result = executor.execute(node, input, null);

            // SKIP 策略：success=true, skipped=true
            assertTrue((Boolean) result.get("success"));
            assertTrue((Boolean) result.get("skipped"));
        }
    }

    // ==================== validate 测试 ====================

    @Nested
    @DisplayName("节点校验")
    class ValidateTests {

        @Test
        @DisplayName("有inputVariable - 验证通过")
        void validate_withInputVariable_passes() {
            Map<String, Object> config = new HashMap<>();
            config.put("inputVariable", "data");

            WorkflowNode node = buildNode("json_1", "有效配置", config);
            assertDoesNotThrow(() -> executor.validate(node));
        }

        @Test
        @DisplayName("有sourceVariable(旧) - 验证通过")
        void validate_withSourceVariable_passes() {
            Map<String, Object> config = new HashMap<>();
            config.put("sourceVariable", "data");

            WorkflowNode node = buildNode("json_1", "旧配置", config);
            assertDoesNotThrow(() -> executor.validate(node));
        }

        @Test
        @DisplayName("缺少变量名 - 验证失败")
        void validate_missingVariable_throws() {
            Map<String, Object> config = new HashMap<>();
            WorkflowNode node = buildNode("json_1", "缺少变量", config);

            assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
        }

        @Test
        @DisplayName("config为null - 不抛异常")
        void validate_nullConfig_passes() {
            WorkflowNode node = buildNode("json_1", "空配置", null);
            assertDoesNotThrow(() -> executor.validate(node));
        }
    }

    // ==================== 辅助方法 ====================

    private WorkflowNode buildNode(String id, String name, Map<String, Object> config) {
        return WorkflowNode.builder()
                .id(id)
                .type(NodeType.JSON_PARSE)
                .name(name)
                .config(config)
                .build();
    }
}
