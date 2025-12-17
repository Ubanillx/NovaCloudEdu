package com.novacloudedu.backend.application.course.query;

import com.novacloudedu.backend.domain.course.entity.CourseReview;
import com.novacloudedu.backend.domain.course.repository.CourseReviewRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetCourseReviewQuery {

    private final CourseReviewRepository reviewRepository;

    public Optional<CourseReview> execute(Long reviewId) {
        return reviewRepository.findById(reviewId);
    }

    public Optional<CourseReview> executeByUserIdAndCourseId(UserId userId, Long courseId) {
        return reviewRepository.findByUserIdAndCourseId(userId, CourseId.of(courseId));
    }

    public List<CourseReview> executeByCourseId(Long courseId, int page, int size) {
        return reviewRepository.findByCourseId(CourseId.of(courseId), page, size);
    }

    public long countByCourseId(Long courseId) {
        return reviewRepository.countByCourseId(CourseId.of(courseId));
    }
}
