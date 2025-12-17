package com.novacloudedu.backend.interfaces.rest.course.assembler;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.entity.CourseReview;
import com.novacloudedu.backend.interfaces.rest.course.dto.CourseResponse;
import com.novacloudedu.backend.interfaces.rest.course.dto.CourseReviewResponse;
import org.springframework.stereotype.Component;

@Component
public class CourseAssembler {

    public CourseResponse toCourseResponse(Course course) {
        return CourseResponse.builder()
                .id(course.getId().value())
                .title(course.getTitle())
                .subtitle(course.getSubtitle())
                .description(course.getDescription())
                .coverImage(course.getCoverImage())
                .price(course.getPrice())
                .courseType(course.getCourseType().getCode())
                .courseTypeDesc(course.getCourseType().getDescription())
                .difficulty(course.getDifficulty().getCode())
                .difficultyDesc(course.getDifficulty().getDescription())
                .status(course.getStatus().getCode())
                .statusDesc(course.getStatus().getDescription())
                .teacherId(course.getTeacherId().value())
                .totalDuration(course.getTotalDuration())
                .totalChapters(course.getTotalChapters())
                .totalSections(course.getTotalSections())
                .studentCount(course.getStudentCount())
                .ratingScore(course.getRatingScore())
                .tags(course.getTags())
                .createTime(course.getCreateTime())
                .updateTime(course.getUpdateTime())
                .build();
    }

    public CourseReviewResponse toReviewResponse(CourseReview review) {
        return CourseReviewResponse.builder()
                .id(review.getId())
                .userId(review.getUserId().value())
                .courseId(review.getCourseId().value())
                .rating(review.getRating())
                .createTime(review.getCreateTime())
                .updateTime(review.getUpdateTime())
                .build();
    }
}
