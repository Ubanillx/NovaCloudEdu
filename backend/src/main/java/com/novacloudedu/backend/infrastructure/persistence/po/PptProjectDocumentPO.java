package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * PPT项目文档持久化对象
 */
@TableName("ppt_project_document")
@Data
public class PptProjectDocumentPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long projectId;

    private String fileName;

    private String fileUrl;

    private String fileType;

    private Long fileSize;

    private String content;

    private LocalDateTime createTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
