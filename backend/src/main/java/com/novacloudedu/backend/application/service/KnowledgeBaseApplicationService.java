package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.ai.command.CreateKnowledgeBaseCommand;
import com.novacloudedu.backend.application.ai.command.UpdateKnowledgeBaseCommand;
import com.novacloudedu.backend.application.ai.dto.KnowledgeBaseVO;
import com.novacloudedu.backend.application.ai.dto.KnowledgeChunkVO;
import com.novacloudedu.backend.application.ai.dto.KnowledgeDocumentVO;
import com.novacloudedu.backend.domain.ai.entity.KnowledgeBase;
import com.novacloudedu.backend.domain.ai.entity.KnowledgeDocument;
import com.novacloudedu.backend.domain.ai.repository.KnowledgeBaseRepository;
import com.novacloudedu.backend.domain.ai.repository.KnowledgeChunkRepository;
import com.novacloudedu.backend.domain.ai.repository.KnowledgeDocumentRepository;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.book.service.VectorEmbeddingService;
import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.ai.DocumentContentExtractor;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * 知识库应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class KnowledgeBaseApplicationService {

    private final KnowledgeBaseRepository knowledgeBaseRepository;
    private final KnowledgeDocumentRepository documentRepository;
    private final KnowledgeChunkRepository chunkRepository;
    private final VectorEmbeddingService embeddingService;
    private final DocumentContentExtractor contentExtractor;
    private final DocumentChunkingService chunkingService;
    private final TransactionTemplate transactionTemplate;

    private ExecutorService documentProcessExecutor;

    @PostConstruct
    public void init() {
        // 创建文档处理线程池：核心线程2，最大线程5，队列容量100
        documentProcessExecutor = new ThreadPoolExecutor(
                2,
                5,
                60L,
                TimeUnit.SECONDS,
                new LinkedBlockingQueue<>(100),
                new ThreadPoolExecutor.CallerRunsPolicy()
        );
        log.info("文档向量化线程池初始化完成");
    }

    @PreDestroy
    public void destroy() {
        if (documentProcessExecutor != null) {
            documentProcessExecutor.shutdown();
            try {
                if (!documentProcessExecutor.awaitTermination(60, TimeUnit.SECONDS)) {
                    documentProcessExecutor.shutdownNow();
                }
            } catch (InterruptedException e) {
                documentProcessExecutor.shutdownNow();
                Thread.currentThread().interrupt();
            }
            log.info("文档向量化线程池已关闭");
        }
    }

    /**
     * 创建知识库
     */
    @Transactional
    public KnowledgeBaseVO create(Long userId, CreateKnowledgeBaseCommand dto) {
        log.info("创建知识库: userId={}, name={}", userId, dto.getName());

        KnowledgeBase kb = KnowledgeBase.create(
                dto.getName(),
                dto.getDescription(),
                UserId.of(userId)
        );

        if (dto.getEmbeddingModel() != null || dto.getEmbeddingDimension() != null
                || dto.getChunkSize() != null || dto.getChunkOverlap() != null) {
            kb.updateEmbeddingConfig(dto.getEmbeddingModel(), dto.getEmbeddingDimension(),
                    dto.getChunkSize(), dto.getChunkOverlap());
        }

        // 切分配置
        ChunkStrategy strategy = parseChunkStrategy(dto.getChunkStrategy());
        if (strategy != null || dto.getParentChildMode() != null || dto.getParentChunkSize() != null
                || dto.getPreserveMetadata() != null || dto.getSemanticThreshold() != null) {
            kb.updateChunkConfig(strategy, dto.getParentChildMode(), dto.getParentChunkSize(),
                    dto.getPreserveMetadata(), dto.getSemanticThreshold());
        }

        // RAG 检索配置
        if (dto.getRetrievalMode() != null || dto.getEnableQueryRewrite() != null || dto.getUseDynamicTopK() != null) {
            kb.updateRetrievalConfig(dto.getRetrievalMode(), dto.getEnableQueryRewrite(), dto.getUseDynamicTopK(), dto.getDefaultTopK(), dto.getQueryRewriteModelId(), dto.getRerankModel());
        }

        KnowledgeBase saved = knowledgeBaseRepository.save(kb);
        return toVO(saved);
    }

    /**
     * 更新知识库
     */
    @Transactional
    public KnowledgeBaseVO update(Long id, UpdateKnowledgeBaseCommand dto) {
        log.info("更新知识库: id={}", id);

        KnowledgeBase kb = knowledgeBaseRepository.findById(KnowledgeBaseId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("知识库不存在: " + id));

        if (dto.getName() != null || dto.getDescription() != null) {
            kb.updateBasicInfo(dto.getName(), dto.getDescription());
        }

        if (dto.getEmbeddingModel() != null || dto.getEmbeddingDimension() != null
                || dto.getChunkSize() != null || dto.getChunkOverlap() != null) {
            kb.updateEmbeddingConfig(dto.getEmbeddingModel(), dto.getEmbeddingDimension(),
                    dto.getChunkSize(), dto.getChunkOverlap());
        }

        ChunkStrategy strategy = parseChunkStrategy(dto.getChunkStrategy());
        if (strategy != null || dto.getParentChildMode() != null || dto.getParentChunkSize() != null
                || dto.getPreserveMetadata() != null || dto.getSemanticThreshold() != null) {
            kb.updateChunkConfig(strategy, dto.getParentChildMode(), dto.getParentChunkSize(),
                    dto.getPreserveMetadata(), dto.getSemanticThreshold());
        }

        // RAG 检索配置
        if (dto.getRetrievalMode() != null || dto.getEnableQueryRewrite() != null || dto.getUseDynamicTopK() != null) {
            kb.updateRetrievalConfig(dto.getRetrievalMode(), dto.getEnableQueryRewrite(), dto.getUseDynamicTopK(), dto.getDefaultTopK(), dto.getQueryRewriteModelId(), dto.getRerankModel());
        }

        KnowledgeBase saved = knowledgeBaseRepository.save(kb);
        return toVO(saved);
    }

    /**
     * 获取知识库详情
     */
    public KnowledgeBaseVO getById(Long id) {
        KnowledgeBase kb = knowledgeBaseRepository.findById(KnowledgeBaseId.of(id))
                .orElseThrow(() -> new IllegalArgumentException("知识库不存在: " + id));
        return toVO(kb);
    }

    /**
     * 获取用户的知识库列表
     */
    public List<KnowledgeBaseVO> listByCreator(Long userId, int page, int size) {
        List<KnowledgeBase> kbs = knowledgeBaseRepository.findByCreatorId(UserId.of(userId), page, size);
        return kbs.stream().map(this::toVO).collect(Collectors.toList());
    }

    /**
     * 搜索知识库
     */
    public List<KnowledgeBaseVO> search(String keyword, Long userId, int page, int size) {
        List<KnowledgeBase> kbs = knowledgeBaseRepository.search(keyword, UserId.of(userId), page, size);
        return kbs.stream().map(this::toVO).collect(Collectors.toList());
    }

    /**
     * 删除知识库
     */
    @Transactional
    public void delete(Long id) {
        log.info("删除知识库: id={}", id);
        KnowledgeBaseId kbId = KnowledgeBaseId.of(id);
        
        // 删除所有分块
        chunkRepository.deleteByKnowledgeBaseId(kbId);
        // 删除所有文档
        documentRepository.deleteByKnowledgeBaseId(kbId);
        // 删除知识库
        knowledgeBaseRepository.delete(kbId);
    }

    /**
     * 添加文档
     */
    @Transactional
    public KnowledgeDocumentVO addDocument(Long knowledgeBaseId, Long userId, 
                                           String name, String fileType, 
                                           String fileUrl, Long fileSize, String content) {
        log.info("添加文档: knowledgeBaseId={}, name={}", knowledgeBaseId, name);

        KnowledgeBase kb = knowledgeBaseRepository.findById(KnowledgeBaseId.of(knowledgeBaseId))
                .orElseThrow(() -> new IllegalArgumentException("知识库不存在: " + knowledgeBaseId));

        DocumentType docType = DocumentType.valueOf(fileType.toUpperCase());
        
        KnowledgeDocument doc = KnowledgeDocument.create(
                KnowledgeBaseId.of(knowledgeBaseId),
                name,
                docType,
                fileUrl,
                fileSize,
                UserId.of(userId)
        );

        // 设置内容和哈希
        if (content != null && !content.isEmpty()) {
            String hash = computeHash(content);
            doc.setContent(content, hash);
        }

        KnowledgeDocument saved = documentRepository.save(doc);

        // 更新知识库文档数量
        kb.incrementDocumentCount();
        knowledgeBaseRepository.save(kb);

        return toDocumentVO(saved);
    }

    /**
     * 获取文档列表
     */
    public List<KnowledgeDocumentVO> listDocuments(Long knowledgeBaseId, int page, int size) {
        List<KnowledgeDocument> docs = documentRepository.findByKnowledgeBaseId(
                KnowledgeBaseId.of(knowledgeBaseId), page, size);
        return docs.stream().map(this::toDocumentVO).collect(Collectors.toList());
    }

    /**
     * 获取知识库文档状态统计（全量，不分页）
     */
    public java.util.Map<String, Long> getDocumentStatusCounts(Long knowledgeBaseId) {
        return documentRepository.countByKnowledgeBaseIdGroupByStatus(KnowledgeBaseId.of(knowledgeBaseId));
    }

    /**
     * 删除文档
     */
    @Transactional
    public void deleteDocument(Long documentId) {
        log.info("删除文档: documentId={}", documentId);

        KnowledgeDocument doc = documentRepository.findById(KnowledgeDocumentId.of(documentId))
                .orElseThrow(() -> new IllegalArgumentException("文档不存在: " + documentId));

        // 删除分块
        chunkRepository.deleteByDocumentId(KnowledgeDocumentId.of(documentId));

        // 删除文档
        documentRepository.delete(KnowledgeDocumentId.of(documentId));

        // 更新知识库文档数量
        KnowledgeBase kb = knowledgeBaseRepository.findById(doc.getKnowledgeBaseId())
                .orElse(null);
        if (kb != null) {
            kb.decrementDocumentCount();
            knowledgeBaseRepository.save(kb);
        }
    }

    /**
     * 处理文档向量化（单文档，带事务）
     */
    @Transactional
    public void processDocument(Long documentId) {
        log.info("处理文档向量化: documentId={}", documentId);

        KnowledgeDocument doc = documentRepository.findById(KnowledgeDocumentId.of(documentId))
                .orElseThrow(() -> new IllegalArgumentException("文档不存在: " + documentId));

        KnowledgeBase kb = knowledgeBaseRepository.findById(doc.getKnowledgeBaseId())
                .orElseThrow(() -> new IllegalArgumentException("知识库不存在"));

        try {
            doc.startProcessing();
            documentRepository.save(doc);
            vectorizeDocumentCore(doc, kb);
        } catch (Exception e) {
            log.error("文档向量化失败: documentId={}", documentId, e);
            doc.failProcessing(e.getMessage());
            documentRepository.save(doc);
            throw new RuntimeException("文档向量化失败: " + e.getMessage(), e);
        }
    }

    /**
     * 批量处理文档向量化（每个文档独立事务，互不影响）
     */
    public BatchProcessResult batchProcessDocuments(List<Long> documentIds) {
        log.info("批量处理文档向量化: count={}", documentIds.size());

        BatchProcessResult result = new BatchProcessResult();
        result.setTotal(documentIds.size());

        for (Long documentId : documentIds) {
            try {
                transactionTemplate.executeWithoutResult(status -> {
                    processDocumentInTransaction(documentId);
                });
                result.addSuccess(documentId);
            } catch (Exception e) {
                log.error("批量向量化失败: documentId={}", documentId, e);
                result.addFailed(documentId, e.getMessage());
            }
        }

        log.info("批量向量化完成: total={}, success={}, failed={}", 
                result.getTotal(), result.getSuccessCount(), result.getFailedCount());
        return result;
    }

    /**
     * 批量处理知识库下所有待处理文档
     */
    public BatchProcessResult batchProcessByKnowledgeBase(Long knowledgeBaseId) {
        log.info("批量处理知识库文档: knowledgeBaseId={}", knowledgeBaseId);

        List<KnowledgeDocument> pendingDocs = documentRepository.findPendingByKnowledgeBaseId(
                KnowledgeBaseId.of(knowledgeBaseId));

        List<Long> documentIds = pendingDocs.stream()
                .map(doc -> doc.getId().value())
                .collect(Collectors.toList());

        return batchProcessDocuments(documentIds);
    }

    /**
     * 异步批量处理文档向量化
     */
    public void batchProcessDocumentsAsync(List<Long> documentIds) {
        log.info("异步批量处理文档向量化: count={}", documentIds.size());

        for (Long documentId : documentIds) {
            try {
                KnowledgeDocument doc = documentRepository.findById(KnowledgeDocumentId.of(documentId))
                        .orElse(null);
                if (doc != null && doc.getStatus() == DocumentStatus.PENDING) {
                    doc.startProcessing();
                    documentRepository.save(doc);
                }
            } catch (Exception e) {
                log.error("标记文档处理中失败: documentId={}", documentId, e);
            }
        }

        for (Long documentId : documentIds) {
            documentProcessExecutor.submit(() -> {
                try {
                    transactionTemplate.executeWithoutResult(status -> {
                        processDocumentInTransaction(documentId);
                    });
                } catch (Exception e) {
                    log.error("异步向量化失败: documentId={}", documentId, e);
                }
            });
        }
    }

    /**
     * 在事务内处理单个文档向量化（供 TransactionTemplate 回调使用）
     */
    private void processDocumentInTransaction(Long documentId) {
        KnowledgeDocument doc = documentRepository.findById(KnowledgeDocumentId.of(documentId))
                .orElseThrow(() -> new IllegalArgumentException("文档不存在: " + documentId));

        KnowledgeBase kb = knowledgeBaseRepository.findById(doc.getKnowledgeBaseId())
                .orElseThrow(() -> new IllegalArgumentException("知识库不存在"));

        try {
            doc.startProcessing();
            documentRepository.save(doc);
            vectorizeDocumentCore(doc, kb);
        } catch (Exception e) {
            log.error("文档向量化失败: documentId={}", documentId, e);
            doc.failProcessing(e.getMessage());
            documentRepository.save(doc);
            throw new RuntimeException("文档向量化失败: " + e.getMessage(), e);
        }
    }

    /**
     * 文档向量化核心逻辑（无事务注解，由调用方管理事务）
     * 
     * 流程：清理旧分块 → 提取内容 → 切分 → 分批向量化 → 保存分块 → 更新状态
     */
    private void vectorizeDocumentCore(KnowledgeDocument doc, KnowledgeBase kb) {
        // 清理旧分块（重试时避免重复）
        chunkRepository.deleteByDocumentId(doc.getId());

        // 提取文档内容
        String content = doc.getContent();
        if ((content == null || content.isEmpty()) && doc.getFileUrl() != null && !doc.getFileUrl().isEmpty()) {
            log.info("文档内容为空，从文件URL提取: fileType={}, url={}", doc.getFileType(), doc.getFileUrl());
            content = contentExtractor.extractContent(doc.getFileUrl(), doc.getFileType().name());
            doc.setContent(content, computeHash(content));
            documentRepository.save(doc);
        }
        if (content == null || content.isEmpty()) {
            throw new IllegalStateException("文档内容为空，且无法从文件URL提取");
        }

        // 切分
        DocumentChunkingService.ChunkConfig chunkConfig = buildChunkConfig(kb);
        DocumentChunkingService.ChunkResult chunkResult = chunkingService.split(content, chunkConfig);
        List<String> chunkContents = chunkResult.getChunks().stream()
                .map(DocumentChunkingService.ChunkItem::getContent)
                .collect(Collectors.toList());

        // 构建 metadata（使用 Gson 避免 JSON 注入）
        com.google.gson.JsonObject metadataJson = new com.google.gson.JsonObject();
        metadataJson.addProperty("documentId", doc.getId().value());
        metadataJson.addProperty("documentName", doc.getName());
        String metadata = metadataJson.toString();

        // 分批向量化（每200条一轮）
        int embeddingBatchSize = 200;
        List<String> allChunkContents = new ArrayList<>();
        List<float[]> allEmbeddings = new ArrayList<>();

        for (int batchStart = 0; batchStart < chunkContents.size(); batchStart += embeddingBatchSize) {
            int batchEnd = Math.min(batchStart + embeddingBatchSize, chunkContents.size());
            List<String> batchChunks = chunkContents.subList(batchStart, batchEnd);
            log.info("向量化批次 {}-{}/{}", batchStart + 1, batchEnd, chunkContents.size());

            ChapterVector[] vectors = embeddingService.embedTexts(batchChunks.toArray(new String[0]));
            for (ChapterVector v : vectors) {
                allEmbeddings.add(v.getEmbedding());
            }
            allChunkContents.addAll(batchChunks);
        }

        // 批量保存分块
        chunkRepository.saveChunks(doc.getKnowledgeBaseId(), doc.getId(), allChunkContents, allEmbeddings, metadata);

        // 更新文档状态
        doc.completeProcessing(chunkContents.size());
        documentRepository.save(doc);

        // 更新知识库分块数量
        long totalChunks = chunkRepository.countByKnowledgeBaseId(doc.getKnowledgeBaseId());
        knowledgeBaseRepository.updateChunkCount(doc.getKnowledgeBaseId(), (int) totalChunks);

        log.info("文档向量化完成: documentId={}, chunkCount={}, strategy={}",
                doc.getId().value(), chunkContents.size(), chunkResult.getStrategyUsed());
    }

    /**
     * 批量处理结果
     */
    @Data
    public static class BatchProcessResult {
        private int total;
        private List<Long> successIds = new ArrayList<>();
        private List<FailedItem> failedItems = new ArrayList<>();

        public int getSuccessCount() {
            return successIds.size();
        }

        public int getFailedCount() {
            return failedItems.size();
        }

        public void addSuccess(Long id) {
            successIds.add(id);
        }

        public void addFailed(Long id, String reason) {
            failedItems.add(new FailedItem(id, reason));
        }

        @Data
        @AllArgsConstructor
        public static class FailedItem {
            private Long documentId;
            private String reason;
        }
    }

    /**
     * 预览文档切分效果（不执行向量化，仅返回切分结果）
     */
    public ChunkPreviewResult previewChunking(String content, String strategyStr,
                                               Integer chunkSize, Integer chunkOverlap,
                                               Boolean parentChildMode, Integer parentChunkSize,
                                               Boolean preserveMetadata, Double semanticThreshold) {
        if (content == null || content.trim().isEmpty()) {
            throw new IllegalArgumentException("预览内容不能为空");
        }

        ChunkStrategy strategy = parseChunkStrategy(strategyStr);
        DocumentChunkingService.ChunkConfig config = DocumentChunkingService.ChunkConfig.builder()
                .strategy(strategy != null ? strategy : ChunkStrategy.SEMANTIC)
                .chunkSize(chunkSize != null ? chunkSize : 500)
                .chunkOverlap(chunkOverlap != null ? chunkOverlap : 50)
                .parentChildMode(parentChildMode != null ? parentChildMode : false)
                .parentChunkSize(parentChunkSize != null ? parentChunkSize : 1500)
                .preserveMetadata(preserveMetadata != null ? preserveMetadata : true)
                .semanticThreshold(semanticThreshold != null ? semanticThreshold : 0.5)
                .build();

        DocumentChunkingService.ChunkResult result = chunkingService.split(content, config);

        List<ChunkPreviewItem> items = new ArrayList<>();
        for (DocumentChunkingService.ChunkItem item : result.getChunks()) {
            ChunkPreviewItem preview = new ChunkPreviewItem();
            preview.setIndex(item.getIndex());
            preview.setContent(item.getContent());
            preview.setCharCount(item.getContent().length());
            preview.setCharStart(item.getCharStart());
            preview.setCharEnd(item.getCharEnd());
            preview.setParentIndex(item.getParentIndex());
            preview.setIsParent(item.isParent());
            preview.setSectionTitle(item.getSectionTitle());
            items.add(preview);
        }

        ChunkPreviewResult previewResult = new ChunkPreviewResult();
        previewResult.setStrategy(result.getStrategyUsed().name());
        previewResult.setTotalChunks(result.getTotalChunks());
        previewResult.setTotalCharacters(content.length());
        previewResult.setAvgChunkSize(items.isEmpty() ? 0 :
                items.stream().mapToInt(ChunkPreviewItem::getCharCount).sum() / items.size());
        previewResult.setChunks(items);
        return previewResult;
    }

    /**
     * 预览文档切分效果（基于已有文档ID）
     */
    public ChunkPreviewResult previewDocumentChunking(Long documentId, String strategyStr,
                                                       Integer chunkSize, Integer chunkOverlap,
                                                       Boolean parentChildMode, Integer parentChunkSize,
                                                       Boolean preserveMetadata, Double semanticThreshold) {
        KnowledgeDocument doc = documentRepository.findById(KnowledgeDocumentId.of(documentId))
                .orElseThrow(() -> new IllegalArgumentException("文档不存在: " + documentId));

        String content = doc.getContent();
        if ((content == null || content.isEmpty()) && doc.getFileUrl() != null && !doc.getFileUrl().isEmpty()) {
            content = contentExtractor.extractContent(doc.getFileUrl(), doc.getFileType().name());
        }
        if (content == null || content.isEmpty()) {
            throw new IllegalStateException("文档内容为空");
        }

        return previewChunking(content, strategyStr, chunkSize, chunkOverlap,
                parentChildMode, parentChunkSize, preserveMetadata, semanticThreshold);
    }

    /**
     * 切分预览结果
     */
    @Data
    public static class ChunkPreviewResult {
        private String strategy;
        private int totalChunks;
        private int totalCharacters;
        private int avgChunkSize;
        private List<ChunkPreviewItem> chunks;
    }

    @Data
    public static class ChunkPreviewItem {
        private int index;
        private String content;
        private int charCount;
        private int charStart;
        private int charEnd;
        private Integer parentIndex;
        private Boolean isParent;
        private String sectionTitle;
    }

    /**
     * 从知识库配置构建切分配置
     */
    private DocumentChunkingService.ChunkConfig buildChunkConfig(KnowledgeBase kb) {
        return DocumentChunkingService.ChunkConfig.builder()
                .strategy(kb.getChunkStrategy() != null ? kb.getChunkStrategy() : ChunkStrategy.SEMANTIC)
                .chunkSize(kb.getChunkSize() != null ? kb.getChunkSize() : 500)
                .chunkOverlap(kb.getChunkOverlap() != null ? kb.getChunkOverlap() : 50)
                .parentChildMode(kb.getParentChildMode() != null ? kb.getParentChildMode() : false)
                .parentChunkSize(kb.getParentChunkSize() != null ? kb.getParentChunkSize() : 1500)
                .preserveMetadata(kb.getPreserveMetadata() != null ? kb.getPreserveMetadata() : true)
                .semanticThreshold(kb.getSemanticThreshold() != null ? kb.getSemanticThreshold() : 0.5)
                .build();
    }

    private ChunkStrategy parseChunkStrategy(String strategyStr) {
        if (strategyStr == null || strategyStr.trim().isEmpty()) {
            return null;
        }
        try {
            return ChunkStrategy.valueOf(strategyStr.toUpperCase());
        } catch (IllegalArgumentException e) {
            log.warn("无效的切分策略: {}", strategyStr);
            return null;
        }
    }

    /**
     * 计算内容哈希
     */
    private String computeHash(String content) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(content.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 获取文档的分块列表（分页）
     */
    public List<KnowledgeChunkVO> listChunks(Long documentId, int page, int size) {
        List<KnowledgeChunkRepository.ChunkDetail> chunks = 
                chunkRepository.findByDocumentId(KnowledgeDocumentId.of(documentId), page, size);
        return chunks.stream().map(this::toChunkVO).collect(Collectors.toList());
    }

    /**
     * 统计文档的分块数量
     */
    public long countChunks(Long documentId) {
        return chunkRepository.countByDocumentId(KnowledgeDocumentId.of(documentId));
    }

    /**
     * 更新文档元信息
     */
    @Transactional
    public KnowledgeDocumentVO updateDocument(Long documentId, String name, String fileType) {
        log.info("更新文档元信息: documentId={}, name={}, fileType={}", documentId, name, fileType);

        KnowledgeDocument doc = documentRepository.findById(KnowledgeDocumentId.of(documentId))
                .orElseThrow(() -> new IllegalArgumentException("文档不存在: " + documentId));

        if (name != null && !name.trim().isEmpty()) {
            doc.updateName(name.trim());
        }
        if (fileType != null && !fileType.trim().isEmpty()) {
            doc.updateFileType(DocumentType.valueOf(fileType.toUpperCase()));
        }

        KnowledgeDocument saved = documentRepository.save(doc);
        return toDocumentVO(saved);
    }

    private KnowledgeChunkVO toChunkVO(KnowledgeChunkRepository.ChunkDetail chunk) {
        KnowledgeChunkVO vo = new KnowledgeChunkVO();
        vo.setId(chunk.id());
        vo.setKnowledgeBaseId(chunk.knowledgeBaseId());
        vo.setDocumentId(chunk.documentId());
        vo.setContent(chunk.content());
        vo.setChunkIndex(chunk.chunkIndex());
        vo.setParentChunkId(chunk.parentChunkId());
        vo.setIsParentChunk(chunk.isParentChunk());
        vo.setSectionTitle(chunk.sectionTitle());
        vo.setMetadata(chunk.metadata());
        vo.setCreateTime(chunk.createTime());
        return vo;
    }

    private KnowledgeBaseVO toVO(KnowledgeBase kb) {
        KnowledgeBaseVO vo = new KnowledgeBaseVO();
        vo.setId(kb.getId().value());
        vo.setName(kb.getName());
        vo.setDescription(kb.getDescription());
        vo.setEmbeddingModel(kb.getEmbeddingModel());
        vo.setEmbeddingDimension(kb.getEmbeddingDimension());
        vo.setChunkSize(kb.getChunkSize());
        vo.setChunkOverlap(kb.getChunkOverlap());
        vo.setChunkStrategy(kb.getChunkStrategy() != null ? kb.getChunkStrategy().name() : "SEMANTIC");
        vo.setParentChildMode(kb.getParentChildMode());
        vo.setParentChunkSize(kb.getParentChunkSize());
        vo.setPreserveMetadata(kb.getPreserveMetadata());
        vo.setSemanticThreshold(kb.getSemanticThreshold());
        vo.setRetrievalMode(kb.getRetrievalMode());
        vo.setEnableQueryRewrite(kb.getEnableQueryRewrite());
        vo.setUseDynamicTopK(kb.getUseDynamicTopK());
        vo.setDefaultTopK(kb.getDefaultTopK());
        vo.setQueryRewriteModelId(kb.getQueryRewriteModelId());
        vo.setRerankModel(kb.getRerankModel());
        vo.setDocumentCount(kb.getDocumentCount());
        vo.setChunkCount(kb.getChunkCount());
        vo.setStatus(kb.getStatus());
        vo.setCreatorId(kb.getCreatorId().value());
        vo.setCreateTime(kb.getCreateTime());
        vo.setUpdateTime(kb.getUpdateTime());
        return vo;
    }

    private KnowledgeDocumentVO toDocumentVO(KnowledgeDocument doc) {
        KnowledgeDocumentVO vo = new KnowledgeDocumentVO();
        vo.setId(doc.getId().value());
        vo.setKnowledgeBaseId(doc.getKnowledgeBaseId().value());
        vo.setName(doc.getName());
        vo.setFileType(doc.getFileType().name());
        vo.setFileUrl(doc.getFileUrl());
        vo.setFileSize(doc.getFileSize());
        vo.setChunkCount(doc.getChunkCount());
        vo.setStatus(doc.getStatus().name());
        vo.setErrorMessage(doc.getErrorMessage());
        vo.setCreatorId(doc.getCreatorId().value());
        vo.setCreateTime(doc.getCreateTime());
        vo.setUpdateTime(doc.getUpdateTime());
        return vo;
    }
}
