package com.novacloudedu.backend.domain.progress.entity;

import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class UserCourseProgress {

    private Long id;
    private final UserId userId;
    private final CourseId courseId;
    private final SectionId sectionId;
    private Integer progress;
    private Integer watchDuration;
    private Integer lastPosition;
    private Boolean isCompleted;
    private LocalDateTime completedTime;
    private final LocalDateTime createTime;
    private LocalDateTime updateTime;

    private UserCourseProgress(Long id, UserId userId, CourseId courseId, SectionId sectionId,
                              Integer progress, Integer watchDuration, Integer lastPosition,
                              Boolean isCompleted, LocalDateTime completedTime,
                              LocalDateTime createTime, LocalDateTime updateTime) {
        this.id = id;
        this.userId = userId;
        this.courseId = courseId;
        this.sectionId = sectionId;
        this.progress = progress;
        this.watchDuration = watchDuration;
        this.lastPosition = lastPosition;
        this.isCompleted = isCompleted;
        this.completedTime = completedTime;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public static UserCourseProgress create(UserId userId, CourseId courseId, SectionId sectionId) {
        LocalDateTime now = LocalDateTime.now();
        return new UserCourseProgress(null, userId, courseId, sectionId, 0, 0, 0,
                false, null, now, now);
    }

    public static UserCourseProgress reconstruct(Long id, UserId userId, CourseId courseId,
                                                SectionId sectionId, Integer progress,
                                                Integer watchDuration, Integer lastPosition,
                                                Boolean isCompleted, LocalDateTime completedTime,
                                                LocalDateTime createTime, LocalDateTime updateTime) {
        return new UserCourseProgress(id, userId, courseId, sectionId, progress, watchDuration,
                lastPosition, isCompleted, completedTime, createTime, updateTime);
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("进度ID已存在");
        }
        this.id = id;
    }

    public void updateProgress(Integer lastPosition, Integer watchDuration, Integer progress) {
        if (lastPosition < 0 || watchDuration < 0 || progress < 0 || progress > 100) {
            throw new IllegalArgumentException("进度参数不合法");
        }
        
        this.lastPosition = lastPosition;
        this.watchDuration = watchDuration;
        this.progress = progress;
        this.updateTime = LocalDateTime.now();

        if (progress >= 100 && !this.isCompleted) {
            this.complete();
        }
    }

    public void complete() {
        this.isCompleted = true;
        this.progress = 100;
        this.completedTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }

    public void reset() {
        this.progress = 0;
        this.watchDuration = 0;
        this.lastPosition = 0;
        this.isCompleted = false;
        this.completedTime = null;
        this.updateTime = LocalDateTime.now();
    }
}
