package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.course.entity.CourseReview;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.CourseReviewPO;
import org.springframework.stereotype.Component;

@Component
public class CourseReviewConverter {

    public CourseReviewPO toCourseReviewPO(CourseReview review) {
        CourseReviewPO po = new CourseReviewPO();
        if (review.getId() != null) {
            po.setId(review.getId());
        }
        po.setUserId(review.getUserId().value());
        po.setCourseId(review.getCourseId().value());
        po.setRating(review.getRating());
        po.setCreateTime(review.getCreateTime());
        po.setUpdateTime(review.getUpdateTime());
        return po;
    }

    public CourseReview toCourseReview(CourseReviewPO po) {
        return CourseReview.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                CourseId.of(po.getCourseId()),
                po.getRating(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
