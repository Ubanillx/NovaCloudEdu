package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 试卷模板持久化对象（PO）
 */
@TableName(value = "exam_template")
@Data
public class ExamTemplatePO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String name;

    private String description;

    private String templateUrl;

    private String coverUrl;

    private Long creatorId;

    private Boolean isSystem;

    private Boolean isEnabled;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
