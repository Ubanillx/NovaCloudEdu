package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.course.entity.CourseFavourite;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.CourseFavouritePO;
import org.springframework.stereotype.Component;

@Component
public class CourseFavouriteConverter {

    public CourseFavouritePO toCourseFavouritePO(CourseFavourite favourite) {
        CourseFavouritePO po = new CourseFavouritePO();
        if (favourite.getId() != null) {
            po.setId(favourite.getId());
        }
        po.setUserId(favourite.getUserId().value());
        po.setCourseId(favourite.getCourseId().value());
        po.setCreateTime(favourite.getCreateTime());
        po.setUpdateTime(favourite.getUpdateTime());
        return po;
    }

    public CourseFavourite toCourseFavourite(CourseFavouritePO po) {
        return CourseFavourite.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                CourseId.of(po.getCourseId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
