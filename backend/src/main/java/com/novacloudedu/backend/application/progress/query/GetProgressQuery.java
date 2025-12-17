package com.novacloudedu.backend.application.progress.query;

import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.progress.entity.UserCourseProgress;
import com.novacloudedu.backend.domain.progress.repository.UserCourseProgressRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetProgressQuery {

    private final UserCourseProgressRepository progressRepository;

    public Optional<UserCourseProgress> execute(Long progressId) {
        return progressRepository.findById(progressId);
    }

    public Optional<UserCourseProgress> executeByUserIdAndSectionId(UserId userId, Long sectionId) {
        return progressRepository.findByUserIdAndSectionId(userId, SectionId.of(sectionId));
    }

    public List<UserCourseProgress> executeByUserIdAndCourseId(UserId userId, Long courseId) {
        return progressRepository.findByUserIdAndCourseId(userId, CourseId.of(courseId));
    }

    public List<UserCourseProgress> executeByCourseId(Long courseId, int page, int size) {
        return progressRepository.findByCourseId(CourseId.of(courseId), page, size);
    }

    public long countCompletedSections(UserId userId, Long courseId) {
        return progressRepository.countCompletedSectionsByUserIdAndCourseId(userId, CourseId.of(courseId));
    }

    public long countTotalSections(Long courseId) {
        return progressRepository.countTotalSectionsByCourseId(CourseId.of(courseId));
    }

    public int calculateCourseProgress(UserId userId, Long courseId) {
        return progressRepository.calculateCourseProgress(userId, CourseId.of(courseId));
    }
}
