package com.novacloudedu.backend.interfaces.rest.ai;

import com.novacloudedu.backend.application.service.KnowledgeBaseApplicationService;
import com.novacloudedu.backend.application.ai.command.CreateKnowledgeBaseCommand;
import com.novacloudedu.backend.application.ai.command.UpdateKnowledgeBaseCommand;
import com.novacloudedu.backend.application.ai.dto.KnowledgeBaseVO;
import com.novacloudedu.backend.application.ai.dto.KnowledgeChunkVO;
import com.novacloudedu.backend.application.ai.dto.KnowledgeDocumentVO;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
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

    @PostMapping
    @Operation(summary = "创建知识库")
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
    @Operation(summary = "更新知识库")
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
    @Operation(summary = "获取知识库详情")
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
    @Operation(summary = "获取用户的知识库列表")
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
    @Operation(summary = "搜索知识库")
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
    @Operation(summary = "删除知识库")
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
    @Operation(summary = "添加文档")
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
    @Operation(summary = "获取文档列表")
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

    @DeleteMapping("/{id}/documents/{docId}")
    @Operation(summary = "删除文档")
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
    @Operation(summary = "触发文档向量化")
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
    @Operation(summary = "批量文档向量化")
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
    @Operation(summary = "向量化知识库所有待处理文档")
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
    @Operation(summary = "异步批量文档向量化")
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
    @Operation(summary = "获取文档分块列表")
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
    @Operation(summary = "更新文档元信息")
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
}
