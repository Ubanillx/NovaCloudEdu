package com.novacloudedu.backend.application.file.query;

import com.novacloudedu.backend.domain.file.entity.FileUpload;
import com.novacloudedu.backend.domain.file.repository.FileUploadRepository;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetFileQuery {

    private final FileUploadRepository fileUploadRepository;

    public Optional<FileUpload> execute(Long fileId) {
        return fileUploadRepository.findById(fileId);
    }

    public List<FileUpload> executeByUploaderId(UserId uploaderId, int page, int size) {
        return fileUploadRepository.findByUploaderId(uploaderId, page, size);
    }

    public List<FileUpload> executeByBusinessType(FileBusinessType businessType, int page, int size) {
        return fileUploadRepository.findByBusinessType(businessType, page, size);
    }
}
