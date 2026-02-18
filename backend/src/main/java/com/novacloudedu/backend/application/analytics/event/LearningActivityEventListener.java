package com.novacloudedu.backend.application.analytics.event;

import com.novacloudedu.backend.domain.analytics.entity.LearningActivity;
import com.novacloudedu.backend.domain.analytics.repository.LearningActivityRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

/**
 * 学习活动事件监听器
 * 异步将各模块产生的学习行为写入 learning_activity 表
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class LearningActivityEventListener {

    private final LearningActivityRepository activityRepository;

    @Async
    @EventListener
    public void handleLearningActivityEvent(LearningActivityEvent event) {
        try {
            LearningActivity activity = LearningActivity.create(
                    UserId.of(event.getUserId()),
                    event.getActivityType(),
                    event.getReferenceId(),
                    event.getSubject(),
                    event.getClassId(),
                    event.getDurationSec(),
                    event.getScore(),
                    event.getMaxScore(),
                    event.getDetail()
            );
            activityRepository.save(activity);
            log.debug("学习活动已记录: userId={}, type={}, refId={}",
                    event.getUserId(), event.getActivityType(), event.getReferenceId());
        } catch (Exception e) {
            log.error("记录学习活动失败: userId={}, type={}", event.getUserId(), event.getActivityType(), e);
        }
    }
}
