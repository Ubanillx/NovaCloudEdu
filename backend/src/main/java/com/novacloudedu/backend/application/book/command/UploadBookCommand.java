package com.novacloudedu.backend.application.book.command;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class UploadBookCommand {

    @NotNull(message = "文件不能为空")
    private MultipartFile file;

    @NotBlank(message = "书名不能为空")
    private String title;

    private String author;

    private MultipartFile cover;

    @NotNull(message = "管理员ID不能为空")
    private Long adminId;
}
