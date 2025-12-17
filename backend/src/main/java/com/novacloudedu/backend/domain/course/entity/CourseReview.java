package com.novacloudedu.backend.domain.course.entity;

import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CourseReview {

    private Long id;
    private UserId userId;
    private CourseId courseId;
    private Integer rating;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static CourseReview create(UserId userId, CourseId courseId, Integer rating) {
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("评分必须在1-5之间");
        }
        CourseReview review = new CourseReview();
        review.userId = userId;
        review.courseId = courseId;
        review.rating = rating;
        review.createTime = LocalDateTime.now();
        review.updateTime = LocalDateTime.now();
        return review;
    }

    public static CourseReview reconstruct(Long id, UserId userId, CourseId courseId,
                                          Integer rating, LocalDateTime createTime,
                                          LocalDateTime updateTime) {
        CourseReview review = new CourseReview();
        review.id = id;
        review.userId = userId;
        review.courseId = courseId;
        review.rating = rating;
        review.createTime = createTime;
        review.updateTime = updateTime;
        return review;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("评价ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void updateRating(Integer newRating) {
        if (newRating < 1 || newRating > 5) {
            throw new IllegalArgumentException("评分必须在1-5之间");
        }
        this.rating = newRating;
        this.updateTime = LocalDateTime.now();
    }
}
