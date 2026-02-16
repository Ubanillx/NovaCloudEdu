package com.novacloudedu.backend.interfaces.rest.course;

import com.novacloudedu.backend.application.course.query.GetChapterQuery;
import com.novacloudedu.backend.application.course.query.GetCourseQuery;
import com.novacloudedu.backend.application.course.query.GetSectionQuery;
import com.novacloudedu.backend.application.course.service.VideoUrlService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.CourseType;
import com.novacloudedu.backend.domain.order.repository.UserCourseRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.course.assembler.ChapterAssembler;
import com.novacloudedu.backend.interfaces.rest.course.assembler.CourseAssembler;
import com.novacloudedu.backend.interfaces.rest.course.dto.ChapterResponse;
import com.novacloudedu.backend.interfaces.rest.course.dto.CourseStructureResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
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
    private final UserCourseRepository userCourseRepository;
    private final VideoUrlService videoUrlService;

    @GetMapping("/{courseId}/structure")
    @Operation(summary = "获取课程完整结构（课程+章节+小节）")
    public BaseResponse<CourseStructureResponse> getCourseStructure(
            @PathVariable @Parameter(description = "课程ID") Long courseId,
            Authentication authentication) {
        
        Course course = getCourseQuery.execute(courseId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        
        // 判断用户是否有权访问付费内容
        boolean hasAccess = determineAccess(course, authentication);
        
        List<CourseChapter> chapters = getChapterQuery.executeByCourseId(courseId);
        
        List<ChapterResponse> chapterResponses = chapters.stream()
                .map(chapter -> {
                    List<CourseSection> sections = getSectionQuery.executeByChapterId(chapter.getId().value());
                    ChapterResponse chapterResponse = chapterAssembler.toChapterResponse(chapter, sections);
                    // 根据权限过滤小节的 videoUrl 和 resourceUrl
                    if (chapterResponse.getSections() != null) {
                        chapterResponse.getSections().forEach(s -> videoUrlService.filterByAccess(s, hasAccess));
                    }
                    return chapterResponse;
                })
                .collect(Collectors.toList());
        
        CourseStructureResponse response = CourseStructureResponse.builder()
                .course(courseAssembler.toCourseResponse(course))
                .chapters(chapterResponses)
                .build();
        
        return ResultUtils.success(response);
    }

    /**
     * 判断当前用户是否有权访问课程的付费内容
     * 公开课(FREE) → 所有人可访问
     * 付费课(PAID)/会员课(MEMBER) → 需已购买
     */
    private boolean determineAccess(Course course, Authentication authentication) {
        if (course.getCourseType() == CourseType.FREE) {
            return true;
        }
        if (authentication == null || authentication.getName() == null) {
            return false;
        }
        Long userId = Long.parseLong(authentication.getName());
        return userCourseRepository.existsByUserIdAndCourseId(
                UserId.of(userId), CourseId.of(course.getId().value()));
    }
}
