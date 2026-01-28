package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.checkin.entity.UserCheckin;
import com.novacloudedu.backend.domain.checkin.entity.UserCheckinStats;
import com.novacloudedu.backend.domain.checkin.repository.CheckinRepository;
import com.novacloudedu.backend.domain.checkin.repository.CheckinRepository.CheckinRankingItem;
import com.novacloudedu.backend.domain.post.repository.PostRepository;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 * 打卡应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class CheckinApplicationService {

    private final CheckinRepository checkinRepository;
    private final UserRepository userRepository;
    private final PostRepository postRepository;

    /**
     * 用户打卡
     */
    @Transactional
    public CheckinResult checkin() {
        UserId userId = getCurrentUserId();
        
        // 获取或创建打卡统计
        UserCheckinStats stats = checkinRepository.findStatsByUserId(userId)
                .orElseGet(() -> UserCheckinStats.create(userId));
        
        // 检查今天是否已打卡
        if (stats.hasCheckedInToday()) {
            throw new BusinessException(ErrorCode.OPERATION_ERROR, "今天已经打卡过了");
        }
        
        // 执行打卡
        int streakDays = stats.doCheckin();
        
        // 保存统计
        checkinRepository.saveStats(stats);
        
        // 创建打卡记录
        UserCheckin checkin = UserCheckin.create(userId, streakDays);
        checkinRepository.saveCheckin(checkin);
        
        log.info("用户打卡成功: userId={}, streakDays={}", userId.value(), streakDays);
        
        return new CheckinResult(
                true,
                streakDays,
                stats.getTotalCheckinDays(),
                stats.getMaxStreak()
        );
    }

    /**
     * 获取用户统计数据
     */
    @Transactional(readOnly = true)
    public UserStatsResult getUserStats() {
        UserId userId = getCurrentUserId();
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_EXIST));
        
        // 计算注册天数
        long registerDays = ChronoUnit.DAYS.between(user.getCreateTime().toLocalDate(), LocalDate.now()) + 1;
        
        // 获取打卡统计
        UserCheckinStats stats = checkinRepository.findStatsByUserId(userId)
                .orElse(null);
        
        int totalCheckinDays = stats != null ? stats.getTotalCheckinDays() : 0;
        int currentStreak = stats != null ? stats.getCurrentStreak() : 0;
        boolean checkedInToday = stats != null && stats.hasCheckedInToday();
        
        // 获取帖子获赞数
        long totalLikes = postRepository.countTotalLikesByUserId(userId);
        
        return new UserStatsResult(
                registerDays,
                totalCheckinDays,
                currentStreak,
                checkedInToday,
                totalLikes
        );
    }

    /**
     * 获取打卡排行榜
     */
    @Transactional(readOnly = true)
    public List<CheckinRankingItem> getCheckinRanking(int limit) {
        return checkinRepository.getCheckinRanking(Math.min(limit, 10));
    }

    /**
     * 获取当前用户打卡状态
     */
    @Transactional(readOnly = true)
    public CheckinStatusResult getCheckinStatus() {
        UserId userId = getCurrentUserId();
        
        UserCheckinStats stats = checkinRepository.findStatsByUserId(userId)
                .orElse(null);
        
        boolean checkedInToday = stats != null && stats.hasCheckedInToday();
        int currentStreak = stats != null ? stats.getCurrentStreak() : 0;
        int totalCheckinDays = stats != null ? stats.getTotalCheckinDays() : 0;
        
        return new CheckinStatusResult(checkedInToday, currentStreak, totalCheckinDays);
    }

    private UserId getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
        }
        Object principal = authentication.getPrincipal();
        if (principal instanceof Long userId) {
            return UserId.of(userId);
        }
        throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
    }

    /**
     * 打卡结果
     */
    public record CheckinResult(
            boolean success,
            int streakDays,
            int totalCheckinDays,
            int maxStreak
    ) {}

    /**
     * 用户统计数据结果
     */
    public record UserStatsResult(
            long registerDays,
            int totalCheckinDays,
            int currentStreak,
            boolean checkedInToday,
            long totalLikes
    ) {}

    /**
     * 打卡状态结果
     */
    public record CheckinStatusResult(
            boolean checkedInToday,
            int currentStreak,
            int totalCheckinDays
    ) {}
}
