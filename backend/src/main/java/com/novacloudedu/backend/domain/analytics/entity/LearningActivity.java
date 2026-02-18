package com.novacloudedu.backend.domain.analytics.entity;

import com.novacloudedu.backend.domain.analytics.valueobject.ActivityType;
import com.novacloudedu.backend.domain.analytics.valueobject.LearningActivityId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 学习活动记录聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class LearningActivity {

    private LearningActivityId id;
    private UserId userId;
    private ActivityType activityType;
    private Long referenceId;
    private String subject;
    private Long classId;
    private int durationSec;
    private Integer score;
    private Integer maxScore;
    private String detail;
    private LocalDate activityDate;
    private LocalDateTime createTime;

    /**
     * 创建学习活动记录
     */
    public static LearningActivity create(UserId userId, ActivityType activityType,
                                           Long referenceId, String subject, Long classId,
                                           int durationSec, Integer score, Integer maxScore,
                                           String detail) {
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        if (activityType == null) {
            throw new IllegalArgumentException("活动类型不能为空");
        }

        LearningActivity activity = new LearningActivity();
        activity.userId = userId;
        activity.activityType = activityType;
        activity.referenceId = referenceId;
        activity.subject = subject;
        activity.classId = classId;
        activity.durationSec = Math.max(0, durationSec);
        activity.score = score;
        activity.maxScore = maxScore;
        activity.detail = detail;
        activity.activityDate = LocalDate.now();
        activity.createTime = LocalDateTime.now();
        return activity;
    }

    /**
     * 从持久化数据重建
     */
    public static LearningActivity reconstruct(LearningActivityId id, UserId userId,
                                                 ActivityType activityType, Long referenceId,
                                                 String subject, Long classId, int durationSec,
                                                 Integer score, Integer maxScore, String detail,
                                                 LocalDate activityDate, LocalDateTime createTime) {
        LearningActivity activity = new LearningActivity();
        activity.id = id;
        activity.userId = userId;
        activity.activityType = activityType;
        activity.referenceId = referenceId;
        activity.subject = subject;
        activity.classId = classId;
        activity.durationSec = durationSec;
        activity.score = score;
        activity.maxScore = maxScore;
        activity.detail = detail;
        activity.activityDate = activityDate;
        activity.createTime = createTime;
        return activity;
    }

    public void assignId(LearningActivityId id) {
        if (this.id != null) {
            throw new IllegalStateException("活动ID已分配，不可重复分配");
        }
        this.id = id;
    }
}
