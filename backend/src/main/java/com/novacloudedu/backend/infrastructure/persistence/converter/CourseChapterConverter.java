package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.CourseChapterPO;
import org.springframework.stereotype.Component;

@Component
public class CourseChapterConverter {

    public CourseChapterPO toChapterPO(CourseChapter chapter) {
        CourseChapterPO po = new CourseChapterPO();
        if (chapter.getId() != null) {
            po.setId(chapter.getId().value());
        }
        po.setCourseId(chapter.getCourseId().value());
        po.setTitle(chapter.getTitle());
        po.setDescription(chapter.getDescription());
        po.setSort(chapter.getSort());
        po.setAdminId(chapter.getAdminId().value());
        po.setCreateTime(chapter.getCreateTime());
        po.setUpdateTime(chapter.getUpdateTime());
        return po;
    }

    public CourseChapter toChapter(CourseChapterPO po) {
        return CourseChapter.reconstruct(
                ChapterId.of(po.getId()),
                CourseId.of(po.getCourseId()),
                po.getTitle(),
                po.getDescription(),
                po.getSort(),
                UserId.of(po.getAdminId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
