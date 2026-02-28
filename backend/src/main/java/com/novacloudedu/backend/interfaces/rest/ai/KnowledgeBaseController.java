package com.novacloudedu.backend.interfaces.rest.ai;

import com.novacloudedu.backend.application.service.KnowledgeBaseApplicationService;
import com.novacloudedu.backend.application.ai.command.CreateKnowledgeBaseCommand;
import com.novacloudedu.backend.application.ai.command.UpdateKnowledgeBaseCommand;
import com.novacloudedu.backend.application.ai.dto.KnowledgeBaseVO;
import com.novacloudedu.backend.application.ai.dto.KnowledgeChunkVO;
import com.novacloudedu.backend.application.ai.dto.KnowledgeDocumentVO;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.knowledge.service.KnowledgeSearchService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 知识库管理控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/ai/knowledge-bases")
@RequiredArgsConstructor
@Tag(name = "知识库管理", description = "知识库CRUD接口")
public class KnowledgeBaseController {

    private final KnowledgeBaseApplicationService knowledgeBaseService;
    private final KnowledgeSearchService knowledgeSearchService;

    @PostMapping
    @Operation(summary = "创建知识库", operationId = "kbCreate")
    public BaseResponse<KnowledgeBaseVO> create(
            @RequestParam Long userId,
            @Valid @RequestBody CreateKnowledgeBaseCommand dto) {
        try {
            KnowledgeBaseVO vo = knowledgeBaseService.create(userId, dto);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("创建知识库失败", e);
            return (BaseResponse<KnowledgeBaseVO>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新知识库", operationId = "kbUpdate")
    public BaseResponse<KnowledgeBaseVO> update(
            @PathVariable Long id,
            @Valid @RequestBody UpdateKnowledgeBaseCommand dto) {
        try {
            KnowledgeBaseVO vo = knowledgeBaseService.update(id, dto);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("更新知识库失败", e);
            return (BaseResponse<KnowledgeBaseVO>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取知识库详情", operationId = "kbGetById")
    public BaseResponse<KnowledgeBaseVO> getById(@PathVariable Long id) {
        try {
            KnowledgeBaseVO vo = knowledgeBaseService.getById(id);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("获取知识库失败", e);
            return (BaseResponse<KnowledgeBaseVO>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping
    @Operation(summary = "获取用户的知识库列表", operationId = "kbListByCreator")
    public BaseResponse<List<KnowledgeBaseVO>> listByCreator(
            @RequestParam Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        try {
            List<KnowledgeBaseVO> list = knowledgeBaseService.listByCreator(userId, page, size);
            return ResultUtils.success(list);
        } catch (Exception e) {
            log.error("获取知识库列表失败", e);
            return (BaseResponse<List<KnowledgeBaseVO>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/search")
    @Operation(summary = "搜索知识库", operationId = "kbSearch")
    public BaseResponse<List<KnowledgeBaseVO>> search(
            @RequestParam String keyword,
            @RequestParam Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        try {
            List<KnowledgeBaseVO> list = knowledgeBaseService.search(keyword, userId, page, size);
            return ResultUtils.success(list);
        } catch (Exception e) {
            log.error("搜索知识库失败", e);
            return (BaseResponse<List<KnowledgeBaseVO>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除知识库", operationId = "kbDelete")
    public BaseResponse<Void> delete(@PathVariable Long id) {
        try {
            knowledgeBaseService.delete(id);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("删除知识库失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/documents")
    @Operation(summary = "添加文档", operationId = "kbAddDocument")
    public BaseResponse<KnowledgeDocumentVO> addDocument(
            @PathVariable Long id,
            @RequestParam Long userId,
            @RequestBody Map<String, Object> request) {
        try {
            String name = (String) request.get("name");
            String fileType = (String) request.get("fileType");
            String fileUrl = (String) request.get("fileUrl");
            Long fileSize = request.get("fileSize") != null ? 
                    ((Number) request.get("fileSize")).longValue() : 0L;
            String content = (String) request.get("content");

            KnowledgeDocumentVO vo = knowledgeBaseService.addDocument(
                    id, userId, name, fileType, fileUrl, fileSize, content);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("添加文档失败", e);
            return (BaseResponse<KnowledgeDocumentVO>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/{id}/documents")
    @Operation(summary = "获取文档列表", operationId = "kbListDocuments")
    public BaseResponse<List<KnowledgeDocumentVO>> listDocuments(
            @PathVariable Long id,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        try {
            List<KnowledgeDocumentVO> list = knowledgeBaseService.listDocuments(id, page, size);
            return ResultUtils.success(list);
        } catch (Exception e) {
            log.error("获取文档列表失败", e);
            return (BaseResponse<List<KnowledgeDocumentVO>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/{id}/document-stats")
    @Operation(summary = "获取文档状态统计", operationId = "kbDocumentStats",
            description = "返回知识库中各状态文档的数量统计（全量，不受分页影响）")
    public BaseResponse<java.util.Map<String, Long>> getDocumentStats(@PathVariable Long id) {
        try {
            java.util.Map<String, Long> stats = knowledgeBaseService.getDocumentStatusCounts(id);
            return ResultUtils.success(stats);
        } catch (Exception e) {
            log.error("获取文档状态统计失败", e);
            return (BaseResponse<java.util.Map<String, Long>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @DeleteMapping("/{id}/documents/{docId}")
    @Operation(summary = "删除文档", operationId = "kbDeleteDocument")
    public BaseResponse<Void> deleteDocument(
            @PathVariable Long id,
            @PathVariable Long docId) {
        try {
            knowledgeBaseService.deleteDocument(docId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("删除文档失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/documents/{docId}/embed")
    @Operation(summary = "触发文档向量化", operationId = "kbProcessDocument")
    public BaseResponse<Void> processDocument(
            @PathVariable Long id,
            @PathVariable Long docId) {
        try {
            knowledgeBaseService.processDocument(docId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("文档向量化失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/documents/batch-embed")
    @Operation(summary = "批量文档向量化", operationId = "kbBatchProcessDocuments")
    public BaseResponse<KnowledgeBaseApplicationService.BatchProcessResult> batchProcessDocuments(
            @PathVariable Long id,
            @RequestBody List<Long> documentIds) {
        try {
            KnowledgeBaseApplicationService.BatchProcessResult result = 
                    knowledgeBaseService.batchProcessDocuments(documentIds);
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("批量文档向量化失败", e);
            return (BaseResponse<KnowledgeBaseApplicationService.BatchProcessResult>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/embed-all")
    @Operation(summary = "向量化知识库所有待处理文档", operationId = "kbBatchProcessByKnowledgeBase")
    public BaseResponse<KnowledgeBaseApplicationService.BatchProcessResult> batchProcessByKnowledgeBase(
            @PathVariable Long id) {
        try {
            KnowledgeBaseApplicationService.BatchProcessResult result = 
                    knowledgeBaseService.batchProcessByKnowledgeBase(id);
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("批量向量化知识库文档失败", e);
            return (BaseResponse<KnowledgeBaseApplicationService.BatchProcessResult>) 
                    (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/documents/batch-embed-async")
    @Operation(summary = "异步批量文档向量化", operationId = "kbBatchProcessDocumentsAsync")
    public BaseResponse<String> batchProcessDocumentsAsync(
            @PathVariable Long id,
            @RequestBody List<Long> documentIds) {
        try {
            knowledgeBaseService.batchProcessDocumentsAsync(documentIds);
            return ResultUtils.success("已提交异步处理，共" + documentIds.size() + "个文档");
        } catch (Exception e) {
            log.error("提交异步批量向量化失败", e);
            return (BaseResponse<String>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/{id}/documents/{docId}/chunks")
    @Operation(summary = "获取文档分块列表", operationId = "kbListChunks")
    public BaseResponse<Map<String, Object>> listChunks(
            @PathVariable Long id,
            @PathVariable Long docId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        try {
            List<KnowledgeChunkVO> chunks = knowledgeBaseService.listChunks(docId, page, size);
            long total = knowledgeBaseService.countChunks(docId);
            Map<String, Object> result = Map.of(
                    "chunks", chunks,
                    "total", total,
                    "page", page,
                    "size", size
            );
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("获取文档分块列表失败", e);
            return (BaseResponse<Map<String, Object>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PutMapping("/{id}/documents/{docId}")
    @Operation(summary = "更新文档元信息", operationId = "kbUpdateDocument")
    public BaseResponse<KnowledgeDocumentVO> updateDocument(
            @PathVariable Long id,
            @PathVariable Long docId,
            @RequestBody Map<String, String> request) {
        try {
            String name = request.get("name");
            String fileType = request.get("fileType");
            KnowledgeDocumentVO vo = knowledgeBaseService.updateDocument(docId, name, fileType);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("更新文档元信息失败", e);
            return (BaseResponse<KnowledgeDocumentVO>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/chunk-preview")
    @Operation(summary = "预览文档切分效果", operationId = "kbPreviewChunking",
            description = "输入文本内容和切分参数，返回切分预览结果（不执行向量化）")
    public BaseResponse<KnowledgeBaseApplicationService.ChunkPreviewResult> previewChunking(
            @RequestBody Map<String, Object> request) {
        try {
            String content = (String) request.get("content");
            String strategy = (String) request.get("strategy");
            Integer chunkSize = request.get("chunkSize") != null ? ((Number) request.get("chunkSize")).intValue() : null;
            Integer chunkOverlap = request.get("chunkOverlap") != null ? ((Number) request.get("chunkOverlap")).intValue() : null;
            Boolean parentChildMode = (Boolean) request.get("parentChildMode");
            Integer parentChunkSize = request.get("parentChunkSize") != null ? ((Number) request.get("parentChunkSize")).intValue() : null;
            Boolean preserveMetadata = (Boolean) request.get("preserveMetadata");
            Double semanticThreshold = request.get("semanticThreshold") != null ? ((Number) request.get("semanticThreshold")).doubleValue() : null;

            KnowledgeBaseApplicationService.ChunkPreviewResult result = knowledgeBaseService.previewChunking(
                    content, strategy, chunkSize, chunkOverlap, parentChildMode, parentChunkSize, preserveMetadata, semanticThreshold);
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("预览切分失败", e);
            return (BaseResponse<KnowledgeBaseApplicationService.ChunkPreviewResult>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/documents/{docId}/chunk-preview")
    @Operation(summary = "预览文档切分效果（基于已有文档）", operationId = "kbPreviewDocumentChunking",
            description = "基于已上传的文档，预览不同切分策略的效果")
    public BaseResponse<KnowledgeBaseApplicationService.ChunkPreviewResult> previewDocumentChunking(
            @PathVariable Long id,
            @PathVariable Long docId,
            @RequestBody Map<String, Object> request) {
        try {
            String strategy = (String) request.get("strategy");
            Integer chunkSize = request.get("chunkSize") != null ? ((Number) request.get("chunkSize")).intValue() : null;
            Integer chunkOverlap = request.get("chunkOverlap") != null ? ((Number) request.get("chunkOverlap")).intValue() : null;
            Boolean parentChildMode = (Boolean) request.get("parentChildMode");
            Integer parentChunkSize = request.get("parentChunkSize") != null ? ((Number) request.get("parentChunkSize")).intValue() : null;
            Boolean preserveMetadata = (Boolean) request.get("preserveMetadata");
            Double semanticThreshold = request.get("semanticThreshold") != null ? ((Number) request.get("semanticThreshold")).doubleValue() : null;

            KnowledgeBaseApplicationService.ChunkPreviewResult result = knowledgeBaseService.previewDocumentChunking(
                    docId, strategy, chunkSize, chunkOverlap, parentChildMode, parentChunkSize, preserveMetadata, semanticThreshold);
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("预览文档切分失败: docId={}", docId, e);
            return (BaseResponse<KnowledgeBaseApplicationService.ChunkPreviewResult>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/chunk-strategies")
    @Operation(summary = "获取可用的切分策略列表", operationId = "kbListChunkStrategies")
    public BaseResponse<List<Map<String, String>>> listChunkStrategies() {
        List<Map<String, String>> strategies = new java.util.ArrayList<>();
        for (com.novacloudedu.backend.domain.ai.valueobject.ChunkStrategy s : 
                com.novacloudedu.backend.domain.ai.valueobject.ChunkStrategy.values()) {
            Map<String, String> item = new java.util.LinkedHashMap<>();
            item.put("value", s.name());
            item.put("label", s.getDescription());
            strategies.add(item);
        }
        return ResultUtils.success(strategies);
    }

    @GetMapping("/retrieval-modes")
    @Operation(summary = "获取检索模式列表", operationId = "kbListRetrievalModes",
            description = "返回可用的RAG检索模式列表")
    public BaseResponse<List<Map<String, String>>> listRetrievalModes() {
        List<Map<String, String>> modes = new java.util.ArrayList<>();
        for (com.novacloudedu.backend.domain.ai.valueobject.RetrievalMode m :
                com.novacloudedu.backend.domain.ai.valueobject.RetrievalMode.values()) {
            Map<String, String> item = new java.util.LinkedHashMap<>();
            item.put("value", m.name());
            item.put("label", m.getLabel());
            modes.add(item);
        }
        return ResultUtils.success(modes);
    }

    @GetMapping("/embedding-models")
    @Operation(summary = "获取可用的Embedding模型列表", operationId = "kbListEmbeddingModels",
            description = "返回DashScope平台可用的文本向量化模型及其支持的维度列表")
    public BaseResponse<List<Map<String, Object>>> listEmbeddingModels() {
        List<Map<String, Object>> models = new java.util.ArrayList<>();

        // text-embedding-v4 (Qwen3-Embedding)
        Map<String, Object> v4 = new java.util.LinkedHashMap<>();
        v4.put("model", "text-embedding-v4");
        v4.put("label", "text-embedding-v4 (Qwen3-Embedding)");
        v4.put("dimensions", List.of(2048, 1536, 1024, 768, 512, 256, 128, 64));
        v4.put("defaultDimension", 1024);
        v4.put("maxTokens", 8192);
        v4.put("recommended", true);
        models.add(v4);

        // text-embedding-v3
        Map<String, Object> v3 = new java.util.LinkedHashMap<>();
        v3.put("model", "text-embedding-v3");
        v3.put("label", "text-embedding-v3");
        v3.put("dimensions", List.of(1024, 768, 512, 256, 128, 64));
        v3.put("defaultDimension", 1024);
        v3.put("maxTokens", 8192);
        v3.put("recommended", false);
        models.add(v3);

        // text-embedding-v2
        Map<String, Object> v2 = new java.util.LinkedHashMap<>();
        v2.put("model", "text-embedding-v2");
        v2.put("label", "text-embedding-v2");
        v2.put("dimensions", List.of(1536));
        v2.put("defaultDimension", 1536);
        v2.put("maxTokens", 2048);
        v2.put("recommended", false);
        models.add(v2);

        // text-embedding-v1
        Map<String, Object> v1 = new java.util.LinkedHashMap<>();
        v1.put("model", "text-embedding-v1");
        v1.put("label", "text-embedding-v1 (Legacy)");
        v1.put("dimensions", List.of(1536));
        v1.put("defaultDimension", 1536);
        v1.put("maxTokens", 2048);
        v1.put("recommended", false);
        models.add(v1);

        return ResultUtils.success(models);
    }

    @PostMapping("/{id}/recall-test")
    @Operation(summary = "知识库召回测试", operationId = "kbRecallTest",
            description = "输入查询文本，返回多路召回+RRF融合+Rerank后的召回结果，用于调试知识库检索效果。" +
                    "所有RAG参数可选，缺省时使用知识库默认配置。")
    public BaseResponse<Map<String, Object>> recallTest(
            @PathVariable Long id,
            @RequestBody Map<String, Object> request) {
        try {
            String query = (String) request.get("query");
            if (query == null || query.trim().isEmpty()) {
                return (BaseResponse<Map<String, Object>>) (BaseResponse<?>) ResultUtils.error(40000, "查询文本不能为空");
            }

            // 从知识库获取默认RAG配置作为 fallback
            com.novacloudedu.backend.application.ai.dto.KnowledgeBaseVO kbVO = knowledgeBaseService.getById(id);

            // 请求参数覆盖知识库默认配置
            String mode = request.get("retrievalMode") != null
                    ? (String) request.get("retrievalMode")
                    : (kbVO.getRetrievalMode() != null ? kbVO.getRetrievalMode() : "HYBRID_RERANK");

            boolean queryRewrite = request.get("enableQueryRewrite") != null
                    ? (Boolean) request.get("enableQueryRewrite")
                    : (kbVO.getEnableQueryRewrite() != null && kbVO.getEnableQueryRewrite());

            boolean dynamicTopK = request.get("useDynamicTopK") != null
                    ? (Boolean) request.get("useDynamicTopK")
                    : (kbVO.getUseDynamicTopK() != null && kbVO.getUseDynamicTopK());

            int defaultTopK = request.get("defaultTopK") != null
                    ? ((Number) request.get("defaultTopK")).intValue()
                    : (kbVO.getDefaultTopK() != null ? kbVO.getDefaultTopK() : 5);

            // topK: 如果动态 topK 关闭，使用 defaultTopK；否则由搜索服务动态计算
            Integer topK = request.get("topK") != null
                    ? ((Number) request.get("topK")).intValue()
                    : (!dynamicTopK ? defaultTopK : 5);

            Double threshold = request.get("similarityThreshold") != null
                    ? ((Number) request.get("similarityThreshold")).doubleValue() : 0.3;

            String queryRewriteModelId = request.get("queryRewriteModelId") != null
                    ? (String) request.get("queryRewriteModelId")
                    : (kbVO.getQueryRewriteModelId() != null ? kbVO.getQueryRewriteModelId() : "dashscope/qwen-turbo");

            String rerankModel = request.get("rerankModel") != null
                    ? (String) request.get("rerankModel")
                    : (kbVO.getRerankModel() != null ? kbVO.getRerankModel() : "qwen3-rerank");

            KnowledgeSearchService.SearchRequest searchRequest = KnowledgeSearchService.SearchRequest.builder()
                    .knowledgeBaseIds(List.of(id))
                    .query(query.trim())
                    .topK(topK)
                    .similarityThreshold(threshold)
                    .retrievalMode(mode)
                    .enableQueryRewrite(queryRewrite)
                    .useDynamicTopK(dynamicTopK)
                    .queryRewriteModelId(queryRewriteModelId)
                    .rerankModel(rerankModel)
                    .build();

            KnowledgeSearchService.SearchResult result = knowledgeSearchService.search(searchRequest);

            List<Map<String, Object>> chunks = new java.util.ArrayList<>();
            int idx = 1;
            for (KnowledgeSearchService.DocumentChunk doc : result.getDocuments()) {
                Map<String, Object> chunk = new java.util.LinkedHashMap<>();
                chunk.put("index", idx++);
                chunk.put("score", doc.getScore());
                chunk.put("documentId", doc.getDocumentId());
                chunk.put("documentName", doc.getDocumentName());
                chunk.put("content", doc.getContent());
                chunk.put("chunkIndex", doc.getChunkIndex());
                chunk.put("metadata", doc.getMetadata());
                chunks.add(chunk);
            }

            Map<String, Object> response = new java.util.LinkedHashMap<>();
            response.put("query", query);
            response.put("retrievalMode", mode);
            response.put("enableQueryRewrite", queryRewrite);
            response.put("useDynamicTopK", dynamicTopK);
            response.put("topK", topK);
            response.put("defaultTopK", defaultTopK);
            response.put("similarityThreshold", threshold);
            response.put("totalResults", result.getTotalCount());
            response.put("searchTimeMs", result.getSearchTimeMs());
            response.put("chunks", chunks);

            return ResultUtils.success(response);
        } catch (Exception e) {
            log.error("知识库召回测试失败: kbId={}", id, e);
            return (BaseResponse<Map<String, Object>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }
}
