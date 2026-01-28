package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 文件读写节点配置请求
 */
@Data
@Schema(description = "文件读写节点配置")
public class FileNodeConfigRequest {

    @Schema(description = "操作类型", example = "READ", 
            allowableValues = {"READ", "WRITE", "APPEND", "DELETE", "EXISTS", "LIST"})
    private String operation;

    @Schema(description = "文件路径，支持变量替换", example = "/data/output/${fileName}.txt")
    private String filePath;

    @Schema(description = "文件路径变量名")
    private String filePathVariable;

    @Schema(description = "存储类型", example = "LOCAL", 
            allowableValues = {"LOCAL", "OSS", "S3", "MINIO"})
    private String storageType;

    @Schema(description = "存储桶名称（云存储）", example = "my-bucket")
    private String bucket;

    @Schema(description = "读取编码", example = "UTF-8")
    private String encoding;

    @Schema(description = "读取内容的输出变量名", example = "fileContent")
    private String outputVariable;

    @Schema(description = "写入内容变量名", example = "contentToWrite")
    private String contentVariable;

    @Schema(description = "写入内容（直接指定）")
    private String content;

    @Schema(description = "是否创建目录", example = "true")
    private Boolean createDirectories;

    @Schema(description = "文件存在时的处理策略", example = "OVERWRITE", 
            allowableValues = {"OVERWRITE", "SKIP", "ERROR", "RENAME"})
    private String existsStrategy;

    @Schema(description = "读取模式", example = "TEXT", 
            allowableValues = {"TEXT", "BINARY", "LINES", "JSON"})
    private String readMode;

    @Schema(description = "最大读取大小（字节）", example = "10485760")
    private Long maxReadSize;
}
