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

        if (dto.getChunkSize() != null || dto.getChunkOverlap() != null) {
            kb.updateEmbeddingConfig(dto.getChunkSize(), dto.getChunkOverlap());
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

        if (dto.getChunkSize() != null || dto.getChunkOverlap() != null) {
            kb.updateEmbeddingConfig(dto.getChunkSize(), dto.getChunkOverlap());
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
     * 处理文档向量化
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

            String content = doc.getContent();
            if ((content == null || content.isEmpty()) && doc.getFileUrl() != null && !doc.getFileUrl().isEmpty()) {
                log.info("文档内容为空，从文件URL提取: fileType={}, url={}", doc.getFileType(), doc.getFileUrl());
                content = contentExtractor.extractContent(doc.getFileUrl(), doc.getFileType().name());
                String hash = computeHash(content);
                doc.setContent(content, hash);
                documentRepository.save(doc);
            }
            if (content == null || content.isEmpty()) {
                throw new IllegalStateException("文档内容为空，且无法从文件URL提取");
            }

            // 分块
            List<String> chunks = splitContent(content, kb.getChunkSize(), kb.getChunkOverlap());
            
            String metadata = String.format("{\"documentId\": %d, \"documentName\": \"%s\"}", 
                    doc.getId().value(), doc.getName());

            // 分批向量化（每200条一轮）并保存
            int embeddingBatchSize = 200;
            List<String> allChunkContents = new ArrayList<>();
            List<float[]> allEmbeddings = new ArrayList<>();

            for (int batchStart = 0; batchStart < chunks.size(); batchStart += embeddingBatchSize) {
                int batchEnd = Math.min(batchStart + embeddingBatchSize, chunks.size());
                List<String> batchChunks = chunks.subList(batchStart, batchEnd);
                log.info("向量化批次 {}-{}/{}", batchStart + 1, batchEnd, chunks.size());

                String[] batchArray = batchChunks.toArray(new String[0]);
                ChapterVector[] vectors = embeddingService.embedTexts(batchArray);

                for (ChapterVector v : vectors) {
                    allEmbeddings.add(v.getEmbedding());
                }
                allChunkContents.addAll(batchChunks);
            }

            // 批量保存分块（Repository内部按1000条一轮插入数据库）
            chunkRepository.saveChunks(
                    doc.getKnowledgeBaseId(),
                    doc.getId(),
                    allChunkContents,
                    allEmbeddings,
                    metadata
            );

            // 更新文档状态
            doc.completeProcessing(chunks.size());
            documentRepository.save(doc);

            // 更新知识库分块数量
            long totalChunks = chunkRepository.countByKnowledgeBaseId(doc.getKnowledgeBaseId());
            knowledgeBaseRepository.updateChunkCount(doc.getKnowledgeBaseId(), (int) totalChunks);

            log.info("文档向量化完成: documentId={}, chunkCount={}", documentId, chunks.size());

        } catch (Exception e) {
            log.error("文档向量化失败: documentId={}", documentId, e);
            doc.failProcessing(e.getMessage());
            documentRepository.save(doc);
            throw new RuntimeException("文档向量化失败: " + e.getMessage(), e);
        }
    }

    /**
     * 批量处理文档向量化
     */
    @Transactional
    public BatchProcessResult batchProcessDocuments(List<Long> documentIds) {
        log.info("批量处理文档向量化: count={}", documentIds.size());

        BatchProcessResult result = new BatchProcessResult();
        result.setTotal(documentIds.size());

        for (Long documentId : documentIds) {
            try {
                processDocument(documentId);
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
    @Transactional
    public BatchProcessResult batchProcessByKnowledgeBase(Long knowledgeBaseId) {
        log.info("批量处理知识库文档: knowledgeBaseId={}", knowledgeBaseId);

        // 查询所有待处理的文档
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
                // 先标记为处理中
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

        // 使用线程池异步处理
        for (Long documentId : documentIds) {
            documentProcessExecutor.submit(() -> {
                try {
                    processDocumentInternal(documentId);
                } catch (Exception e) {
                    log.error("异步向量化失败: documentId={}", documentId, e);
                }
            });
        }
    }

    /**
     * 内部处理文档向量化（不含事务）
     */
    private void processDocumentInternal(Long documentId) {
        KnowledgeDocument doc = documentRepository.findById(KnowledgeDocumentId.of(documentId))
                .orElse(null);
        if (doc == null) {
            return;
        }

        KnowledgeBase kb = knowledgeBaseRepository.findById(doc.getKnowledgeBaseId())
                .orElse(null);
        if (kb == null) {
            return;
        }

        try {
            String content = doc.getContent();
            if ((content == null || content.isEmpty()) && doc.getFileUrl() != null && !doc.getFileUrl().isEmpty()) {
                log.info("异步处理: 文档内容为空，从文件URL提取: fileType={}, url={}", doc.getFileType(), doc.getFileUrl());
                content = contentExtractor.extractContent(doc.getFileUrl(), doc.getFileType().name());
                String hash = computeHash(content);
                doc.setContent(content, hash);
                documentRepository.save(doc);
            }
            if (content == null || content.isEmpty()) {
                doc.failProcessing("文档内容为空，且无法从文件URL提取");
                documentRepository.save(doc);
                return;
            }

            // 分块
            List<String> chunks = splitContent(content, kb.getChunkSize(), kb.getChunkOverlap());
            
            String metadata = String.format("{\"documentId\": %d, \"documentName\": \"%s\"}", 
                    doc.getId().value(), doc.getName());

            // 分批向量化（每200条一轮）并保存
            int embeddingBatchSize = 200;
            List<String> allChunkContents = new ArrayList<>();
            List<float[]> allEmbeddings = new ArrayList<>();

            for (int batchStart = 0; batchStart < chunks.size(); batchStart += embeddingBatchSize) {
                int batchEnd = Math.min(batchStart + embeddingBatchSize, chunks.size());
                List<String> batchChunks = chunks.subList(batchStart, batchEnd);
                log.info("异步向量化批次 {}-{}/{}", batchStart + 1, batchEnd, chunks.size());

                String[] batchArray = batchChunks.toArray(new String[0]);
                ChapterVector[] vectors = embeddingService.embedTexts(batchArray);

                for (ChapterVector v : vectors) {
                    allEmbeddings.add(v.getEmbedding());
                }
                allChunkContents.addAll(batchChunks);
            }

            // 批量保存分块（Repository内部按1000条一轮插入数据库）
            chunkRepository.saveChunks(
                    doc.getKnowledgeBaseId(),
                    doc.getId(),
                    allChunkContents,
                    allEmbeddings,
                    metadata
            );

            // 更新文档状态
            doc.completeProcessing(chunks.size());
            documentRepository.save(doc);

            // 更新知识库分块数量
            long totalChunks = chunkRepository.countByKnowledgeBaseId(doc.getKnowledgeBaseId());
            knowledgeBaseRepository.updateChunkCount(doc.getKnowledgeBaseId(), (int) totalChunks);

            log.info("异步文档向量化完成: documentId={}, chunkCount={}", documentId, chunks.size());

        } catch (Exception e) {
            log.error("异步文档向量化失败: documentId={}", documentId, e);
            doc.failProcessing(e.getMessage());
            documentRepository.save(doc);
        }
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
     * 段落感知分块
     *
     * 策略：
     * 1. 从 start 开始取 chunkSize 个字符作为基准切割点
     * 2. 从基准切割点向后搜索最近的 \n，延伸到该段落结尾（最多额外延伸 chunkSize * 0.2）
     * 3. 如果向后找不到 \n，则向前搜索最近的 \n，在段落边界处切割
     * 4. overlap 起始位置也对齐到最近的 \n 边界，保证重叠部分从段落开头开始
     */
    private List<String> splitContent(String content, int chunkSize, int overlap) {
        List<String> chunks = new ArrayList<>();
        if (content == null || content.isEmpty()) {
            return chunks;
        }

        int maxExtend = Math.max(chunkSize / 5, 100);
        int len = content.length();
        int start = 0;

        while (start < len) {
            int baseEnd = Math.min(start + chunkSize, len);

            // 已经到达末尾，直接收尾
            if (baseEnd >= len) {
                chunks.add(content.substring(start).trim());
                break;
            }

            // 向后找最近的 \n（最多延伸 maxExtend 个字符）
            int end = baseEnd;
            int forwardNewline = content.indexOf('\n', baseEnd);
            if (forwardNewline != -1 && forwardNewline <= baseEnd + maxExtend) {
                end = forwardNewline + 1;
            } else {
                // 向前找最近的 \n
                int backwardNewline = content.lastIndexOf('\n', baseEnd);
                if (backwardNewline > start) {
                    end = backwardNewline + 1;
                }
                // 都找不到则保持 baseEnd
            }

            String chunk = content.substring(start, end).trim();
            if (!chunk.isEmpty()) {
                chunks.add(chunk);
            }

            // 计算下一个 start：end - overlap，然后对齐到最近的 \n 边界
            int nextStart = end - overlap;
            if (nextStart <= start) {
                nextStart = end;
            }
            // 从 nextStart 向前找 \n 对齐到段落开头
            int alignNewline = content.lastIndexOf('\n', nextStart);
            if (alignNewline > start && alignNewline >= nextStart - overlap) {
                nextStart = alignNewline + 1;
            }

            if (nextStart >= len) {
                break;
            }
            start = nextStart;
        }

        return chunks;
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
