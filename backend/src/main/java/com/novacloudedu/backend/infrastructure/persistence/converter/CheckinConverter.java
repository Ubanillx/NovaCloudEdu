package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.checkin.entity.UserCheckin;
import com.novacloudedu.backend.domain.checkin.entity.UserCheckinStats;
import com.novacloudedu.backend.domain.checkin.valueobject.CheckinId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserCheckinPO;
import com.novacloudedu.backend.infrastructure.persistence.po.UserCheckinStatsPO;

/**
 * 打卡领域对象与持久化对象转换器
 */
public class CheckinConverter {

    public static UserCheckinPO toCheckinPO(UserCheckin checkin) {
        UserCheckinPO po = new UserCheckinPO();
        if (checkin.getId() != null) {
            po.setId(checkin.getId().value());
        }
        po.setUserId(checkin.getUserId().value());
        po.setCheckinDate(checkin.getCheckinDate());
        po.setCheckinTime(checkin.getCheckinTime());
        po.setStreakDays(checkin.getStreakDays());
        po.setCreateTime(checkin.getCreateTime());
        return po;
    }

    public static UserCheckin toCheckinEntity(UserCheckinPO po) {
        if (po == null) return null;
        return UserCheckin.reconstruct(
                CheckinId.of(po.getId()),
                UserId.of(po.getUserId()),
                po.getCheckinDate(),
                po.getCheckinTime(),
                po.getStreakDays(),
                po.getCreateTime()
        );
    }

    public static UserCheckinStatsPO toStatsPO(UserCheckinStats stats) {
        UserCheckinStatsPO po = new UserCheckinStatsPO();
        po.setId(stats.getId());
        po.setUserId(stats.getUserId().value());
        po.setTotalCheckinDays(stats.getTotalCheckinDays());
        po.setCurrentStreak(stats.getCurrentStreak());
        po.setMaxStreak(stats.getMaxStreak());
        po.setLastCheckinDate(stats.getLastCheckinDate());
        po.setUpdateTime(stats.getUpdateTime());
        return po;
    }

    public static UserCheckinStats toStatsEntity(UserCheckinStatsPO po) {
        if (po == null) return null;
        return UserCheckinStats.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                po.getTotalCheckinDays(),
                po.getCurrentStreak(),
                po.getMaxStreak(),
                po.getLastCheckinDate(),
                po.getUpdateTime()
        );
    }
}
