package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.ppt.entity.PptProject;
import com.novacloudedu.backend.domain.ppt.entity.PptProjectDocument;
import com.novacloudedu.backend.domain.ppt.repository.PptProjectRepository;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * PPT项目应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class PptProjectService {

    private final PptProjectRepository projectRepository;

    // ==================== 项目 CRUD ====================

    public Map<String, Object> createProject(Long userId, String name, String description) {
        PptProject project = PptProject.create(userId, name, description);
        projectRepository.save(project);
        log.info("创建PPT项目: id={}, name={}, userId={}", project.getId(), name, userId);
        return toProjectMap(project);
    }

    public List<Map<String, Object>> listProjects(Long userId) {
        return projectRepository.findByUserId(userId).stream()
                .map(this::toProjectMap)
                .collect(Collectors.toList());
    }

    public Map<String, Object> getProjectDetail(Long projectId, Long userId) {
        PptProject project = getProjectAndVerify(projectId, userId);
        // 加载文档列表
        List<PptProjectDocument> docs = projectRepository.findDocumentsByProjectId(projectId);
        Map<String, Object> result = toProjectMap(project);
        result.put("documents", docs.stream().map(this::toDocumentMap).collect(Collectors.toList()));
        return result;
    }

    public void updateProject(Long projectId, Long userId, String name, String description) {
        PptProject project = getProjectAndVerify(projectId, userId);
        project.updateInfo(name, description);
        projectRepository.save(project);
    }

    public void deleteProject(Long projectId, Long userId) {
        PptProject project = getProjectAndVerify(projectId, userId);
        projectRepository.deleteById(project.getId());
    }

    // ==================== 文档管理 ====================

    public Map<String, Object> addDocument(Long projectId, Long userId,
                                            String fileName, String fileUrl,
                                            String fileType, Long fileSize) {
        PptProject project = getProjectAndVerify(projectId, userId);
        PptProjectDocument doc = PptProjectDocument.create(
                project.getId(), fileName, fileUrl, fileType, fileSize);
        projectRepository.saveDocument(doc);
        log.info("添加项目文档: docId={}, projectId={}, fileName={}", doc.getId(), projectId, fileName);
        return toDocumentMap(doc);
    }

    public void updateDocumentContent(Long documentId, Long userId, String content) {
        PptProjectDocument doc = projectRepository.findDocumentById(documentId)
                .orElseThrow(() -> new BusinessException(40400, "文档不存在"));
        // 验证所有权
        PptProject project = projectRepository.findById(doc.getProjectId())
                .orElseThrow(() -> new BusinessException(40400, "项目不存在"));
        project.verifyOwner(userId);

        doc.updateContent(content);
        projectRepository.saveDocument(doc);
    }

    public void deleteDocument(Long documentId, Long userId) {
        PptProjectDocument doc = projectRepository.findDocumentById(documentId)
                .orElseThrow(() -> new BusinessException(40400, "文档不存在"));
        PptProject project = projectRepository.findById(doc.getProjectId())
                .orElseThrow(() -> new BusinessException(40400, "项目不存在"));
        project.verifyOwner(userId);
        projectRepository.deleteDocumentById(documentId);
    }

    /**
     * 获取项目所有文档的文本内容，用于注入AI上下文
     */
    public String getProjectDocumentsContext(Long projectId) {
        List<PptProjectDocument> docs = projectRepository.findDocumentsByProjectId(projectId);
        if (docs.isEmpty()) return "";

        StringBuilder sb = new StringBuilder();
        sb.append("以下是用户上传的参考文档内容：\n\n");
        for (PptProjectDocument doc : docs) {
            if (doc.getContent() != null && !doc.getContent().isBlank()) {
                sb.append("=== ").append(doc.getFileName()).append(" ===\n");
                sb.append(doc.getContent()).append("\n\n");
            }
        }

        // 列出项目中的图片资源
        List<ProjectImageInfo> images = getProjectImageInfos(projectId);
        if (!images.isEmpty()) {
            sb.append("\n=== 项目图片资源 ===\n");
            sb.append("以下图片可直接用于PPT幻灯片中（优先使用这些图片而非AI生成）：\n");
            for (ProjectImageInfo img : images) {
                sb.append("- ").append(img.fileName()).append(" → ").append(img.fileUrl()).append("\n");
            }
            sb.append("\n");
        }

        return sb.toString();
    }

    private static final java.util.Set<String> IMAGE_EXTENSIONS = java.util.Set.of(
            "jpg", "jpeg", "png", "gif", "webp", "svg", "bmp", "tiff", "ico"
    );

    /**
     * 获取项目中的图片文档信息列表
     */
    public List<ProjectImageInfo> getProjectImageInfos(Long projectId) {
        List<PptProjectDocument> docs = projectRepository.findDocumentsByProjectId(projectId);
        return docs.stream()
                .filter(d -> d.getFileType() != null && IMAGE_EXTENSIONS.contains(d.getFileType().toLowerCase()))
                .map(d -> new ProjectImageInfo(d.getFileName(), d.getFileUrl(), d.getFileType()))
                .collect(Collectors.toList());
    }

    /**
     * 项目图片信息
     */
    public record ProjectImageInfo(String fileName, String fileUrl, String fileType) {}

    // ==================== 内部方法 ====================

    private PptProject getProjectAndVerify(Long projectId, Long userId) {
        PptProject project = projectRepository.findById(projectId)
                .orElseThrow(() -> new BusinessException(40400, "项目不存在"));
        project.verifyOwner(userId);
        return project;
    }

    private Map<String, Object> toProjectMap(PptProject project) {
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("id", project.getId());
        map.put("name", project.getName());
        map.put("description", project.getDescription());
        map.put("createTime", project.getCreateTime());
        map.put("updateTime", project.getUpdateTime());
        return map;
    }

    private Map<String, Object> toDocumentMap(PptProjectDocument doc) {
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("id", doc.getId());
        map.put("fileName", doc.getFileName());
        map.put("fileUrl", doc.getFileUrl());
        map.put("fileType", doc.getFileType());
        map.put("fileSize", doc.getFileSize());
        map.put("hasContent", doc.getContent() != null && !doc.getContent().isBlank());
        map.put("createTime", doc.getCreateTime());
        return map;
    }
}
