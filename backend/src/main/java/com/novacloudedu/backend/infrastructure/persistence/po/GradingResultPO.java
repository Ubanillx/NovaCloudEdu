package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

@TableName(value = "grading_result")
@Data
public class GradingResultPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long submissionId;

    private Integer totalScore;

    private Integer maxScore;

    private String overallComment;

    private String modelId;

    private LocalDateTime gradingTime;

    private LocalDateTime createTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
