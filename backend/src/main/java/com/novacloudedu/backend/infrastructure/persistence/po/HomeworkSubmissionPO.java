package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@TableName(value = "homework_submission", autoResultMap = true)
@Data
public class HomeworkSubmissionPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long studentId;

    private Long classId;

    private String gradingMode;

    private String title;

    private String subject;

    private String grade;

    @TableField(typeHandler = com.novacloudedu.backend.infrastructure.persistence.handler.PgTextArrayTypeHandler.class)
    private List<String> imageUrls;

    private String ocrRawText;

    private String structuredData;

    private String status;

    private Long examPaperId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
