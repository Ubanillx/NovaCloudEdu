package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 工作流触发器持久化对象
 */
@Data
@TableName("workflow_trigger")
public class WorkflowTriggerPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long workflowId;

    private String type;

    private String name;

    private Integer enabled;

    @TableField(typeHandler = com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler.class)
    private String config;

    private LocalDateTime lastTriggeredAt;

    private Integer triggerCount;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer deleted;
}
