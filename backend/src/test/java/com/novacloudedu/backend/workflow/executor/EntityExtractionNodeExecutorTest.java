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
    @DisplayName("验证 - 缺少textVariable配置应抛出异常")
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
    @DisplayName("验证 - 完整配置应通过")
    void validate_withCompleteConfig_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");
        config.put("entityTypes", List.of(Map.of("name", "PERSON", "description", "人名")));

        WorkflowNode node = WorkflowNode.builder()
                .id("entity_1")
                .type(NodeType.ENTITY_EXTRACTION)
                .name("有效配置")
                .config(config)
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
