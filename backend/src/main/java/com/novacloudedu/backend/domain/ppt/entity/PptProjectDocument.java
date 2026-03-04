package com.novacloudedu.backend.domain.ppt.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * PPT项目文档
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PptProjectDocument {

    private Long id;
    private Long projectId;
    private String fileName;
    private String fileUrl;
    private String fileType;
    private Long fileSize;
    private String content;
    private LocalDateTime createTime;

    public static PptProjectDocument create(Long projectId, String fileName, String fileUrl,
                                             String fileType, Long fileSize) {
        PptProjectDocument d = new PptProjectDocument();
        d.projectId = projectId;
        d.fileName = fileName;
        d.fileUrl = fileUrl;
        d.fileType = fileType;
        d.fileSize = fileSize;
        d.createTime = LocalDateTime.now();
        return d;
    }

    public static PptProjectDocument reconstruct(Long id, Long projectId, String fileName,
                                                  String fileUrl, String fileType, Long fileSize,
                                                  String content, LocalDateTime createTime) {
        PptProjectDocument d = new PptProjectDocument();
        d.id = id;
        d.projectId = projectId;
        d.fileName = fileName;
        d.fileUrl = fileUrl;
        d.fileType = fileType;
        d.fileSize = fileSize;
        d.content = content;
        d.createTime = createTime;
        return d;
    }

    public void assignId(Long id) {
        if (this.id != null) throw new IllegalStateException("文档ID已分配");
        this.id = id;
    }

    public void updateContent(String content) {
        this.content = content;
    }
}
