package com.novacloudedu.backend.domain.checkin.entity;

import com.novacloudedu.backend.domain.checkin.valueobject.CheckinId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 用户打卡记录实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserCheckin {

    private CheckinId id;
    private UserId userId;
    private LocalDate checkinDate;
    private LocalDateTime checkinTime;
    private int streakDays;
    private LocalDateTime createTime;

    /**
     * 创建打卡记录
     */
    public static UserCheckin create(UserId userId, int streakDays) {
        UserCheckin checkin = new UserCheckin();
        checkin.userId = userId;
        checkin.checkinDate = LocalDate.now();
        checkin.checkinTime = LocalDateTime.now();
        checkin.streakDays = streakDays;
        checkin.createTime = LocalDateTime.now();
        return checkin;
    }

    /**
     * 从持久化数据重建
     */
    public static UserCheckin reconstruct(CheckinId id, UserId userId, LocalDate checkinDate,
                                          LocalDateTime checkinTime, int streakDays, LocalDateTime createTime) {
        UserCheckin checkin = new UserCheckin();
        checkin.id = id;
        checkin.userId = userId;
        checkin.checkinDate = checkinDate;
        checkin.checkinTime = checkinTime;
        checkin.streakDays = streakDays;
        checkin.createTime = createTime;
        return checkin;
    }

    /**
     * 分配ID
     */
    public void assignId(CheckinId id) {
        if (this.id != null) {
            throw new IllegalStateException("打卡记录ID已分配");
        }
        this.id = id;
    }
}
