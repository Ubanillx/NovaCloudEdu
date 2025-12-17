package com.novacloudedu.backend.interfaces.rest.course;

import com.novacloudedu.backend.application.course.command.*;
import com.novacloudedu.backend.application.course.query.GetCourseQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.valueobject.CourseDifficulty;
import com.novacloudedu.backend.domain.course.valueobject.CourseStatus;
import com.novacloudedu.backend.domain.course.valueobject.CourseType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.course.assembler.CourseAssembler;
import com.novacloudedu.backend.interfaces.rest.course.dto.CourseResponse;
import com.novacloudedu.backend.interfaces.rest.course.dto.CreateCourseRequest;
import com.novacloudedu.backend.interfaces.rest.course.dto.UpdateCourseRequest;
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
@RequestMapping("/api/course")
@RequiredArgsConstructor
@Tag(name = "课程管理", description = "课程相关接口")
public class CourseController {

    private final CreateCourseCommand createCourseCommand;
    private final UpdateCourseCommand updateCourseCommand;
    private final PublishCourseCommand publishCourseCommand;
    private final TakeOfflineCourseCommand takeOfflineCourseCommand;
    private final DeleteCourseCommand deleteCourseCommand;
    private final GetCourseQuery getCourseQuery;
    private final CourseAssembler courseAssembler;

    @PostMapping
    @Operation(summary = "创建课程（管理员）")
    public BaseResponse<Long> createCourse(@Valid @RequestBody CreateCourseRequest request,
                                          Authentication authentication) {
        Long adminId = Long.parseLong(authentication.getName());
        Long courseId = createCourseCommand.execute(
                request.getTitle(),
                request.getSubtitle(),
                request.getDescription(),
                request.getCoverImage(),
                request.getPrice(),
                CourseType.fromCode(request.getCourseType()),
                CourseDifficulty.fromCode(request.getDifficulty()),
                request.getTeacherId(),
                request.getTags(),
                UserId.of(adminId)
        );
        return ResultUtils.success(courseId);
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新课程（管理员）")
    public BaseResponse<Void> updateCourse(@PathVariable @Parameter(description = "课程ID") Long id,
                                          @Valid @RequestBody UpdateCourseRequest request) {
        updateCourseCommand.execute(
                id,
                request.getTitle(),
                request.getSubtitle(),
                request.getDescription(),
                request.getCoverImage(),
                request.getPrice(),
                CourseType.fromCode(request.getCourseType()),
                CourseDifficulty.fromCode(request.getDifficulty()),
                request.getTags()
        );
        return ResultUtils.success(null);
    }

    @PostMapping("/{id}/publish")
    @Operation(summary = "发布课程（管理员）")
    public BaseResponse<Void> publishCourse(@PathVariable @Parameter(description = "课程ID") Long id) {
        publishCourseCommand.execute(id);
        return ResultUtils.success(null);
    }

    @PostMapping("/{id}/offline")
    @Operation(summary = "下架课程（管理员）")
    public BaseResponse<Void> takeOffline(@PathVariable @Parameter(description = "课程ID") Long id) {
        takeOfflineCourseCommand.execute(id);
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除课程（管理员）")
    public BaseResponse<Void> deleteCourse(@PathVariable @Parameter(description = "课程ID") Long id) {
        deleteCourseCommand.execute(id);
        return ResultUtils.success(null);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取课程详情")
    public BaseResponse<CourseResponse> getCourse(@PathVariable @Parameter(description = "课程ID") Long id) {
        Course course = getCourseQuery.execute(id)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        return ResultUtils.success(courseAssembler.toCourseResponse(course));
    }

    @GetMapping("/list")
    @Operation(summary = "获取课程列表")
    public BaseResponse<List<CourseResponse>> listCourses(
            @RequestParam(required = false) @Parameter(description = "状态：0-未发布，1-已发布，2-已下架") Integer status,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {
        
        List<Course> courses;
        if (status != null) {
            courses = getCourseQuery.executeByStatus(CourseStatus.fromCode(status), page, size);
        } else {
            courses = getCourseQuery.executeList(page, size);
        }

        List<CourseResponse> responses = courses.stream()
                .map(courseAssembler::toCourseResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/teacher/{teacherId}")
    @Operation(summary = "获取讲师的课程列表")
    public BaseResponse<List<CourseResponse>> listCoursesByTeacher(
            @PathVariable @Parameter(description = "讲师ID") Long teacherId,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {
        
        List<Course> courses = getCourseQuery.executeByTeacherId(teacherId, page, size);
        List<CourseResponse> responses = courses.stream()
                .map(courseAssembler::toCourseResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/search")
    @Operation(summary = "搜索课程")
    public BaseResponse<List<CourseResponse>> searchCourses(
            @RequestParam @Parameter(description = "关键词") String keyword,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {
        
        List<Course> courses = getCourseQuery.searchByKeyword(keyword, page, size);
        List<CourseResponse> responses = courses.stream()
                .map(courseAssembler::toCourseResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }
}
