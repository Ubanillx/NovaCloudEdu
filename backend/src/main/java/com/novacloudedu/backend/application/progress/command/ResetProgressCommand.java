package com.novacloudedu.backend.application.progress.command;

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
public class ResetProgressCommand {

    private final UserCourseProgressRepository progressRepository;

    @Transactional
    public void execute(UserId userId, Long sectionId) {
        UserCourseProgress progress = progressRepository
                .findByUserIdAndSectionId(userId, SectionId.of(sectionId))
                .orElseThrow(() -> new BusinessException(40400, "学习进度不存在"));

        progress.reset();
        progressRepository.save(progress);
    }
}
