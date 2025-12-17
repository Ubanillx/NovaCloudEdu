package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.clazz.entity.ClassCourse;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassCoursePO;
import org.springframework.stereotype.Component;

@Component
public class ClassCourseConverter {

    public ClassCoursePO toPO(ClassCourse domain) {
        if (domain == null) {
            return null;
        }
        ClassCoursePO po = new ClassCoursePO();
        po.setId(domain.getId());
        if (domain.getClassId() != null) {
            po.setClassId(domain.getClassId().getValue());
        }
        if (domain.getCourseId() != null) {
            po.setCourseId(domain.getCourseId().value());
        }
        po.setCreateTime(domain.getCreateTime());
        po.setUpdateTime(domain.getUpdateTime());
        po.setIsDelete(domain.isDelete() ? 1 : 0);
        return po;
    }

    public ClassCourse toDomain(ClassCoursePO po) {
        if (po == null) {
            return null;
        }
        return ClassCourse.reconstruct(
                po.getId(),
                ClassId.of(po.getClassId()),
                CourseId.of(po.getCourseId()),
                po.getCreateTime(),
                po.getUpdateTime(),
                po.getIsDelete() != null && po.getIsDelete() == 1
        );
    }
}
