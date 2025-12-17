package com.novacloudedu.backend.interfaces.rest.course;

import com.novacloudedu.backend.application.course.command.CreateSectionCommand;
import com.novacloudedu.backend.application.course.command.DeleteSectionCommand;
import com.novacloudedu.backend.application.course.command.UpdateCourseStatisticsCommand;
import com.novacloudedu.backend.application.course.command.UpdateSectionCommand;
import com.novacloudedu.backend.application.course.query.GetSectionQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.course.assembler.ChapterAssembler;
import com.novacloudedu.backend.interfaces.rest.course.dto.CreateSectionRequest;
import com.novacloudedu.backend.interfaces.rest.course.dto.SectionResponse;
import com.novacloudedu.backend.interfaces.rest.course.dto.UpdateSectionRequest;
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
@RequestMapping("/api/course/{courseId}/section")
@RequiredArgsConstructor
@Tag(name = "课程小节", description = "课程小节相关接口")
public class CourseSectionController {

    private final CreateSectionCommand createSectionCommand;
    private final UpdateSectionCommand updateSectionCommand;
    private final DeleteSectionCommand deleteSectionCommand;
    private final UpdateCourseStatisticsCommand updateStatisticsCommand;
    private final GetSectionQuery getSectionQuery;
    private final ChapterAssembler chapterAssembler;

    @PostMapping
    @Operation(summary = "创建小节（管理员）")
    public BaseResponse<Long> createSection(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                           @Valid @RequestBody CreateSectionRequest request,
                                           Authentication authentication) {
        Long adminId = Long.parseLong(authentication.getName());
        Long sectionId = createSectionCommand.execute(
                courseId,
                request.getChapterId(),
                request.getTitle(),
                request.getDescription(),
                request.getVideoUrl(),
                request.getDuration(),
                request.getSort(),
                request.getIsFree(),
                request.getResourceUrl(),
                UserId.of(adminId)
        );
        
        updateStatisticsCommand.execute(courseId);
        return ResultUtils.success(sectionId);
    }

    @PutMapping("/{sectionId}")
    @Operation(summary = "更新小节（管理员）")
    public BaseResponse<Void> updateSection(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                           @PathVariable @Parameter(description = "小节ID") Long sectionId,
                                           @Valid @RequestBody UpdateSectionRequest request) {
        updateSectionCommand.execute(
                sectionId,
                request.getTitle(),
                request.getDescription(),
                request.getVideoUrl(),
                request.getDuration(),
                request.getSort(),
                request.getIsFree(),
                request.getResourceUrl()
        );
        
        updateStatisticsCommand.execute(courseId);
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{sectionId}")
    @Operation(summary = "删除小节（管理员）")
    public BaseResponse<Void> deleteSection(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                           @PathVariable @Parameter(description = "小节ID") Long sectionId) {
        deleteSectionCommand.execute(sectionId);
        updateStatisticsCommand.execute(courseId);
        return ResultUtils.success(null);
    }

    @GetMapping("/{sectionId}")
    @Operation(summary = "获取小节详情")
    public BaseResponse<SectionResponse> getSection(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                                   @PathVariable @Parameter(description = "小节ID") Long sectionId) {
        CourseSection section = getSectionQuery.execute(sectionId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        
        SectionResponse response = chapterAssembler.toSectionResponse(section);
        return ResultUtils.success(response);
    }

    @GetMapping
    @Operation(summary = "获取课程的所有小节")
    public BaseResponse<List<SectionResponse>> listSections(@PathVariable @Parameter(description = "课程ID") Long courseId) {
        List<CourseSection> sections = getSectionQuery.executeByCourseId(courseId);
        
        List<SectionResponse> responses = sections.stream()
                .map(chapterAssembler::toSectionResponse)
                .collect(Collectors.toList());
        
        return ResultUtils.success(responses);
    }
}
