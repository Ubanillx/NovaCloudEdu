package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.file.entity.FileUpload;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.FileUploadPO;
import org.springframework.stereotype.Component;

@Component
public class FileUploadConverter {

    public FileUploadPO toFileUploadPO(FileUpload fileUpload) {
        FileUploadPO po = new FileUploadPO();
        if (fileUpload.getId() != null) {
            po.setId(fileUpload.getId());
        }
        po.setFileName(fileUpload.getFileName());
        po.setOriginalName(fileUpload.getOriginalName());
        po.setFileUrl(fileUpload.getFileUrl());
        po.setFileSize(fileUpload.getFileSize());
        po.setContentType(fileUpload.getContentType());
        po.setBusinessType(fileUpload.getBusinessType().getFolder());
        po.setUploaderId(fileUpload.getUploaderId().value());
        po.setCreateTime(fileUpload.getCreateTime());
        return po;
    }

    public FileUpload toFileUpload(FileUploadPO po) {
        return FileUpload.reconstruct(
                po.getId(),
                po.getFileName(),
                po.getOriginalName(),
                po.getFileUrl(),
                po.getFileSize(),
                po.getContentType(),
                FileBusinessType.fromFolder(po.getBusinessType()),
                UserId.of(po.getUploaderId()),
                po.getCreateTime()
        );
    }
}
