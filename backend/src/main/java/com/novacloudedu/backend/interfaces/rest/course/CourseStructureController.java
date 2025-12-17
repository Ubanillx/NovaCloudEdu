package com.novacloudedu.backend.interfaces.rest.course;

import com.novacloudedu.backend.application.course.query.GetChapterQuery;
import com.novacloudedu.backend.application.course.query.GetCourseQuery;
import com.novacloudedu.backend.application.course.query.GetSectionQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.course.assembler.ChapterAssembler;
import com.novacloudedu.backend.interfaces.rest.course.assembler.CourseAssembler;
import com.novacloudedu.backend.interfaces.rest.course.dto.ChapterResponse;
import com.novacloudedu.backend.interfaces.rest.course.dto.CourseStructureResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/course")
@RequiredArgsConstructor
@Tag(name = "课程结构", description = "课程完整结构相关接口")
public class CourseStructureController {

    private final GetCourseQuery getCourseQuery;
    private final GetChapterQuery getChapterQuery;
    private final GetSectionQuery getSectionQuery;
    private final CourseAssembler courseAssembler;
    private final ChapterAssembler chapterAssembler;

    @GetMapping("/{courseId}/structure")
    @Operation(summary = "获取课程完整结构（课程+章节+小节）")
    public BaseResponse<CourseStructureResponse> getCourseStructure(
            @PathVariable @Parameter(description = "课程ID") Long courseId) {
        
        Course course = getCourseQuery.execute(courseId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        
        List<CourseChapter> chapters = getChapterQuery.executeByCourseId(courseId);
        
        List<ChapterResponse> chapterResponses = chapters.stream()
                .map(chapter -> {
                    List<CourseSection> sections = getSectionQuery.executeByChapterId(chapter.getId().value());
                    return chapterAssembler.toChapterResponse(chapter, sections);
                })
                .collect(Collectors.toList());
        
        CourseStructureResponse response = CourseStructureResponse.builder()
                .course(courseAssembler.toCourseResponse(course))
                .chapters(chapterResponses)
                .build();
        
        return ResultUtils.success(response);
    }
}
