package com.novacloudedu.backend.application.file.command;

import com.novacloudedu.backend.domain.file.entity.FileUpload;
import com.novacloudedu.backend.domain.file.repository.FileUploadRepository;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class DeleteFileCommand {

    private final OssService ossService;
    private final FileUploadRepository fileUploadRepository;

    @Transactional
    public void execute(Long fileId) {
        FileUpload fileUpload = fileUploadRepository.findById(fileId)
                .orElseThrow(() -> new BusinessException(40400, "文件不存在"));

        ossService.deleteFile(fileUpload.getFileUrl());
        fileUploadRepository.deleteById(fileId);
    }
}
