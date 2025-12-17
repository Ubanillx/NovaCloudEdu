package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.file.entity.FileUpload;
import com.novacloudedu.backend.domain.file.repository.FileUploadRepository;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.FileUploadConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.FileUploadMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.FileUploadPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class FileUploadRepositoryImpl implements FileUploadRepository {

    private final FileUploadMapper fileUploadMapper;
    private final FileUploadConverter fileUploadConverter;

    @Override
    public FileUpload save(FileUpload fileUpload) {
        FileUploadPO po = fileUploadConverter.toFileUploadPO(fileUpload);
        if (po.getId() == null) {
            fileUploadMapper.insert(po);
            fileUpload.assignId(po.getId());
        } else {
            fileUploadMapper.updateById(po);
        }
        return fileUpload;
    }

    @Override
    public Optional<FileUpload> findById(Long id) {
        FileUploadPO po = fileUploadMapper.selectById(id);
        return Optional.ofNullable(po).map(fileUploadConverter::toFileUpload);
    }

    @Override
    public Optional<FileUpload> findByFileName(String fileName) {
        LambdaQueryWrapper<FileUploadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FileUploadPO::getFileName, fileName);
        FileUploadPO po = fileUploadMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(fileUploadConverter::toFileUpload);
    }

    @Override
    public List<FileUpload> findByUploaderId(UserId uploaderId, int page, int size) {
        Page<FileUploadPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<FileUploadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FileUploadPO::getUploaderId, uploaderId.value())
                .orderByDesc(FileUploadPO::getCreateTime);
        Page<FileUploadPO> result = fileUploadMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(fileUploadConverter::toFileUpload)
                .collect(Collectors.toList());
    }

    @Override
    public List<FileUpload> findByBusinessType(FileBusinessType businessType, int page, int size) {
        Page<FileUploadPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<FileUploadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FileUploadPO::getBusinessType, businessType.getFolder())
                .orderByDesc(FileUploadPO::getCreateTime);
        Page<FileUploadPO> result = fileUploadMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(fileUploadConverter::toFileUpload)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteById(Long id) {
        fileUploadMapper.deleteById(id);
    }
}
