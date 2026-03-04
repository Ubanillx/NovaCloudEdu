package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * PPT生成会话持久化对象
 */
@TableName("ppt_generation_session")
@Data
public class PptGenerationSessionPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long userId;

    private Long projectId;

    private String state;

    private String topic;

    private String outlineMarkdown;

    private String outlineJson;

    private Long templateId;

    private String templateUrl;

    private String templateJson;

    private String slidesJson;

    private String resultUrl;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
