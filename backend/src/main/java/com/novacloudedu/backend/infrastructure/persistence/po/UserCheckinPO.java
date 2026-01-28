package com.novacloudedu.backend.infrastructure.persistence.po;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 用户打卡记录持久化对象
 */
@Data
public class UserCheckinPO {
    private Long id;
    private Long userId;
    private LocalDate checkinDate;
    private LocalDateTime checkinTime;
    private Integer streakDays;
    private LocalDateTime createTime;
}
