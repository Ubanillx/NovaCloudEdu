package com.novacloudedu.backend.domain.file.entity;

import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class FileUpload {

    private Long id;
    private final String fileName;
    private final String originalName;
    private final String fileUrl;
    private final Long fileSize;
    private final String contentType;
    private final FileBusinessType businessType;
    private final UserId uploaderId;
    private final LocalDateTime createTime;

    private FileUpload(Long id, String fileName, String originalName, String fileUrl,
                      Long fileSize, String contentType, FileBusinessType businessType,
                      UserId uploaderId, LocalDateTime createTime) {
        this.id = id;
        this.fileName = fileName;
        this.originalName = originalName;
        this.fileUrl = fileUrl;
        this.fileSize = fileSize;
        this.contentType = contentType;
        this.businessType = businessType;
        this.uploaderId = uploaderId;
        this.createTime = createTime;
    }

    public static FileUpload create(String fileName, String originalName, String fileUrl,
                                   Long fileSize, String contentType, FileBusinessType businessType,
                                   UserId uploaderId) {
        if (originalName == null || originalName.isEmpty()) {
            throw new IllegalArgumentException("文件名不能为空");
        }
        return new FileUpload(null, fileName, originalName, fileUrl, fileSize, contentType,
                businessType, uploaderId, LocalDateTime.now());
    }

    /**
     * 创建待上传的文件实体（先验证，再上传后填充URL）
     */
    public FileUpload withUrl(String uploadedUrl) {
        return new FileUpload(null, this.fileName, this.originalName, uploadedUrl,
                this.fileSize, this.contentType, this.businessType, this.uploaderId, this.createTime);
    }

    public static FileUpload reconstruct(Long id, String fileName, String originalName,
                                        String fileUrl, Long fileSize, String contentType,
                                        FileBusinessType businessType, UserId uploaderId,
                                        LocalDateTime createTime) {
        return new FileUpload(id, fileName, originalName, fileUrl, fileSize, contentType,
                businessType, uploaderId, createTime);
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("文件ID已存在");
        }
        this.id = id;
    }

    public void validateSize(boolean isAdmin) {
        if (isAdmin) {
            return;
        }
        
        if (fileSize > businessType.getMaxSizeBytes()) {
            long maxSizeMB = businessType.getMaxSizeBytes() / (1024 * 1024);
            throw new IllegalArgumentException(
                String.format("文件大小超过限制，%s最大允许%dMB", 
                    businessType.getDescription(), maxSizeMB)
            );
        }
    }
}
