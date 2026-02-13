package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import com.novacloudedu.backend.infrastructure.persistence.handler.PgTextArrayTypeHandler;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 题目持久化对象（PO）
 */
@TableName(value = "question", autoResultMap = true)
@Data
public class QuestionPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String type;

    private String subject;

    private String grade;

    private Integer difficulty;

    private String content;

    private String options;

    private String answer;

    private String explanation;

    @TableField(typeHandler = PgTextArrayTypeHandler.class)
    private List<String> knowledgeTags;

    private String imageUrl;

    private String source;

    private Long creatorId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
