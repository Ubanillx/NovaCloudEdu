package com.novacloudedu.backend.domain.checkin.entity;

import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 用户打卡统计实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserCheckinStats {

    private Long id;
    private UserId userId;
    private int totalCheckinDays;
    private int currentStreak;
    private int maxStreak;
    private LocalDate lastCheckinDate;
    private LocalDateTime updateTime;

    /**
     * 创建新的打卡统计
     */
    public static UserCheckinStats create(UserId userId) {
        UserCheckinStats stats = new UserCheckinStats();
        stats.userId = userId;
        stats.totalCheckinDays = 0;
        stats.currentStreak = 0;
        stats.maxStreak = 0;
        stats.lastCheckinDate = null;
        stats.updateTime = LocalDateTime.now();
        return stats;
    }

    /**
     * 从持久化数据重建
     */
    public static UserCheckinStats reconstruct(Long id, UserId userId, int totalCheckinDays,
                                               int currentStreak, int maxStreak,
                                               LocalDate lastCheckinDate, LocalDateTime updateTime) {
        UserCheckinStats stats = new UserCheckinStats();
        stats.id = id;
        stats.userId = userId;
        stats.totalCheckinDays = totalCheckinDays;
        stats.currentStreak = currentStreak;
        stats.maxStreak = maxStreak;
        stats.lastCheckinDate = lastCheckinDate;
        stats.updateTime = updateTime;
        return stats;
    }

    /**
     * 执行打卡，更新统计数据
     * @return 本次打卡的连续天数
     */
    public int doCheckin() {
        LocalDate today = LocalDate.now();
        
        // 已经打卡过了
        if (today.equals(lastCheckinDate)) {
            return currentStreak;
        }
        
        // 计算连续打卡
        if (lastCheckinDate != null && lastCheckinDate.plusDays(1).equals(today)) {
            // 连续打卡
            currentStreak++;
        } else {
            // 断签，重新开始
            currentStreak = 1;
        }
        
        // 更新最长连续记录
        if (currentStreak > maxStreak) {
            maxStreak = currentStreak;
        }
        
        // 更新总打卡天数
        totalCheckinDays++;
        lastCheckinDate = today;
        updateTime = LocalDateTime.now();
        
        return currentStreak;
    }

    /**
     * 检查今天是否已打卡
     */
    public boolean hasCheckedInToday() {
        return LocalDate.now().equals(lastCheckinDate);
    }

    /**
     * 分配ID
     */
    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("统计ID已分配");
        }
        this.id = id;
    }
}
