package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.entity.CourseReview;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.repository.CourseReviewRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

@Service
@RequiredArgsConstructor
public class ReviewCourseCommand {

    private final CourseReviewRepository reviewRepository;
    private final CourseRepository courseRepository;

    @Transactional
    public Long execute(UserId userId, Long courseId, Integer rating) {
        Course course = courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        if (reviewRepository.existsByUserIdAndCourseId(userId, CourseId.of(courseId))) {
            throw new BusinessException(40331, "已评价过该课程");
        }

        CourseReview review = CourseReview.create(userId, CourseId.of(courseId), rating);
        reviewRepository.save(review);

        BigDecimal avgRating = reviewRepository.calculateAverageRating(CourseId.of(courseId));
        course.updateRating(avgRating);
        courseRepository.save(course);

        return review.getId();
    }
}
