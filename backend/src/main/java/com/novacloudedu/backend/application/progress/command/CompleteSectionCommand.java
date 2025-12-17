package com.novacloudedu.backend.application.progress.command;

import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.progress.entity.UserCourseProgress;
import com.novacloudedu.backend.domain.progress.repository.UserCourseProgressRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CompleteSectionCommand {

    private final UserCourseProgressRepository progressRepository;
    private final CourseSectionRepository sectionRepository;

    @Transactional
    public void execute(UserId userId, Long courseId, Long sectionId) {
        sectionRepository.findById(SectionId.of(sectionId))
                .orElseThrow(() -> new BusinessException(40400, "小节不存在"));

        UserCourseProgress progress = progressRepository
                .findByUserIdAndSectionId(userId, SectionId.of(sectionId))
                .orElseGet(() -> UserCourseProgress.create(userId, CourseId.of(courseId), SectionId.of(sectionId)));

        progress.complete();
        progressRepository.save(progress);
    }
}
