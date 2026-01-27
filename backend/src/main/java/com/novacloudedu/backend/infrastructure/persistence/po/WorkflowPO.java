package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 工作流持久化对象
 */
@Data
@TableName("ai_workflow")
public class WorkflowPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;

    private String description;

    private String flowData;

    private String status;

    private Integer version;

    private Integer isPublic;

    private Long creatorId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    private Integer isDelete;
}
