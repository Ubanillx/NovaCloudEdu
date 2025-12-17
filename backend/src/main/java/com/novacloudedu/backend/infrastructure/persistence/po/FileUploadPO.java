package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

@TableName(value = "file_upload")
@Data
public class FileUploadPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String fileName;

    private String originalName;

    private String fileUrl;

    private Long fileSize;

    private String contentType;

    private String businessType;

    private Long uploaderId;

    private LocalDateTime createTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
