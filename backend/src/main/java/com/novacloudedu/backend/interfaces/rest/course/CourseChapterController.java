package com.novacloudedu.backend.interfaces.rest.course;

import com.novacloudedu.backend.application.course.command.CreateChapterCommand;
import com.novacloudedu.backend.application.course.command.UpdateChapterCommand;
import com.novacloudedu.backend.application.course.query.GetChapterQuery;
import com.novacloudedu.backend.application.course.query.GetSectionQuery;
import com.novacloudedu.backend.application.service.CourseApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.course.assembler.ChapterAssembler;
import com.novacloudedu.backend.interfaces.rest.course.dto.ChapterResponse;
import com.novacloudedu.backend.interfaces.rest.course.dto.CreateChapterRequest;
import com.novacloudedu.backend.interfaces.rest.course.dto.UpdateChapterRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/course/{courseId}/chapter")
@RequiredArgsConstructor
@Tag(name = "课程章节", description = "课程章节相关接口")
public class CourseChapterController {

    private final CourseApplicationService courseApplicationService;
    private final GetChapterQuery getChapterQuery;
    private final GetSectionQuery getSectionQuery;
    private final ChapterAssembler chapterAssembler;

    @PostMapping
    @Operation(summary = "创建章节（管理员）")
    public BaseResponse<Long> createChapter(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                           @Valid @RequestBody CreateChapterRequest request,
                                           Authentication authentication) {
        Long adminId = Long.parseLong(authentication.getName());
        CreateChapterCommand command = new CreateChapterCommand(
                courseId, request.getTitle(), request.getDescription(), request.getSort()
        );
        Long chapterId = courseApplicationService.createChapter(command, UserId.of(adminId));
        courseApplicationService.refreshCourseStatistics(courseId);
        return ResultUtils.success(chapterId);
    }

    @PutMapping("/{chapterId}")
    @Operation(summary = "更新章节（管理员）")
    public BaseResponse<Void> updateChapter(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                           @PathVariable @Parameter(description = "章节ID") Long chapterId,
                                           @Valid @RequestBody UpdateChapterRequest request) {
        UpdateChapterCommand command = new UpdateChapterCommand(
                chapterId, request.getTitle(), request.getDescription(), request.getSort()
        );
        courseApplicationService.updateChapter(command);
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{chapterId}")
    @Operation(summary = "删除章节（管理员）")
    public BaseResponse<Void> deleteChapter(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                           @PathVariable @Parameter(description = "章节ID") Long chapterId) {
        courseApplicationService.deleteChapter(chapterId);
        courseApplicationService.refreshCourseStatistics(courseId);
        return ResultUtils.success(null);
    }

    @GetMapping("/{chapterId}")
    @Operation(summary = "获取章节详情")
    public BaseResponse<ChapterResponse> getChapter(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                                   @PathVariable @Parameter(description = "章节ID") Long chapterId) {
        CourseChapter chapter = getChapterQuery.execute(chapterId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        
        List<CourseSection> sections = getSectionQuery.executeByChapterId(chapterId);
        ChapterResponse response = chapterAssembler.toChapterResponse(chapter, sections);
        return ResultUtils.success(response);
    }

    @GetMapping
    @Operation(summary = "获取课程的章节列表")
    public BaseResponse<List<ChapterResponse>> listChapters(@PathVariable @Parameter(description = "课程ID") Long courseId) {
        List<CourseChapter> chapters = getChapterQuery.executeByCourseId(courseId);
        
        List<ChapterResponse> responses = chapters.stream()
                .map(chapter -> {
                    List<CourseSection> sections = getSectionQuery.executeByChapterId(chapter.getId().value());
                    return chapterAssembler.toChapterResponse(chapter, sections);
                })
                .collect(Collectors.toList());
        
        return ResultUtils.success(responses);
    }
}
