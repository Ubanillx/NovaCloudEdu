package com.novacloudedu.backend.interfaces.rest.teacher;

import com.novacloudedu.backend.application.teacher.command.ApplyTeacherCommand;
import com.novacloudedu.backend.application.teacher.command.UpdateTeacherCommand;
import com.novacloudedu.backend.application.teacher.query.GetTeacherQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.teacher.entity.Teacher;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.teacher.assembler.TeacherAssembler;
import com.novacloudedu.backend.interfaces.rest.teacher.dto.ApplyTeacherRequest;
import com.novacloudedu.backend.interfaces.rest.teacher.dto.TeacherResponse;
import com.novacloudedu.backend.interfaces.rest.teacher.dto.UpdateTeacherRequest;
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
@RequestMapping("/api/teacher")
@RequiredArgsConstructor
@Tag(name = "讲师管理", description = "讲师相关接口")
public class TeacherController {

    private final ApplyTeacherCommand applyTeacherCommand;
    private final UpdateTeacherCommand updateTeacherCommand;
    private final GetTeacherQuery getTeacherQuery;
    private final TeacherAssembler teacherAssembler;

    @PostMapping("/apply")
    @Operation(summary = "申请成为讲师")
    public BaseResponse<Long> applyTeacher(@Valid @RequestBody ApplyTeacherRequest request,
                                           Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        Long applicationId = applyTeacherCommand.execute(
                UserId.of(userId),
                request.getName(),
                request.getIntroduction(),
                request.getExpertise(),
                request.getCertificateUrl()
        );
        return ResultUtils.success(applicationId);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取讲师信息")
    public BaseResponse<TeacherResponse> getTeacher(@PathVariable @Parameter(description = "讲师ID") Long id) {
        Teacher teacher = getTeacherQuery.execute(TeacherId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        return ResultUtils.success(teacherAssembler.toTeacherResponse(teacher));
    }

    @GetMapping("/user/{userId}")
    @Operation(summary = "根据用户ID获取讲师信息")
    public BaseResponse<TeacherResponse> getTeacherByUserId(@PathVariable @Parameter(description = "用户ID") Long userId) {
        Teacher teacher = getTeacherQuery.executeByUserId(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        return ResultUtils.success(teacherAssembler.toTeacherResponse(teacher));
    }

    @GetMapping("/list")
    @Operation(summary = "获取讲师列表")
    public BaseResponse<List<TeacherResponse>> listTeachers(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {
        List<Teacher> teachers = getTeacherQuery.executeList(page, size);
        List<TeacherResponse> responses = teachers.stream()
                .map(teacherAssembler::toTeacherResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新讲师信息")
    public BaseResponse<Void> updateTeacher(@PathVariable @Parameter(description = "讲师ID") Long id,
                                           @Valid @RequestBody UpdateTeacherRequest request,
                                           Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        Teacher teacher = getTeacherQuery.execute(TeacherId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        
        if (!teacher.getUserId().value().equals(userId)) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR);
        }

        updateTeacherCommand.execute(
                TeacherId.of(id),
                request.getName(),
                request.getIntroduction(),
                request.getExpertise()
        );
        return ResultUtils.success(null);
    }

    @GetMapping("/my")
    @Operation(summary = "获取当前用户的讲师信息")
    public BaseResponse<TeacherResponse> getMyTeacher(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        Teacher teacher = getTeacherQuery.executeByUserId(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        return ResultUtils.success(teacherAssembler.toTeacherResponse(teacher));
    }
}
