package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 试卷持久化对象（PO）
 */
@TableName(value = "exam_paper")
@Data
public class ExamPaperPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String title;

    private String subtitle;

    private String subject;

    private String grade;

    private Integer totalScore;

    private Integer durationMin;

    private String layout;

    private String status;

    private Long templateId;

    private Long creatorId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
