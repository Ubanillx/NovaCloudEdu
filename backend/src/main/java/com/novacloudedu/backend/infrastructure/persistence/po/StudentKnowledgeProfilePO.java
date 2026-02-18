package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@TableName(value = "student_knowledge_profile", autoResultMap = true)
@Data
public class StudentKnowledgeProfilePO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long studentId;

    private String subject;

    private String knowledgePoint;

    private Double masteryLevel;

    private Integer totalAttempts;

    private Integer correctCount;

    @TableField(typeHandler = com.novacloudedu.backend.infrastructure.persistence.handler.PgTextArrayTypeHandler.class)
    private List<String> recentErrorCategories;

    private LocalDateTime lastUpdated;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
