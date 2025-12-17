package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.CourseSectionPO;
import org.springframework.stereotype.Component;

@Component
public class CourseSectionConverter {

    public CourseSectionPO toSectionPO(CourseSection section) {
        CourseSectionPO po = new CourseSectionPO();
        if (section.getId() != null) {
            po.setId(section.getId().value());
        }
        po.setCourseId(section.getCourseId().value());
        po.setChapterId(section.getChapterId().value());
        po.setTitle(section.getTitle());
        po.setDescription(section.getDescription());
        po.setVideoUrl(section.getVideoUrl());
        po.setDuration(section.getDuration());
        po.setSort(section.getSort());
        po.setIsFree(section.getIsFree() ? 1 : 0);
        po.setResourceUrl(section.getResourceUrl());
        po.setAdminId(section.getAdminId().value());
        po.setCreateTime(section.getCreateTime());
        po.setUpdateTime(section.getUpdateTime());
        return po;
    }

    public CourseSection toSection(CourseSectionPO po) {
        return CourseSection.reconstruct(
                SectionId.of(po.getId()),
                CourseId.of(po.getCourseId()),
                ChapterId.of(po.getChapterId()),
                po.getTitle(),
                po.getDescription(),
                po.getVideoUrl(),
                po.getDuration(),
                po.getSort(),
                po.getIsFree() == 1,
                po.getResourceUrl(),
                UserId.of(po.getAdminId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
