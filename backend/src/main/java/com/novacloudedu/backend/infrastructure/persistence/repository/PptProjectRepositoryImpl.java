package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.ppt.entity.PptProject;
import com.novacloudedu.backend.domain.ppt.entity.PptProjectDocument;
import com.novacloudedu.backend.domain.ppt.repository.PptProjectRepository;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PptProjectDocumentMapper;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PptProjectMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PptProjectDocumentPO;
import com.novacloudedu.backend.infrastructure.persistence.po.PptProjectPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * PPT项目仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PptProjectRepositoryImpl implements PptProjectRepository {

    private final PptProjectMapper projectMapper;
    private final PptProjectDocumentMapper documentMapper;

    @Override
    public PptProject save(PptProject project) {
        PptProjectPO po = toProjectPO(project);
        if (po.getId() == null) {
            projectMapper.insert(po);
            project.assignId(po.getId());
        } else {
            projectMapper.updateById(po);
        }
        return project;
    }

    @Override
    public Optional<PptProject> findById(Long id) {
        PptProjectPO po = projectMapper.selectById(id);
        if (po == null) return Optional.empty();
        List<PptProjectDocument> docs = findDocumentsByProjectId(id);
        return Optional.of(toProjectDomain(po, docs));
    }

    @Override
    public List<PptProject> findByUserId(Long userId) {
        LambdaQueryWrapper<PptProjectPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PptProjectPO::getUserId, userId)
                .orderByDesc(PptProjectPO::getUpdateTime);
        return projectMapper.selectList(wrapper).stream()
                .map(po -> toProjectDomain(po, List.of()))
                .collect(Collectors.toList());
    }

    @Override
    public void deleteById(Long id) {
        projectMapper.deleteById(id);
    }

    // ---- 文档操作 ----

    @Override
    public PptProjectDocument saveDocument(PptProjectDocument document) {
        PptProjectDocumentPO po = toDocumentPO(document);
        if (po.getId() == null) {
            documentMapper.insert(po);
            document.assignId(po.getId());
        } else {
            documentMapper.updateById(po);
        }
        return document;
    }

    @Override
    public List<PptProjectDocument> findDocumentsByProjectId(Long projectId) {
        LambdaQueryWrapper<PptProjectDocumentPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PptProjectDocumentPO::getProjectId, projectId)
                .orderByDesc(PptProjectDocumentPO::getCreateTime);
        return documentMapper.selectList(wrapper).stream()
                .map(this::toDocumentDomain)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<PptProjectDocument> findDocumentById(Long documentId) {
        PptProjectDocumentPO po = documentMapper.selectById(documentId);
        return po == null ? Optional.empty() : Optional.of(toDocumentDomain(po));
    }

    @Override
    public void deleteDocumentById(Long documentId) {
        documentMapper.deleteById(documentId);
    }

    // ---- 转换方法 ----

    private PptProject toProjectDomain(PptProjectPO po, List<PptProjectDocument> docs) {
        return PptProject.reconstruct(
                po.getId(), po.getUserId(), po.getName(), po.getDescription(),
                docs, po.getCreateTime(), po.getUpdateTime()
        );
    }

    private PptProjectPO toProjectPO(PptProject project) {
        PptProjectPO po = new PptProjectPO();
        po.setId(project.getId());
        po.setUserId(project.getUserId());
        po.setName(project.getName());
        po.setDescription(project.getDescription());
        po.setCreateTime(project.getCreateTime());
        po.setUpdateTime(project.getUpdateTime());
        return po;
    }

    private PptProjectDocument toDocumentDomain(PptProjectDocumentPO po) {
        return PptProjectDocument.reconstruct(
                po.getId(), po.getProjectId(), po.getFileName(),
                po.getFileUrl(), po.getFileType(), po.getFileSize(),
                po.getContent(), po.getCreateTime()
        );
    }

    private PptProjectDocumentPO toDocumentPO(PptProjectDocument doc) {
        PptProjectDocumentPO po = new PptProjectDocumentPO();
        po.setId(doc.getId());
        po.setProjectId(doc.getProjectId());
        po.setFileName(doc.getFileName());
        po.setFileUrl(doc.getFileUrl());
        po.setFileType(doc.getFileType());
        po.setFileSize(doc.getFileSize());
        po.setContent(doc.getContent());
        po.setCreateTime(doc.getCreateTime());
        return po;
    }
}
