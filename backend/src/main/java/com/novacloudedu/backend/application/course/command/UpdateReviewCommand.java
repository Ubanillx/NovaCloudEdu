package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.entity.CourseReview;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.repository.CourseReviewRepository;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

@Service
@RequiredArgsConstructor
public class UpdateReviewCommand {

    private final CourseReviewRepository reviewRepository;
    private final CourseRepository courseRepository;

    @Transactional
    public void execute(Long reviewId, Integer newRating) {
        CourseReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new BusinessException(40400, "评价不存在"));

        review.updateRating(newRating);
        reviewRepository.save(review);

        BigDecimal avgRating = reviewRepository.calculateAverageRating(review.getCourseId());
        Course course = courseRepository.findById(review.getCourseId())
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));
        course.updateRating(avgRating);
        courseRepository.save(course);
    }
}
