package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.progress.entity.UserCourseProgress;
import com.novacloudedu.backend.domain.progress.repository.UserCourseProgressRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.application.analytics.event.LearningActivityEvent;
import com.novacloudedu.backend.domain.analytics.valueobject.ActivityType;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 学习进度应用服务
 * 负责课程学习进度的更新、完成、重置等用例编排
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ProgressApplicationService {

    private final UserCourseProgressRepository progressRepository;
    private final CourseSectionRepository sectionRepository;
    private final ApplicationEventPublisher eventPublisher;

    @Transactional
    public void updateProgress(UserId userId, Long courseId, Long sectionId,
                               Integer lastPosition, Integer watchDuration, Integer progress) {
        sectionRepository.findById(SectionId.of(sectionId))
                .orElseThrow(() -> new BusinessException(40400, "小节不存在"));

        UserCourseProgress userProgress = progressRepository
                .findByUserIdAndSectionId(userId, SectionId.of(sectionId))
                .orElseGet(() -> UserCourseProgress.create(userId, CourseId.of(courseId), SectionId.of(sectionId)));

        userProgress.updateProgress(lastPosition, watchDuration, progress);
        progressRepository.save(userProgress);

        eventPublisher.publishEvent(LearningActivityEvent.of(
                this, userId.value(), ActivityType.COURSE_WATCH,
                courseId, null, null, watchDuration != null ? watchDuration : 0));
    }

    @Transactional
    public void completeSection(UserId userId, Long courseId, Long sectionId) {
        sectionRepository.findById(SectionId.of(sectionId))
                .orElseThrow(() -> new BusinessException(40400, "小节不存在"));

        UserCourseProgress progress = progressRepository
                .findByUserIdAndSectionId(userId, SectionId.of(sectionId))
                .orElseGet(() -> UserCourseProgress.create(userId, CourseId.of(courseId), SectionId.of(sectionId)));

        progress.complete();
        progressRepository.save(progress);
    }

    @Transactional
    public void resetProgress(UserId userId, Long sectionId) {
        UserCourseProgress progress = progressRepository
                .findByUserIdAndSectionId(userId, SectionId.of(sectionId))
                .orElseThrow(() -> new BusinessException(40400, "学习进度不存在"));

        progress.reset();
        progressRepository.save(progress);
    }
}
