package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.progress.entity.UserCourseProgress;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserCourseProgressPO;
import org.springframework.stereotype.Component;

@Component
public class UserCourseProgressConverter {

    public UserCourseProgressPO toProgressPO(UserCourseProgress progress) {
        UserCourseProgressPO po = new UserCourseProgressPO();
        if (progress.getId() != null) {
            po.setId(progress.getId());
        }
        po.setUserId(progress.getUserId().value());
        po.setCourseId(progress.getCourseId().value());
        po.setSectionId(progress.getSectionId().value());
        po.setProgress(progress.getProgress());
        po.setWatchDuration(progress.getWatchDuration());
        po.setLastPosition(progress.getLastPosition());
        po.setIsCompleted(progress.getIsCompleted() ? 1 : 0);
        po.setCompletedTime(progress.getCompletedTime());
        po.setCreateTime(progress.getCreateTime());
        po.setUpdateTime(progress.getUpdateTime());
        return po;
    }

    public UserCourseProgress toProgress(UserCourseProgressPO po) {
        return UserCourseProgress.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                CourseId.of(po.getCourseId()),
                SectionId.of(po.getSectionId()),
                po.getProgress(),
                po.getWatchDuration(),
                po.getLastPosition(),
                po.getIsCompleted() == 1,
                po.getCompletedTime(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
