package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.file.entity.FileUpload;
import com.novacloudedu.backend.domain.file.repository.FileUploadRepository;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

/**
 * 文件应用服务
 * 负责文件上传、删除等用例编排
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class FileApplicationService {

    private final OssService ossService;
    private final FileUploadRepository fileUploadRepository;

    @Transactional
    public String uploadFile(MultipartFile file, FileBusinessType businessType, UserId uploaderId, boolean isAdmin) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException(40000, "文件不能为空");
        }

        // 实体工厂方法包含文件名校验（领域规则）
        FileUpload fileUpload;
        try {
            fileUpload = FileUpload.create(
                    UUID.randomUUID().toString(),
                    file.getOriginalFilename(),
                    "",
                    file.getSize(),
                    file.getContentType(),
                    businessType,
                    uploaderId
            );
        } catch (IllegalArgumentException e) {
            throw new BusinessException(40000, e.getMessage());
        }

        // 实体领域方法：文件大小校验
        fileUpload.validateSize(isAdmin);

        // 基础设施调用：上传到 OSS
        String fileUrl = ossService.uploadFile(file, businessType);

        // 实体领域方法：填充上传后的 URL
        FileUpload savedFile = fileUpload.withUrl(fileUrl);
        fileUploadRepository.save(savedFile);

        log.info("文件上传成功: fileName={}, url={}", file.getOriginalFilename(), fileUrl);
        return fileUrl;
    }

    @Transactional
    public void deleteFile(Long fileId) {
        FileUpload fileUpload = fileUploadRepository.findById(fileId)
                .orElseThrow(() -> new BusinessException(40400, "文件不存在"));

        ossService.deleteFile(fileUpload.getFileUrl());
        fileUploadRepository.deleteById(fileId);
        log.info("文件删除成功: fileId={}", fileId);
    }
}
