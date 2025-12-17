package com.novacloudedu.backend.domain.file.repository;

import com.novacloudedu.backend.domain.file.entity.FileUpload;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface FileUploadRepository {

    FileUpload save(FileUpload fileUpload);

    Optional<FileUpload> findById(Long id);

    Optional<FileUpload> findByFileName(String fileName);

    List<FileUpload> findByUploaderId(UserId uploaderId, int page, int size);

    List<FileUpload> findByBusinessType(FileBusinessType businessType, int page, int size);

    void deleteById(Long id);
}
