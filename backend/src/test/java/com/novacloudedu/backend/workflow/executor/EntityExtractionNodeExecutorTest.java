package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.ai.DashScopeLlmService;
import com.novacloudedu.backend.infrastructure.workflow.executor.EntityExtractionNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

/**
 * 实体抽取节点执行器单元测试
 */
@DisplayName("EntityExtractionNodeExecutor 单元测试")
class EntityExtractionNodeExecutorTest {

    @Mock
    private DashScopeLlmService llmService;

    private EntityExtractionNodeExecutor executor;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        executor = new EntityExtractionNodeExecutor(llmService);
    }

    @Test
    @DisplayName("获取节点类型应返回ENTITY_EXTRACTION")
    void getNodeType_shouldReturnEntityExtraction() {
        assertEquals(NodeType.ENTITY_EXTRACTION, executor.getNodeType());
    }

    @Test
    @DisplayName("执行 - 应调用LLM并解析实体")
    void execute_shouldCallLlmAndParseEntities() {
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("[{\"type\":\"PERSON\",\"value\":\"张三\",\"start\":0,\"end\":2}]");

        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");
        config.put("entityTypes", List.of(
                Map.of("name", "PERSON", "description", "人名")
        ));
        config.put("outputVariable", "entities");

        WorkflowNode node = WorkflowNode.builder()
                .id("entity_1")
                .type(NodeType.ENTITY_EXTRACTION)
                .name("实体抽取")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("text", "张三今天去北京出差");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals(1, result.get("entityCount"));
    }

    @Test
    @DisplayName("执行 - 空文本应返回空实体列表")
    void execute_emptyText_shouldReturnEmptyEntities() {
        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");
        config.put("entityTypes", List.of(
                Map.of("name", "PERSON", "description", "人名")
        ));
        config.put("outputVariable", "entities");

        WorkflowNode node = WorkflowNode.builder()
                .id("entity_1")
                .type(NodeType.ENTITY_EXTRACTION)
                .name("实体抽取")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("text", "");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        @SuppressWarnings("unchecked")
        List<?> entities = (List<?>) result.get("entities");
        assertTrue(entities.isEmpty());
    }

    @Test
    @DisplayName("执行 - 使用新字段名inputVariable应正常工作")
    void execute_withInputVariable_shouldWork() {
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("[{\"type\":\"PERSON\",\"value\":\"李四\",\"start\":0,\"end\":2}]");

        Map<String, Object> config = new HashMap<>();
        config.put("inputVariable", "userInput");
        config.put("entityTypes", List.of(
                Map.of("name", "PERSON", "description", "人名", "examples", List.of("张三", "李四"))
        ));
        config.put("outputVariable", "extractedEntities");
        config.put("includePosition", true);

        WorkflowNode node = WorkflowNode.builder()
                .id("entity_2")
                .type(NodeType.ENTITY_EXTRACTION)
                .name("实体抽取-新字段")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("userInput", "李四明天去上海开会");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals(1, result.get("entityCount"));
        assertNotNull(result.get("extractedEntities"));
        assertNotNull(result.get("entitiesByType"));
    }

    @Test
    @DisplayName("执行 - 自定义llmPrompt应被使用")
    void execute_withCustomLlmPrompt_shouldWork() {
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("[{\"type\":\"PHONE\",\"value\":\"13800138000\"}]");

        Map<String, Object> config = new HashMap<>();
        config.put("inputVariable", "text");
        config.put("entityTypes", List.of(
                Map.of("name", "PHONE", "description", "电话号码")
        ));
        config.put("llmPrompt", "你是一个电话号码识别专家，请从文本中找出所有电话号码。");
        config.put("includePosition", false);

        WorkflowNode node = WorkflowNode.builder()
                .id("entity_3")
                .type(NodeType.ENTITY_EXTRACTION)
                .name("电话抽取")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("text", "请联系13800138000");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals(1, result.get("entityCount"));
    }

    @Test
    @DisplayName("验证 - 缺少inputVariable和textVariable配置应抛出异常")
    void validate_missingTextVariable_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("entityTypes", List.of(Map.of("name", "PERSON")));

        WorkflowNode node = WorkflowNode.builder()
                .id("entity_1")
                .type(NodeType.ENTITY_EXTRACTION)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 缺少entityTypes配置应抛出异常")
    void validate_missingEntityTypes_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");

        WorkflowNode node = WorkflowNode.builder()
                .id("entity_1")
                .type(NodeType.ENTITY_EXTRACTION)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 使用textVariable的完整配置应通过（向后兼容）")
    void validate_withTextVariable_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");
        config.put("entityTypes", List.of(Map.of("name", "PERSON", "description", "人名")));

        WorkflowNode node = WorkflowNode.builder()
                .id("entity_1")
                .type(NodeType.ENTITY_EXTRACTION)
                .name("有效配置-旧字段")
                .config(config)
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 使用inputVariable的完整配置应通过")
    void validate_withInputVariable_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("inputVariable", "userInput");
        config.put("entityTypes", List.of(Map.of("name", "LOCATION", "description", "地点")));

        WorkflowNode node = WorkflowNode.builder()
                .id("entity_1")
                .type(NodeType.ENTITY_EXTRACTION)
                .name("有效配置-新字段")
                .config(config)
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
