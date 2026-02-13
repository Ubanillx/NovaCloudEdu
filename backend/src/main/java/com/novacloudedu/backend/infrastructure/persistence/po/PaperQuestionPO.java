package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 试卷题目关联持久化对象（PO）
 */
@TableName(value = "paper_question")
@Data
public class PaperQuestionPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long sectionId;

    private Long questionId;

    private Integer score;

    private Integer sortOrder;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
