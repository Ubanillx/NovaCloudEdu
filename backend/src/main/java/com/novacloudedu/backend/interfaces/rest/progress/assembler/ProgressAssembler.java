package com.novacloudedu.backend.interfaces.rest.progress.assembler;

import com.novacloudedu.backend.domain.progress.entity.UserCourseProgress;
import com.novacloudedu.backend.interfaces.rest.progress.dto.ProgressResponse;
import org.springframework.stereotype.Component;

@Component
public class ProgressAssembler {

    public ProgressResponse toProgressResponse(UserCourseProgress progress) {
        return ProgressResponse.builder()
                .id(progress.getId())
                .userId(progress.getUserId().value())
                .courseId(progress.getCourseId().value())
                .sectionId(progress.getSectionId().value())
                .progress(progress.getProgress())
                .watchDuration(progress.getWatchDuration())
                .lastPosition(progress.getLastPosition())
                .isCompleted(progress.getIsCompleted())
                .completedTime(progress.getCompletedTime())
                .createTime(progress.getCreateTime())
                .updateTime(progress.getUpdateTime())
                .build();
    }
}
