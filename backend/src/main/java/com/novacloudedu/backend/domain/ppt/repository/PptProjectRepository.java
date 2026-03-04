package com.novacloudedu.backend.domain.ppt.repository;

import com.novacloudedu.backend.domain.ppt.entity.PptProject;
import com.novacloudedu.backend.domain.ppt.entity.PptProjectDocument;

import java.util.List;
import java.util.Optional;

/**
 * PPT项目仓储接口
 */
public interface PptProjectRepository {

    PptProject save(PptProject project);

    Optional<PptProject> findById(Long id);

    List<PptProject> findByUserId(Long userId);

    void deleteById(Long id);

    // ---- 文档操作 ----

    PptProjectDocument saveDocument(PptProjectDocument document);

    List<PptProjectDocument> findDocumentsByProjectId(Long projectId);

    Optional<PptProjectDocument> findDocumentById(Long documentId);

    void deleteDocumentById(Long documentId);
}
