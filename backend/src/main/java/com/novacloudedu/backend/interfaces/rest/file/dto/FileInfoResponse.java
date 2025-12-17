package com.novacloudedu.backend.interfaces.rest.file.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "文件信息响应")
public class FileInfoResponse {

    @Schema(description = "文件ID")
    private Long id;

    @Schema(description = "文件名")
    private String fileName;

    @Schema(description = "原始文件名")
    private String originalName;

    @Schema(description = "文件URL")
    private String fileUrl;

    @Schema(description = "文件大小（字节）")
    private Long fileSize;

    @Schema(description = "文件类型")
    private String contentType;

    @Schema(description = "业务类型")
    private String businessType;

    @Schema(description = "业务类型描述")
    private String businessTypeDesc;

    @Schema(description = "上传者ID")
    private Long uploaderId;

    @Schema(description = "上传时间")
    private LocalDateTime createTime;
}
