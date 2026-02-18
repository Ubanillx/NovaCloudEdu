package com.novacloudedu.backend.application.analytics.event;

import com.novacloudedu.backend.domain.analytics.valueobject.ActivityType;
import lombok.Getter;
import org.springframework.context.ApplicationEvent;

/**
 * 学习活动事件
 * 各模块在关键操作完成时发布此事件，由监听器异步写入 learning_activity 表
 */
@Getter
public class LearningActivityEvent extends ApplicationEvent {

    private final Long userId;
    private final ActivityType activityType;
    private final Long referenceId;
    private final String subject;
    private final Long classId;
    private final int durationSec;
    private final Integer score;
    private final Integer maxScore;
    private final String detail;

    public LearningActivityEvent(Object source, Long userId, ActivityType activityType,
                                  Long referenceId, String subject, Long classId,
                                  int durationSec, Integer score, Integer maxScore,
                                  String detail) {
        super(source);
        this.userId = userId;
        this.activityType = activityType;
        this.referenceId = referenceId;
        this.subject = subject;
        this.classId = classId;
        this.durationSec = durationSec;
        this.score = score;
        this.maxScore = maxScore;
        this.detail = detail;
    }

    /**
     * 快捷创建（无得分）
     */
    public static LearningActivityEvent of(Object source, Long userId, ActivityType type,
                                             Long referenceId, String subject, Long classId,
                                             int durationSec) {
        return new LearningActivityEvent(source, userId, type, referenceId, subject, classId,
                durationSec, null, null, null);
    }

    /**
     * 快捷创建（含得分）
     */
    public static LearningActivityEvent withScore(Object source, Long userId, ActivityType type,
                                                    Long referenceId, String subject, Long classId,
                                                    Integer score, Integer maxScore) {
        return new LearningActivityEvent(source, userId, type, referenceId, subject, classId,
                0, score, maxScore, null);
    }
}
