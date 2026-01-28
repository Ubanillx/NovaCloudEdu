package com.novacloudedu.backend.infrastructure.persistence.po;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 用户打卡统计持久化对象
 */
@Data
public class UserCheckinStatsPO {
    private Long id;
    private Long userId;
    private Integer totalCheckinDays;
    private Integer currentStreak;
    private Integer maxStreak;
    private LocalDate lastCheckinDate;
    private LocalDateTime updateTime;
}
