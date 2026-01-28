package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.repository.KnowledgeChunkRepository;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.domain.book.service.VectorEmbeddingService;
import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;
import com.novacloudedu.backend.infrastructure.workflow.executor.KnowledgeRetrievalNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;

/**
 * 知识库检索节点执行器单元测试
 */
@DisplayName("KnowledgeRetrievalNodeExecutor 单元测试")
class KnowledgeRetrievalNodeExecutorTest {

    @Mock
    private VectorEmbeddingService embeddingService;

    @Mock
    private KnowledgeChunkRepository chunkRepository;

    private KnowledgeRetrievalNodeExecutor executor;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        executor = new KnowledgeRetrievalNodeExecutor(embeddingService, chunkRepository);
    }

    @Test
    @DisplayName("获取节点类型应返回KNOWLEDGE_RETRIEVAL")
    void getNodeType_shouldReturnKnowledgeRetrieval() {
        assertEquals(NodeType.KNOWLEDGE_RETRIEVAL, executor.getNodeType());
    }

    @Test
    @DisplayName("执行 - 空查询应返回空结果")
    void execute_emptyQuery_shouldReturnEmptyResult() {
        Map<String, Object> config = new HashMap<>();
        config.put("knowledgeBaseIds", List.of(1L));
        config.put("queryVariable", "query");

        WorkflowNode node = WorkflowNode.builder()
                .id("kb_1")
                .type(NodeType.KNOWLEDGE_RETRIEVAL)
                .name("知识库检索")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("query", "");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals(0, result.get("retrievedCount"));
        assertEquals("", result.get("retrievedContext"));
    }

    @Test
    @DisplayName("执行 - 应调用向量化和检索服务")
    void execute_shouldCallEmbeddingAndRetrievalService() {
        float[] mockVector = new float[]{0.1f, 0.2f, 0.3f};
        ChapterVector mockChapterVector = ChapterVector.of(mockVector, "test-model");
        when(embeddingService.embedText(anyString())).thenReturn(mockChapterVector);
        
        List<KnowledgeChunkRepository.ChunkSearchResult> mockResults = List.of(
                new KnowledgeChunkRepository.ChunkSearchResult(
                        1L, 1L, 1L, "这是相关内容", 0.85, "{}"
                )
        );
        when(chunkRepository.searchSimilarInMultiple(anyList(), any(float[].class), anyInt()))
                .thenReturn(mockResults);

        Map<String, Object> config = new HashMap<>();
        config.put("knowledgeBaseIds", List.of(1L));
        config.put("queryVariable", "query");
        config.put("topK", 5);

        WorkflowNode node = WorkflowNode.builder()
                .id("kb_1")
                .type(NodeType.KNOWLEDGE_RETRIEVAL)
                .name("知识库检索")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("query", "什么是机器学习");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals(1, result.get("retrievedCount"));
        assertTrue(((String) result.get("retrievedContext")).contains("这是相关内容"));
    }

    @Test
    @DisplayName("验证 - 缺少knowledgeBaseIds配置应抛出异常")
    void validate_missingKnowledgeBaseIds_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("queryVariable", "query");

        WorkflowNode node = WorkflowNode.builder()
                .id("kb_1")
                .type(NodeType.KNOWLEDGE_RETRIEVAL)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 缺少config应抛出异常")
    void validate_missingConfig_shouldThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("kb_1")
                .type(NodeType.KNOWLEDGE_RETRIEVAL)
                .name("无效配置")
                .config(null)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 有knowledgeBaseIds配置应通过")
    void validate_withKnowledgeBaseIds_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("knowledgeBaseIds", List.of(1L, 2L));

        WorkflowNode node = WorkflowNode.builder()
                .id("kb_1")
                .type(NodeType.KNOWLEDGE_RETRIEVAL)
                .name("有效配置")
                .config(config)
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
