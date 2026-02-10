package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 工作流版本历史持久化对象
 */
@Data
@TableName("workflow_version")
public class WorkflowVersionPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long workflowId;

    private Integer version;

    private String name;

    private String description;

    @TableField(typeHandler = com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler.class)
    private String definition;

    private String publishNote;

    private Long publishedBy;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
}
