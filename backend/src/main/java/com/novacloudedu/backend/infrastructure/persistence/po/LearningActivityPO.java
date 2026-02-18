package com.novacloudedu.backend.infrastructure.persistence.po;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 学习活动流水持久化对象
 */
@Data
public class LearningActivityPO {
    private Long id;
    private Long userId;
    private String activityType;
    private Long referenceId;
    private String subject;
    private Long classId;
    private Integer durationSec;
    private Integer score;
    private Integer maxScore;
    private String detail;
    private LocalDate activityDate;
    private LocalDateTime createTime;
}
