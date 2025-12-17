package com.novacloudedu.backend.interfaces.rest.file;

import com.novacloudedu.backend.application.file.command.DeleteFileCommand;
import com.novacloudedu.backend.application.file.command.UploadFileCommand;
import com.novacloudedu.backend.application.file.query.GetFileQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.file.entity.FileUpload;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.domain.user.valueobject.UserRole;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.file.assembler.FileAssembler;
import com.novacloudedu.backend.interfaces.rest.file.dto.FileInfoResponse;
import com.novacloudedu.backend.interfaces.rest.file.dto.UploadFileResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/file")
@RequiredArgsConstructor
@Tag(name = "文件上传", description = "文件上传管理接口")
public class FileUploadController {

    private final UploadFileCommand uploadFileCommand;
    private final DeleteFileCommand deleteFileCommand;
    private final GetFileQuery getFileQuery;
    private final UserRepository userRepository;
    private final FileAssembler fileAssembler;

    @PostMapping("/upload/{businessType}")
    @Operation(summary = "上传文件（按业务类型）")
    public BaseResponse<UploadFileResponse> uploadFile(
            @RequestParam("file") @Parameter(description = "文件") MultipartFile file,
            @PathVariable @Parameter(description = "业务类型：course/cover, course/video, course/material, user/avatar, teacher/avatar, teacher/certificate, system/document, feedback/attachment, general, chat/file, chat/group, chat/ai") String businessType,
            Authentication authentication) {
        
        Long userId = Long.parseLong(authentication.getName());
        User user = userRepository.findById(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(40400, "用户不存在"));

        boolean isAdmin = user.getRole() == UserRole.ADMIN;

        FileBusinessType type;
        try {
            type = FileBusinessType.fromFolder(businessType);
        } catch (IllegalArgumentException e) {
            throw new BusinessException(40000, "不支持的业务类型");
        }

        String fileUrl = uploadFileCommand.execute(file, type, UserId.of(userId), isAdmin);

        FileUpload fileUpload = FileUpload.create(
                file.getName(),
                file.getOriginalFilename(),
                fileUrl,
                file.getSize(),
                file.getContentType(),
                type,
                UserId.of(userId)
        );

        return ResultUtils.success(fileAssembler.toUploadFileResponse(fileUpload));
    }

    @DeleteMapping("/{fileId}")
    @Operation(summary = "删除文件")
    public BaseResponse<Void> deleteFile(@PathVariable @Parameter(description = "文件ID") Long fileId,
                                        Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        User user = userRepository.findById(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(40400, "用户不存在"));

        FileUpload fileUpload = getFileQuery.execute(fileId)
                .orElseThrow(() -> new BusinessException(40400, "文件不存在"));

        if (!fileUpload.getUploaderId().value().equals(userId) && user.getRole() != UserRole.ADMIN) {
            throw new BusinessException(40300, "无权删除此文件");
        }

        deleteFileCommand.execute(fileId);
        return ResultUtils.success(null);
    }

    @GetMapping("/my")
    @Operation(summary = "获取我的文件列表")
    public BaseResponse<List<FileInfoResponse>> getMyFiles(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size,
            Authentication authentication) {
        
        Long userId = Long.parseLong(authentication.getName());
        List<FileUpload> files = getFileQuery.executeByUploaderId(UserId.of(userId), page, size);
        
        List<FileInfoResponse> responses = files.stream()
                .map(fileAssembler::toFileInfoResponse)
                .collect(Collectors.toList());
        
        return ResultUtils.success(responses);
    }

    @GetMapping("/business-type/{businessType}")
    @Operation(summary = "按业务类型获取文件列表（管理员）")
    public BaseResponse<List<FileInfoResponse>> getFilesByBusinessType(
            @PathVariable @Parameter(description = "业务类型") String businessType,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {
        
        FileBusinessType type;
        try {
            type = FileBusinessType.fromFolder(businessType);
        } catch (IllegalArgumentException e) {
            throw new BusinessException(40000, "不支持的业务类型");
        }

        List<FileUpload> files = getFileQuery.executeByBusinessType(type, page, size);
        
        List<FileInfoResponse> responses = files.stream()
                .map(fileAssembler::toFileInfoResponse)
                .collect(Collectors.toList());
        
        return ResultUtils.success(responses);
    }
}
