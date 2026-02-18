package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@TableName(value = "question_grading", autoResultMap = true)
@Data
public class QuestionGradingPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long gradingResultId;

    private Integer questionIndex;

    private String questionContent;

    private String questionType;

    private String studentAnswer;

    private String standardAnswer;

    private Integer score;

    private Integer maxScore;

    @TableField(typeHandler = com.novacloudedu.backend.infrastructure.persistence.handler.PgTextArrayTypeHandler.class)
    private List<String> errorCategories;

    private String errorDetail;

    @TableField(typeHandler = com.novacloudedu.backend.infrastructure.persistence.handler.PgTextArrayTypeHandler.class)
    private List<String> knowledgePoints;

    private String comment;

    private Long similarQuestionId;

    private LocalDateTime createTime;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
