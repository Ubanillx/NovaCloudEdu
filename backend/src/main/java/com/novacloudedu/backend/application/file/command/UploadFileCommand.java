package com.novacloudedu.backend.application.file.command;

import com.novacloudedu.backend.domain.file.entity.FileUpload;
import com.novacloudedu.backend.domain.file.repository.FileUploadRepository;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UploadFileCommand {

    private final OssService ossService;
    private final FileUploadRepository fileUploadRepository;

    @Transactional
    public String execute(MultipartFile file, FileBusinessType businessType, UserId uploaderId, boolean isAdmin) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException(40000, "文件不能为空");
        }

        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null || originalFilename.isEmpty()) {
            throw new BusinessException(40000, "文件名不能为空");
        }

        long fileSize = file.getSize();
        String contentType = file.getContentType();

        FileUpload fileUpload = FileUpload.create(
                UUID.randomUUID().toString(),
                originalFilename,
                "",
                fileSize,
                contentType,
                businessType,
                uploaderId
        );

        fileUpload.validateSize(isAdmin);

        String fileUrl = ossService.uploadFile(file, businessType);
        
        FileUpload savedFile = FileUpload.create(
                fileUpload.getFileName(),
                originalFilename,
                fileUrl,
                fileSize,
                contentType,
                businessType,
                uploaderId
        );
        
        fileUploadRepository.save(savedFile);

        return fileUrl;
    }
}
