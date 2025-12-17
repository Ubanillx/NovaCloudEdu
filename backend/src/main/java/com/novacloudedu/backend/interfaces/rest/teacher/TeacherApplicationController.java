package com.novacloudedu.backend.interfaces.rest.teacher;

import com.novacloudedu.backend.application.teacher.command.ApproveTeacherApplicationCommand;
import com.novacloudedu.backend.application.teacher.command.RejectTeacherApplicationCommand;
import com.novacloudedu.backend.application.teacher.query.GetTeacherApplicationQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.teacher.assembler.TeacherAssembler;
import com.novacloudedu.backend.interfaces.rest.teacher.dto.ReviewApplicationRequest;
import com.novacloudedu.backend.interfaces.rest.teacher.dto.TeacherApplicationResponse;
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
@RequestMapping("/api/teacher/application")
@RequiredArgsConstructor
@Tag(name = "讲师申请管理", description = "讲师申请审核相关接口")
public class TeacherApplicationController {

    private final ApproveTeacherApplicationCommand approveCommand;
    private final RejectTeacherApplicationCommand rejectCommand;
    private final GetTeacherApplicationQuery getApplicationQuery;
    private final TeacherAssembler teacherAssembler;

    @PostMapping("/review")
    @Operation(summary = "审核讲师申请（管理员）")
    public BaseResponse<Void> reviewApplication(@Valid @RequestBody ReviewApplicationRequest request,
                                                Authentication authentication) {
        Long reviewerId = Long.parseLong(authentication.getName());

        if (request.getApproved()) {
            approveCommand.execute(request.getApplicationId(), UserId.of(reviewerId));
        } else {
            if (request.getRejectReason() == null || request.getRejectReason().isBlank()) {
                throw new BusinessException(ErrorCode.PARAMS_ERROR, "拒绝原因不能为空");
            }
            rejectCommand.execute(request.getApplicationId(), UserId.of(reviewerId), request.getRejectReason());
        }

        return ResultUtils.success(null);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取申请详情")
    public BaseResponse<TeacherApplicationResponse> getApplication(@PathVariable @Parameter(description = "申请ID") Long id) {
        TeacherApplication application = getApplicationQuery.execute(id)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        return ResultUtils.success(teacherAssembler.toApplicationResponse(application));
    }

    @GetMapping("/my")
    @Operation(summary = "获取当前用户的申请")
    public BaseResponse<TeacherApplicationResponse> getMyApplication(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        TeacherApplication application = getApplicationQuery.executeByUserId(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        return ResultUtils.success(teacherAssembler.toApplicationResponse(application));
    }

    @GetMapping("/list")
    @Operation(summary = "获取申请列表（管理员）")
    public BaseResponse<List<TeacherApplicationResponse>> listApplications(
            @RequestParam(required = false) @Parameter(description = "状态：0-待审核，1-已通过，2-已拒绝") Integer status,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {
        
        List<TeacherApplication> applications;
        if (status != null) {
            applications = getApplicationQuery.executeByStatus(TeacherStatus.fromCode(status), page, size);
        } else {
            applications = getApplicationQuery.executeList(page, size);
        }

        List<TeacherApplicationResponse> responses = applications.stream()
                .map(teacherAssembler::toApplicationResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/pending/count")
    @Operation(summary = "获取待审核申请数量（管理员）")
    public BaseResponse<Long> getPendingCount() {
        long count = getApplicationQuery.countByStatus(TeacherStatus.PENDING);
        return ResultUtils.success(count);
    }
}
