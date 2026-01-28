package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;
import com.novacloudedu.backend.infrastructure.ai.DashScopeEmbeddingService;
import com.novacloudedu.backend.infrastructure.workflow.executor.TextEmbeddingNodeExecutor;
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
 * 文本向量化节点执行器单元测试
 */
@DisplayName("TextEmbeddingNodeExecutor 单元测试")
class TextEmbeddingNodeExecutorTest {

    @Mock
    private DashScopeEmbeddingService embeddingService;

    private TextEmbeddingNodeExecutor executor;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        executor = new TextEmbeddingNodeExecutor(embeddingService);
    }

    @Test
    @DisplayName("获取节点类型应返回TEXT_EMBEDDING")
    void getNodeType_shouldReturnTextEmbedding() {
        assertEquals(NodeType.TEXT_EMBEDDING, executor.getNodeType());
    }

    @Test
    @DisplayName("执行 - 应调用向量化服务并返回向量")
    void execute_shouldCallEmbeddingServiceAndReturnVector() {
        float[] mockVector = new float[]{0.1f, 0.2f, 0.3f};
        ChapterVector mockChapterVector = ChapterVector.of(mockVector, "test-model");
        when(embeddingService.embedText(anyString())).thenReturn(mockChapterVector);

        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");
        config.put("outputVariable", "embedding");

        WorkflowNode node = WorkflowNode.builder()
                .id("embed_1")
                .type(NodeType.TEXT_EMBEDDING)
                .name("文本向量化")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("text", "这是测试文本");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        @SuppressWarnings("unchecked")
        List<Double> embedding = (List<Double>) result.get("embedding");
        assertEquals(3, embedding.size());
        assertEquals(3, result.get("dimension"));
    }

    @Test
    @DisplayName("执行 - 空文本应返回空向量")
    void execute_emptyText_shouldReturnEmptyVector() {
        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");
        config.put("outputVariable", "embedding");

        WorkflowNode node = WorkflowNode.builder()
                .id("embed_1")
                .type(NodeType.TEXT_EMBEDDING)
                .name("文本向量化")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("text", "");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        @SuppressWarnings("unchecked")
        List<?> embedding = (List<?>) result.get("embedding");
        assertTrue(embedding.isEmpty());
    }

    @Test
    @DisplayName("验证 - 缺少textVariable配置应抛出异常")
    void validate_missingTextVariable_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("outputVariable", "embedding");

        WorkflowNode node = WorkflowNode.builder()
                .id("embed_1")
                .type(NodeType.TEXT_EMBEDDING)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 有textVariable配置应通过")
    void validate_withTextVariable_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");

        WorkflowNode node = WorkflowNode.builder()
                .id("embed_1")
                .type(NodeType.TEXT_EMBEDDING)
                .name("有效配置")
                .config(config)
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
