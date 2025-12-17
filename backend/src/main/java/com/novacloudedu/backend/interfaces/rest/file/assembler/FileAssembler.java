package com.novacloudedu.backend.interfaces.rest.file.assembler;

import com.novacloudedu.backend.domain.file.entity.FileUpload;
import com.novacloudedu.backend.interfaces.rest.file.dto.FileInfoResponse;
import com.novacloudedu.backend.interfaces.rest.file.dto.UploadFileResponse;
import org.springframework.stereotype.Component;

@Component
public class FileAssembler {

    public UploadFileResponse toUploadFileResponse(FileUpload fileUpload) {
        return UploadFileResponse.builder()
                .fileUrl(fileUpload.getFileUrl())
                .fileName(fileUpload.getFileName())
                .originalName(fileUpload.getOriginalName())
                .fileSize(fileUpload.getFileSize())
                .businessType(fileUpload.getBusinessType().getFolder())
                .build();
    }

    public FileInfoResponse toFileInfoResponse(FileUpload fileUpload) {
        return FileInfoResponse.builder()
                .id(fileUpload.getId())
                .fileName(fileUpload.getFileName())
                .originalName(fileUpload.getOriginalName())
                .fileUrl(fileUpload.getFileUrl())
                .fileSize(fileUpload.getFileSize())
                .contentType(fileUpload.getContentType())
                .businessType(fileUpload.getBusinessType().getFolder())
                .businessTypeDesc(fileUpload.getBusinessType().getDescription())
                .uploaderId(fileUpload.getUploaderId().value())
                .createTime(fileUpload.getCreateTime())
                .build();
    }
}
