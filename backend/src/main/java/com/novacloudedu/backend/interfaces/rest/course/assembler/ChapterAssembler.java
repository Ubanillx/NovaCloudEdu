package com.novacloudedu.backend.interfaces.rest.course.assembler;

import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.interfaces.rest.course.dto.ChapterResponse;
import com.novacloudedu.backend.interfaces.rest.course.dto.SectionResponse;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ChapterAssembler {

    public ChapterResponse toChapterResponse(CourseChapter chapter, List<CourseSection> sections) {
        List<SectionResponse> sectionResponses = sections.stream()
                .map(this::toSectionResponse)
                .collect(Collectors.toList());

        return ChapterResponse.builder()
                .id(chapter.getId().value())
                .courseId(chapter.getCourseId().value())
                .title(chapter.getTitle())
                .description(chapter.getDescription())
                .sort(chapter.getSort())
                .sections(sectionResponses)
                .createTime(chapter.getCreateTime())
                .updateTime(chapter.getUpdateTime())
                .build();
    }

    public SectionResponse toSectionResponse(CourseSection section) {
        return SectionResponse.builder()
                .id(section.getId().value())
                .courseId(section.getCourseId().value())
                .chapterId(section.getChapterId().value())
                .title(section.getTitle())
                .description(section.getDescription())
                .videoUrl(section.getVideoUrl())
                .duration(section.getDuration())
                .sort(section.getSort())
                .isFree(section.getIsFree())
                .resourceUrl(section.getResourceUrl())
                .createTime(section.getCreateTime())
                .updateTime(section.getUpdateTime())
                .build();
    }
}
