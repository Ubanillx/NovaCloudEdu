package com.novacloudedu.backend.domain.checkin.repository;

import com.novacloudedu.backend.domain.checkin.entity.UserCheckin;
import com.novacloudedu.backend.domain.checkin.entity.UserCheckinStats;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * 打卡仓储接口
 */
public interface CheckinRepository {

    /**
     * 保存打卡记录
     */
    UserCheckin saveCheckin(UserCheckin checkin);

    /**
     * 保存打卡统计
     */
    UserCheckinStats saveStats(UserCheckinStats stats);

    /**
     * 根据用户ID和日期查询打卡记录
     */
    Optional<UserCheckin> findCheckinByUserIdAndDate(UserId userId, LocalDate date);

    /**
     * 根据用户ID查询打卡统计
     */
    Optional<UserCheckinStats> findStatsByUserId(UserId userId);

    /**
     * 获取打卡排行榜（按累计打卡天数）
     */
    List<CheckinRankingItem> getCheckinRanking(int limit);

    /**
     * 获取用户打卡历史
     */
    List<UserCheckin> findCheckinHistory(UserId userId, int page, int size);

    /**
     * 打卡排行榜项
     */
    record CheckinRankingItem(
            Long userId,
            String userName,
            String userAvatar,
            int totalCheckinDays,
            int currentStreak,
            int rank
    ) {}
}
